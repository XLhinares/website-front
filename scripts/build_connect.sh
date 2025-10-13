#!/bin/sh

# Author: Xavier Lhinares
SSH_USER=$(./scripts/utils.sh --getenv SSH_USER)
SSH_HOST=$(./scripts/utils.sh --getenv SSH_HOST)


cd build/web/ || exit
if [ -d ".git" ]; then
  echo "Deleting the git folder."
  rm -r -f .git/
fi

echo "Recreating the git folder."
git init .
git remote add production ssh://$SSH_USER@$SSH_HOST:22/home/$SSH_USER/xeppelin/repositories/bare-home.git/ && echo "Successfully created remote [production]"
git fetch
git checkout -b master
git add .
NOW="$(date +'%Y/%m/%d-%H:%M:%S')"
git commit -m "$NOW: New build"
git push --set-upstream -f production master
