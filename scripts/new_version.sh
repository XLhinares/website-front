#!/bin/bash

set -e  # Exit on any error

# --- 0. Verify required files exist ---
for file in CHANGELOG.md pubspec.yaml; do
    if [ ! -f "$file" ]; then
        echo "Error: $file not found in current directory"
        exit 1
    fi
done

# --- 1. Get last version number ---
# Extract the most recent version from CHANGELOG.md
LAST_VERSION=$(grep -m 1 '^## ' CHANGELOG.md | sed 's/^## //' | tr -d '\r')

# --- 2. Check version argument ---
if [ -z "$1" ]; then
    echo "❌ Version argument is required"
    echo "Usage: $0 <version> (current: $LAST_VERSION)"
    exit 1
fi

VERSION="$1"

if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Version must be in X.Y.Z format"
    exit 1
fi

# --- 3. Check for Flutter warnings ---
echo "🔍 Running Flutter analysis..."
flutter analyze > flutter_analysis.log 2>&1 || true

# Check for warnings/errors
if grep -qiE "warning|error|⚠️|❌|analyze failed" flutter_analysis.log; then
    echo "❌ Flutter analysis found issues:" >&2
    cat flutter_analysis.log >&2
    rm -f flutter_analysis.log
    exit 1
fi

echo "✅ No Flutter warnings or errors found"
rm -f flutter_analysis.log

# --- 4. Verify we're on the dev branch ---
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "dev" ]; then
    echo "Error: This script must be run from the 'dev' branch. Current branch: $CURRENT_BRANCH"
    exit 1
fi

echo "✅ On the [dev] branch"

# --- 5. Get commits since last version ---

# Get commits since the last version was added
if [ -n "$LAST_VERSION" ]; then
    # Find the commit that added the last version to CHANGELOG.md
    LAST_VERSION_COMMIT=$(git log --all --oneline --grep="version: $LAST_VERSION" -- CHANGELOG.md | head -1 | awk '{print $1}')
    if [ -n "$LAST_VERSION_COMMIT" ]; then
        COMMITS=$(git log --pretty=format:"- %s" "$LAST_VERSION_COMMIT"..HEAD)
    else
        COMMITS=$(git log --pretty=format:"- %s")
    fi
else
    COMMITS=$(git log --pretty=format:"- %s")
fi

# Default if no commits found
[ -z "$COMMITS" ] && COMMITS="- No changes"


echo "✅ Parsed commits since last version"

# --- 6. Update CHANGELOG.md ---
NEW_ENTRY="## $VERSION

$COMMITS"
echo -e "$NEW_ENTRY\n\n$(cat CHANGELOG.md)" > CHANGELOG.md.tmp && mv CHANGELOG.md.tmp CHANGELOG.md

echo "✅ Updated CHANGELOG.md"

# --- 7. Update pubspec.yaml ---
YAML_FULL_VERSION=$(grep "^version:" pubspec.yaml | head -1)
BUILD_NUMBER=${YAML_FULL_VERSION#*+}
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))
sed -i.bak "s|^version: .*|version: ${VERSION}+${NEW_BUILD_NUMBER}|" pubspec.yaml && rm -f pubspec.yaml.bak

echo "✅ Updated pubspec.yaml"

# --- 8. Update lib/globals.dart ---
sed -i.bak "s|^const String versionNumber = \"v$LAST_VERSION\";|const String versionNumber = \"v$VERSION\";|" lib/globals.dart && rm -f lib/globals.dart.bak

echo "✅ Updated lib/globals.dart"

# --- 9. Commit changes ---
git add CHANGELOG.md pubspec.yaml lib/globals.dart
git commit -m "version: $VERSION"
git push || { echo "❌ Failed to push to dev"; exit 1; }

# --- 10. Merge dev into main ---
git checkout main
git merge dev --no-edit
git push || { echo "❌ Failed to push to main"; exit 1; }
git checkout dev

echo "✅ Successfully released version: $VERSION"