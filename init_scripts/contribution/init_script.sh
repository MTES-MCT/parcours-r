#!/usr/bin/env bash

echo "execution of $@"

export REPO=$1

#dirty method to find the user
THE_USER=$(find /home -name "lost+found" | cut -d "/" -f3)
export THE_USER=${THE_USER:-root}

echo user detected is $THE_USER

ORGANIZATION='MTES-MCT'
MAIN_REPO='parcours-r'
BRANCH='contribution'
git clone https://github.com/$ORGANIZATION/$MAIN_REPO/ /tmp/$MAIN_REPO/
cd /tmp/$MAIN_REPO/
git checkout $BRANCH

INIT_FOLDER='init_scripts/contribution'
for f in $(ls -I init_script.sh $INIT_FOLDER); do
bash "$INIT_FOLDER/$f"
done
