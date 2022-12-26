#!/bin/sh

# Author : Xavier Lhinares

echo "Publishing the latest web build to the remote repository."
cd build/web/ || exit
git push production main --force