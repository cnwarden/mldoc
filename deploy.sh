#!/bin/bash

mkdir -p /tmp/repo && cd /tmp/repo

# echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile /tmp/private.key\n" >> ~/.ssh/config
export GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /tmp/private.key'
git config --local user.email "cnwarden@gmail.com"
git config --local user.name "cnwarden"
git config --global push.default simple
git clone git@github.com:cnwarden/mldoc.git
# git remote set-url origin git@github.com:cnwarden/mldoc.git
cat .git/config

gitbook build src /tmp/book

curl -# -o /tmp/private.key http://cnwarden.github.io/download/deploy_rsa
cat /tmp/private.key
chmod 600 /tmp/private.key

git fetch origin gh-pages:gh-pages
git clean -fdx
git checkout gh-pages

# deploy
rm -rf *
mv /tmp/book/* ./

git add -A
git commit -m "auto commit"
git push -u origin gh-pages
