#!/bin/bash
#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.  Environment Configuration
#  2.  Make Terminal Better (remapping defaults and adding functionality)
#  3.  File and Folder Management
#  4.  Searching
#  5.  Process Management
#  6.  Networking
#  7.  System Operations & Information
#  8.  Web Development
#  9.  Reminders & Notes
#
#  ---------------------------------------------------------------------------

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
# If there're untracked files, then a '%' will be shown next to the branch name
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto
# A colored hint about the current dirty state
GIT_PS1_SHOWCOLORHINTS=true

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

DATOS=/Volumes/Datos
GIT=/Volumes/Datos/GIT
PERSONAL=/Volumes/Datos/PERSONAL
SPACES=/Volumes/Datos/SPACES
WORKSPACES=/Volumes/Datos/WORKSPACES
VAGRANT=/Volumes/Datos/WORKSPACES/VAGRANT

#   Set Paths
#   ------------------------------------------------------------
# export PATH="$PATH:/usr/local/bin/"
# export PATH="/usr/local/git/bin:/sw/bin/:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"

# JAVA HOME
export JAVA_HOME=$(/usr/libexec/java_home)

#   Change Prompt
#   ------------------------------------------------------------

# ANSI color codes
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

# Prompt git
AUX=""
if [ -f ~/.git-prompt-mac.sh ]; then
	AUX='$(__git_ps1 "%s" yes)'
fi

START="___________________________________________________\n| \$? $FMAG\h$RS@$FMAG[\u]:$FCYN\w$RS"
END=" \n$ "
FORMAT=" %s "
PROMPT_COMMAND='__git_ps1 "$START" "$END" "$FORMAT"'
export PS2="| $ "

#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
export EDITOR=/usr/bin/vim

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
export BLOCKSIZE=1k

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
#
#   a black
#   b red
#   c green
#   d brown
#   e blue
#   f magenta
#   g cyan
#   h light grey
#   A bold black, usually shows up as dark grey
#   B bold red
#   C bold green
#   D bold brown, usually shows up as yellow
#   E bold blue
#   F bold magenta
#   G bold cyan
#   H bold light grey; looks like bright white
#   x default foreground or background
#
#   1. directory
#   2. symbolic link
#   3. socket
#   4. pipe
#   5. executable
#   6. block special
#   7. character special
#   8. executable with setuid bit set
#   9. executable with setgid bit set
#   10. directory writable to others, with sticky bit
#   11. directory writable to others, without sticky
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

