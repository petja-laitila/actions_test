#!/bin/bash
commitmessage=`git log --pretty=format:"%s" -1`;
if [[ ($commitmessage == *"Merge pull request"*) && ($commitmessage == *"from petja-laitila/devel"*) ]]; then 
  eval `ssh-agent -s`
  ssh-add - <<< "${GA_DEPLOY_KEY}"
  git config --global user.name "Mukane Kidkgu"
  git config --global user.email "mk[bot]@users.noreply.example.com"
  # Use default merge strategy
  git config --global pull.rebase false
  # Push one branch at a time
  git config --global push.default simple
  
  pushd .
  mkdir ~/testing
  cd ~/testing
  git clone git@github.com:petja-laitila/actions_test.git
  echo $PWD
  cd actions_test
  git checkout master 
  git reset --hard
  git pull

  echo $commitmessage | tee -a test
  git add .
  git commit -m "Updated some stuff to master"
  git push
  echo Merging changes back to devel
  # git fetch
  git checkout devel
  git pull
  git merge master
  echo "Updated latest" | tee -a test2
  git add .
  git commit -m "Updated latest stuff to devel"
  git pull
  git push
  popd
  
  #  --set-upstream origin devel
fi;
