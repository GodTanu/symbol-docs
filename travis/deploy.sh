#!/usr/bin/env bash
set -e

echo "Build docs"
make alldocs

echo "Moving to docs folder"
cd build/html

echo "Setting remote url https://github.com/${RELEASE_REPO_SLUG}.git"
git init
git config --global user.name "symbol-bot"
git config --global user.email "${GITHUB_EMAIL}"
git remote add origin "https://${GITHUB_TOKEN}@github.com/${RELEASE_REPO_SLUG}.git" > /dev/null 2>&1

#  The $SKIP_RELEASE_PUBLISH env variable can avoid republishing if the release process fails.
if [ "$SKIP_RELEASE_PUBLISH" = "true" ]; then
   echo "Skipping publishing of docs"
   echo ""
else
   echo "Publishing docs"
   git add .
   echo "Commit"
   git commit -m "Release docs"
   echo "Push"
   git push --set-upstream origin master --force
echo ""
fi
