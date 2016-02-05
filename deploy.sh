#!/bin/bash
# /home/travis/build/cnwarden/mldoc

curl -# -o /home/travis/build/private.key http://cnwarden.github.io/download/deploy_rsa
cat /home/travis/build/private.key
export GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/travis/build/private.key'

git clone git@github.com:cnwarden/mldoc.git cnwarden/building
cd cnwarden/building/
# echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile /tmp/private.key\n" >> ~/.ssh/config
git config --local user.email "cnwarden@gmail.com"
git config --local user.name "cnwarden"
git config --global push.default simple

# git remote set-url origin git@github.com:cnwarden/mldoc.git
cat .git/config

gitbook build src /tmp/book

git fetch origin gh-pages:gh-pages
git clean -fdx
git checkout gh-pages

# deploy
rm -rf *
mv /tmp/book/* ./

git add -A
git commit -m "auto commit"
git push -u origin gh-pages
