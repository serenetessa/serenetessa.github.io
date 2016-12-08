#!/bin/bash
gulp
( cd dist
 git init
 git config user.name "Travis-CI"
 git config user.email "travis@nodemeatspace.com"
 git add .
 echo "commit"
 git commit -m "Deployed to Github Pages"
 echo "push https://${GH_TOKEN}@${GH_REF}"
 git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
)