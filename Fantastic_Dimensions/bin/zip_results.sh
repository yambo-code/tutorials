#! /bin/sh
#
find . -name 'o-*' -o -name 'r-*' -o -name 'l-*' | \
grep -v 'Results' | zip -@ results.zip
