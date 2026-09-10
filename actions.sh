#!/bin/bash
eval `ssh-agent -s`
ssh-add - <<< "${GA_DEPLOY_KEY}"
git config --global user.name "Github Actions"
git config --global user.email "github-actions[bot]@users.noreply.github.com"
# Use default merge strategy
git config --global pull.rebase false
# Push one branch at a time
git config --global push.default simple
git pull  
git checkout devel 
git reset --hard
git pull

echo $commitmessage | tee -a test
git add .
git commit -m "Updated some stuff to devel"
git push
echo "Updated latest" | tee -a test2
git add .
git commit -m "Updated latest stuff to devel"
git pull
git push
