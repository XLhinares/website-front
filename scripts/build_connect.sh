#!/bin/sh

# Author: Xavier Lhinares

cd build/web/ || exit
if [ -d ".git" ]; then
  echo "Deleting the git folder."
  rm -r -f .git/
fi

echo "Recreating the git folder."
git init .
git remote add production ssh://lhta5458@boeuf.o2switch.net:22/home/lhta5458/xeppelin/repositories/bare-front.git/ && echo "Successfully created remote [production]"
git fetch
git checkout -b master
git add .
NOW="$(date +'%Y/%m/%d-%H:%M:%S')"
git commit -m "$NOW: New build"
git push --set-upstream -f production master
