#!/bin/sh

# Author : Xavier Lhinares

C='\033[0m'   #'0' is the "No Color" ANSI color code.
R='\033[0;31m'   #'0;31' is Red's ANSI color code.
G='\033[0;32m'   #'0;32' is Green's ANSI color code.

# Retrieve the line containing the version number and parse it.
VERSION_LINE=$(head -1 CHANGELOG.md);
VERSION_NUMBER=$(echo "$VERSION_LINE" | grep -oP "\d+\.\d+\.\d+.*");

# Compare it to the version number in pubspec.yaml
OCCURRENCES=$(grep -c "$VERSION_NUMBER" pubspec.yaml);
if [ "$OCCURRENCES" = 1 ]; then
  echo "${G}Version numbers are matching! (v$VERSION_NUMBER)$C";
  exit 0;
else
  echo "${R}The version numbers do NOT match!$C";
  exit 2;
fi;