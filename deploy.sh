#!/bin/bash

gitbook build src
mkdir -p /tmp/dst
mv src/* /tmp/dst

curl -# -o /tmp/private.key http://cnwarden.github.io/download/deploy_rsa

export GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /tmp/private.key'
git config --local user.email "cnwarden@gmail.com"
git config --local user.name "cnwarden"
git fetch origin gh-pages:gh-pages
git clean -fdx
git checkout gh-pages

# deploy
rm -rf *
mv /tmp/dst/* ./

git add -A
git commit -m "auto commit"
git push
