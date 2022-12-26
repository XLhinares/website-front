#!/bin/sh

# Author : Xavier Lhinares

cd build/ || exit
# Remove the web/ folder if it exists.
if [ -d "./web" ]; then
rm -r ./web
fi

# Clone the most recent website-build
git clone git@github.com:XLhinares/website-build.git
mv website-build/ web/
