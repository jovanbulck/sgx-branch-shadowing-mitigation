#!/bin/bash

MYDIR=examples

ls -lR $MYDIR | wc -l
grep -R "package_version="

#if grep -R "package_version=7.0.0-r%revision%" -q ; then
#if [ $(ls -lR $MYDIR | wc -l) -eq 48 ]; then
if md5sum -c ../md5.txt ; then
    echo "seems good"
    exit 1
else
    echo "not okay"
    exit 0
fi
