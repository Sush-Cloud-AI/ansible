#!/bin/bash
c1=$(git tag -l | awk -F . '{print $1}' | sort -n | uniq | tail -1)
c2=$(git tag -l | awk -F . '{print $2}' | sort -n | uniq | tail -1)
c3=$(git tag -l | awk -F . '{print $3}' | sort -n | uniq | tail -1)
echo "Latest_TAG: $c1.$c2.$c3"
c3=$((c3+1))
VERSION="$c1.$c2.$c3"
echo  "New tag is : $VERSION"

git tag $VERSION

echo "Pushing new tag $VERSION"
git push --tags

echo "New TAG is created and pushed"

echo " BYE !!!!!!"