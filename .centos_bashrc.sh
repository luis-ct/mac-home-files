#!/bin/bash
#
# Local specific aliases and functions

PREFIX_VENV=~/tmp-env-lct
PYPROJECTS=(myproject marshmallow)

create_venvs () {
	for project in "${PYPROJECTS[@]}"
	do
		VENV=$PREFIX_VENV-$project
		if [ -d "$VENV" ]; then
			echo ' * Virtualenv "'$VENV'" already exists.'
		else
			echo ' * Virtualenv "'$VENV'" doesnt exist. Creating...'
			virtualenv --system-site-packages $VENV ;
		fi
	done
}
destroy_venvs ()  {
	for project in "${PYPROJECTS[@]}"
	do
		VENV=$PREFIX_VENV-$project
		echo ' * Removing virtualenv "'$VENV'"...' ;
		rm -fr $VENV ;
	done
}

activate_generic () {
	project=$1
	cat=$2
	company=$3
	sudo mkdir -p /var/log/$project/
	sudo chown -R vagrant:vagrant /var/log/$project &> /dev/null
	VENV=$PREFIX_VENV-$project
	if [ -d "$VENV" ]; then
		deactivate &> /dev/null ;
		source $VENV/bin/activate ; 
		cd $PREFIX/$cat/$3-$project ;
		if [ -f ./local-gen-build-envs.sh ]; then
			source ./local-gen-build-envs.sh ;
		fi
	else
		echo 'Error. Virtualenv '$VENV' not created.'
	fi
}

activate_myproject () {
	activate_generic myproject workspace-python lct
}


kill_process () {
	process_name=$1
	process_pid=$(ps aux | grep $process_name | grep -v grep | awk {'print $2'})
	kill -9 $process_pid
}

alias tree="tree -C -a"

myeth1=$(/sbin/ifconfig enp0s8 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
alias pjsua="pjsua --ip-addr=$myeth1 --config-file /vagrant/config_pjsua.txt"

create_venvs
