
if [ -f /etc/bashrc ]; then
	. /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

if [ -f ~/.git-completion.bash ]; then
	source ~/.git-completion.bash
fi

if [ -f ~/.git-prompt-mac.sh ]; then
	source ~/.git-prompt-mac.sh
fi
