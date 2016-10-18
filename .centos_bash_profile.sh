#!/bin/bash
#
# Local specific environment and startup programs

EMAIL="luiscanadas@gmail.com"
NAME="Luis Cañadas Treceño"

git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global core.editor vim

export WORKSPACES=/srv/workspaces
export SPACES=/srv/spaces
export GIT_SERVER=/srv/git

