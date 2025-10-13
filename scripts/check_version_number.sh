#!/bin/sh
# Author : Xavier Lhinares

C='\033[0m'   #'0' is the "No Color" ANSI color code.
R='\033[0;31m'   #'0;31' is Red's ANSI color code.
G='\033[0;32m'   #'0;32' is Green's ANSI color code.

# Retrieve the line containing the version number and parse it.
VERSION_LINE_CHANGELOG=$(head -1 CHANGELOG.md);
VERSION_NUMBER_CHANGELOG=$(echo "$VERSION_LINE_CHANGELOG" | grep -oP "\d+\.\d+\.\d+");

VERSION_LINE_PUBSPEC=$(cat pubspec.yaml | grep "version: *+*");
VERSION_NUMBER_PUBSPEC=$(echo "$VERSION_LINE_PUBSPEC" | grep -oP "\d+\.\d+\.\d+");

# Compare it to the version number in pubspec.yaml
#OCCURRENCES=$(grep -c "$VERSION_NUMBER_CHANGELOG" pubspec.yaml);
if [ $VERSION_NUMBER_PUBSPEC = $VERSION_NUMBER_CHANGELOG ]; then
  echo "${G}Version numbers are matching! (v$VERSION_NUMBER_CHANGELOG)$C";
  exit 0;
else
  echo "${R}The version numbers do NOT match!
      CHANGELOG: v$VERSION_NUMBER_CHANGELOG
      PUBSPEC:   v$VERSION_NUMBER_PUBSPEC$C";
  exit 2;
fi;