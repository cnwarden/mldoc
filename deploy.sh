#!/bin/bash

gitbook build src /tmp/book

curl -# -o /tmp/private.key http://cnwarden.github.io/download/deploy_rsa
cat /tmp/private.key

export GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /tmp/private.key'
git config --local user.email "cnwarden@gmail.com"
git config --local user.name "cnwarden"
git config --global push.default simple

git fetch origin gh-pages:gh-pages
git clean -fdx
git checkout gh-pages

# deploy
rm -rf *
mv /tmp/book/* ./

git add -A
git commit -m "auto commit"

echo $GIT_SSH_COMMAND
git push -u origin gh-pages
