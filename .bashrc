#!/bin/bash

# if [ -f /etc/bashrc ]; then
# 	. /etc/bashrc   # --> Read /etc/bashrc, if present.
# fi

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
	source /usr/local/git/contrib/completion/git-completion.bash
fi

if [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
	source /usr/local/git/contrib/completion/git-prompt.sh
fi


# aliasses Vagrant
##################

vagrant_generic() {
	if [ "$#" -eq 1 ]; then
		COMMAND=$1
		NAME=default
		FOLDER=Centos7
	elif [ "$#" -eq 2 ]; then
		COMMAND=$1
		NAME=$2
		FOLDER=Centos7
	elif [ "$#" -eq 3 ]; then
		COMMAND=$1
		NAME=$2
		FOLDER=$3
	else
	    echo "Illegal number of parameters"
		return 1
	fi
	pushd $VAGRANT/$FOLDER
	vagrant $COMMAND $NAME
	popd
}

vagrant_up() {
	vagrant_generic up $1 $2
}

vagrant_down() {
	vagrant_generic halt $1 $2
}

vagrant_ssh() {
	vagrant_generic ssh $1 $2
}

vagrant_up_jira() {
	vagrant_generic up default JIRA
}

# aliasses TeamCity
###################

teamcity_up() {
	cd $SPACES/TeamCity/bin
	./runAll.sh start
}

teamcity_down() {
	cd $SPACES/TeamCity/bin
	./runAll.sh stop
}

# aliasses jenkins
###################

jenkins_up() {
	sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist
}

jenkins_down() {
	sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist

	HOME_JENKINS="/Users/Shared/Jenkins/Home"
	
	NOW=$(date -u +"%d%m%Y_%H%M%S")
	DIR_BACKUP="/Volumes/Datos/WORKSPACES/VAGRANT/JENKINS/backup/"$NOW
	
	echo "Backing up Jenkins..."
	
	echo "Creating backup directory $DIR_BACKUP"
	sudo mkdir -p $DIR_BACKUP
	cd $HOME_JENKINS

	sudo cp -Rfv * $DIR_BACKUP
	
	echo "Compress $DIR_BACKUP directory"
	cd $DIR_BACKUP
	cd ..
	sudo tar -czf $NOW.tar.gz $NOW
	sudo rm -rf $NOW
	
	echo "Jenkins backup done."
}

start_servers() {
	vagrant_up default JIRA ;
	vagrant_up default BITBUCKET ;
	jenkins_up ;
}

stop_servers() {
	vagrant_down default JIRA ;
	vagrant_down default BITBUCKET ;
	jenkins_down ;
}

#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------
alias cp='cp -iv'    			    # Preferred 'cp' implementation
alias mv='mv -iv'    			    # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAahp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd () { builtin cd "$@"; ll; }              # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.            Example: mans mplayer codec
#   --------------------------------------------------------------------
mans () {
    man $1 | grep -iC2 --color=always $2 | less
}

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   -------------------------------
#   3. FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjvf $1     ;;
        *.tar.gz)    tar xzvf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1      ;;
        *.tbz2)      tar xjvf $1     ;;
        *.tgz)       tar xzvf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}


#   ---------------------------
#   4. SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
# spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6. NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ; myip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}


#   ---------------------------------------
#   7. SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8. WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

#   ---------------------------------------
#   9. xCode 
#   ---------------------------------------
covid () {
	du -sh /Users/luiscanadas/Library/Developer/Xcode/DerivedData/
	rm -rf /Users/luiscanadas/Library/Developer/Xcode/DerivedData/*
	du -sh /Users/luiscanadas/Library/Developer/Xcode/DerivedData/
	du -sh /Users/luiscanadas/Library/Developer/Xcode/Archives/
	rm -rf /Users/luiscanadas/Library/Developer/Xcode/Archives/*
	du -sh /Users/luiscanadas/Library/Developer/Xcode/Archives/
	du -sh /Users/luiscanadas/Library/Developer/Devices/
	rm -rf /Users/luiscanadas/Library/Developer/Devices/*
	du -sh /Users/luiscanadas/Library/Developer/Devices/
}

alias xc='xed .'

#   ---------------------------------------
#   10. Ggit 
#   ---------------------------------------
cleanup_git_project_branches () {
	git branch -d $(git branch --merged=master | grep -v master)
	git fetch --prune
}

remove_dsstores() {
	find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

export PATH=/bin:/usr/bin:$PATH

alias connect_to_vpn='osascript /Users/luiscanadas/WORKSPACES/PERSONAL/mac-home-files/connectVPN.scpt'
alias disconnect_to_vpn='osascript /Users/luiscanadas/WORKSPACES/PERSONAL/mac-home-files/disconnectVPN.scpt'
