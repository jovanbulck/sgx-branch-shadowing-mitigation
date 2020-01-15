#!/bin/bash
git bisect reset
git checkout origin/master
git bisect start
OLD=$(git rev-parse origin/release_40)
NEW=$(git rev-parse origin/release_80)
git bisect old $OLD
git bisect new $NEW
git bisect run ../run.sh

echo "finished bisecting between (old-new): " $OLD $NEW

