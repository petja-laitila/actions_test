#!/bin/bash
commitmessage=`git log --pretty=format:"%s" -1`;
if [[ ($commitmessage == *"Merge pull request"*) && ($commitmessage == *"from petja-laitila/devel"*) ]]; then 
    #   eval `ssh-agent -s`
    #   ssh-add .travisdeploykey
    #   rm -f .travisdeploykey
    # git remote set-url origin git@github.com:petja-laitila/actions_test.git
    git config user.name "Github Actions Bot"
    git config user.email "github-actions[bot]@users.noreply.github.com"
    git config pull.rebase false
    # Show me remotes
    git remote -v
    # Push one branch at a time
    git config --global push.default simple
    git checkout master
    git reset --hard
    git pull
    echo $commitmessage | tee -a test
    git add .
    git commit -m "Updated some stuff here"
    git push
    echo Merging changes back to devel
    # git fetch
    git checkout devel
    git pull
    git merge master
    echo "Updated latest" | tee -a test2
    git add .
    git commit -m "Updated latest stuff"
    git pull
    git push
    #  --set-upstream origin devel
fi;
