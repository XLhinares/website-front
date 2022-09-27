#!/bin/sh

# Author : Xavier Lhinares

echo "Publishing the lasted web build to git."
cd build/web/ || exit
git add .
echo "Enter a commit message."
read -r COMMIT_MESSAGE
git commit -m "$COMMIT_MESSAGE"
git push origin main
git push live main