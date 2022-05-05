#!/bin/bash
#set -e
###############################################################################
# Author	:	Kelly McCuddy
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#   
#   This a script to automate the retrieval of my dotfiles.
#
###############################################################################


echo ".dots" >> .gitignore
git clone --bare https://github.com/GraeWolf/dots.git $HOME/.dots
git --git-dir=$HOME/.dots/ --work-tree=$HOME checkout
git --git-dir=$HOME/.dots/ --work-tree=$HOME config --local status.showUntrackedFiles no

