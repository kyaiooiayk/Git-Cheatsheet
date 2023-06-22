#!/bin/bash

echo "******************"
echo "Pushing on GitHub!"

echo "******************"
echo "Current pwd:" $PWD

echo "******************"
echo "Get status"
git status

echo "******************"
echo "Add all new files"
git add .

echo "******************"
echo "Add commit comment" && read COMMENT

git commit -m $COMMENT

echo "******************"
echo "Push to GitHub"
git push
