#!/bin/sh
# Author : Xavier Lhinares

cd build/web/ || exit
git fetch
git remote remove production || echo "Remote doesn't exist."
git remote add production ssh://luwz4482@maine.o2switch.net:22/home2/luwz4482/repositories/bare-build.git/ && echo "Successfully create remote [production]"
echo "The following remotes are available:"
git remote