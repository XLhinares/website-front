#!/bin/sh

# Author: Xavier Lhinares

cd build/web/ || exit
if [ -d ".git" ]; then
  echo "Deleting the git folder."
  rm -r -f .git/
fi

echo "Recreating the git folder."
git init .
git remote add production ssh://luwz4482@maine.o2switch.net:22/home2/luwz4482/repositories/bare-build.git/ && echo "Successfully created remote [production]"
git fetch
git checkout -b main
git add .
echo "Enter a commit message."
read -r COMMIT_MESSAGE
git commit -m "$COMMIT_MESSAGE"
git push --set-upstream -f production main
