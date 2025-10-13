#!/bin/sh

# Author : Xavier Lhinares

echo "Publishing the latest web build to the remote repository."
cd build/web/ || exit
git add .
NOW="$(date +'%Y/%m/%d-%H:%M:%S')"
git commit -m "$NOW: New build"
git push production master