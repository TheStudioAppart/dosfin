#!/bin/bash

# Created by Audren GUILLAUME - audren.guilllaume@gmail.com (12/30/18)
# Feel free to update or improve this script. Tested on Ubuntu 18.04.1
# -------------------------------------------------------------------------------------------------

# Notes: -z empty, -n length greater than zero, -x ...
# Fake ternary operator: [ EVAL ] && if true || otherwise

GIT_FRONT=""
GIT_BACK=""

# Display helper
function help() {
    echo -e "
    SCRIPT -h or help \t\t Show this message
	SCRIPT -c or check \t\t Check if depeendencies are installed
    SCRIPT\t\t\t Run the installation procedure

    In software selection, press SPACE to check or uncheck an option and press ENTER to continue.
    "
}

# BEGIN CHECK SECTION -----------------------------------------------------------------------------

bold=$(tput bold)
normal=$(tput sgr0)

# message: X is missing
function miss() {
    res="[\u2718] ${bold}$1${normal} is missing..."; # Cross symbol
    echo -e $res;
    res="";
}

# message: X is installed
function inst() {
    if [ ! -z $2 ]; then version="($2)"; fi
    res="[\u2714] ${bold}$1${normal} is installed... $version"; # Check symbol
    echo -e $res;
    res=""; version="";
}

function check_git (){
    v="$(git --version 2>&1 | cut -d ' ' -f 3)";
    if [ -x "$(command -v git)" ]; then inst "GIT" $v; B_GIT=true; else miss "GIT"; B_GIT=false; fi
    v=""
}

function check_nvm (){
    if [ -d ~/.nvm/ ]; then inst "NVM"; B_NVM=true; else miss "NVM"; B_NVM=false; fi
}

function check_npm (){
    [ $B_NVM ] && NPM="npm install -g"
    # if [ -n "$(command -v npm)" ]; then NPM="npm install -g"; fi
}

function check_node_version (){
    v=$(ls -d $NVM_DIR/versions/node/*); 
    res=""; for k in $v; do res="$(basename $k)|$res"; done; res=${res::-1};
    if [ -n "$v" ]; then inst "Node" $res; B_NODE=true; 
    else miss "Node"; B_NODE=false;  fi
}

function check_mysql (){
    v="$(mysql --version 2>&1 | cut -d ' ' -f 6 | cut -d ',' -f 1)";
    if [ -x "$(command -v mysql)" ]; then inst "MySQL" $v; B_MYSQL=true;
    else miss "MySQL"; B_MYSQL=false; fi
}

function check_pm2 (){
    if [ -n "$(command -v pm2)" ]; then inst "PM2"; B_PM2=true; else miss "PM2"; B_PM2=false; fi
}

function check_ssh (){
    if [ -n "$(command -v ssh)" ]; then inst "SSH"; B_SSH=true; else miss "SSH"; B_SSH=false; fi
}

# Check if the snap command exist (Ubuntu installed by default, no need)
# Flatpak can be an alternative (TODO)
# TODO function check_snap (){}

function check (){
    check_git
    check_nvm
    check_node_version
    check_npm
    check_mysql
    check_pm2
    check_ssh
}

# END CHECK SECTION -------------------------------------------------------------------------------

# BEGIN CUSTOM ACTIONS (PRE-SCRIPT) SECTION -------------------------------------------------------

# Display helper
if [ -n $1 ] && [ "$1" = "-h" ] || [ "$1" = "help" ]; then help; exit; fi

# Run check install
if [ -n $1 ] && [ "$1" = "-c" ] || [ "$1" = "check" ]; then	check; exit; fi

# END CUSTOM ACTIONS SECTION ----------------------------------------------------------------------

# BEGIN MENU SECTION ------------------------------------------------------------------------------

# A list of all available softwares, libraries and/or tools that can be installed.
MSG="At the moment, only the core of the system is installed. To tune the system to your need, you\
 can choose to install one or more of the following predefined collections of software.\n\nChoose\
 software to install: (press space)"
CHOOSE=$(whiptail --title "Software selection" --checklist \
	"$MSG" 25 80 13 \
	"GIT" "" ON \
	"NVM" "Node Version Manager" ON \
	"LTS" "Node (latest)" OFF \
	"MySQL" "" ON \
	"PM2" "npm" ON \
    "SSH" "generate key" ON \
    "FRONT" "clone, configure (alpha)" OFF \
    "BACK" "clone, configure (alpha)" OFF 3>&1 1>&2 2>&3)
# END MENU SECTION --------------------------------------------------------------------------------

# BEGIN UTILS SECTION -----------------------------------------------------------------------------

# TODO test for each platform (ubuntu: ok, arch: ok, debian: /, fedora: /)
function linux_release (){
    APT="sudo apt-get install"; INSTALL=$APT;
    release=$(lsb_release -i | cut -d ':' -f 2 | tr -d '[:space:]');
	case "$release" in
	"Ubuntu") INSTALL=$APT ;;
	"Debian") INSTALL=$APT ;;
	"Arch") INSTALL="sudo pacman -S" ;;
	"CentOS") INSTALL="sudo yum install" ;;
	"FEDORA") INSTALL="sudo dnf install";;
	*) echo "Does not support this release or release not found." ;;
	esac
	echo "Current release: $release"
}

function already (){ 
    echo -e "${bold}$1${normal} is already installed\n";
}

function installing(){
    echo -e "${bold}$1${normal} is installing...\n";    
}
# END UTILS SECTION -------------------------------------------------------------------------------


# BEGIN INSTALL SECTION ---------------------------------------------------------------------------

# Variables:
#     $INSTALL {String}: see linux_release function
#     $value {Array [String]}: selected options in the check list
function installer (){
    value=$(echo $1 | cut -d '"' -f 2);
    case "$value" in
    "GIT") [ $B_GIT != true ] && (installing "GIT"; $INSTALL git) || already "GIT" ;;
    "NVM") 
        if [ $B_NVM != true ]; then 
            installing "NVM";
            wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash;
            source ~/.bashrc;
            $INSTALL build-essential;
        else    
            already "NVM"
        fi
        ;;
    "LTS") if [ $B_NVM != true ]; then installing "Node (latest)"; nvm install --lts; else miss "NVM"; fi ;;
    "MySQL") [ $B_MYSQL != true ] && (installing "MySQL"; $INSTALL mysql-server) || already "MySQL" ;;
    "PM2") [ $B_PM2 != true ] && (installing "PM2"; $NPM pm2) || already "PM2";;
    "SSH") 
        if [ $B_SSH != true ]; then
            installing "SSH";
            $INSTALL ssh;
        elif [ ! -f "$HOME/.ssh/id_rsa_studio" ]; then
            read -p "Email to use for ssh: " EMAIL; 
            ssh-keygen -o -t rsa -b 4096 -C $EMAIL -N "" -f "$HOME/.ssh/id_rsa_studio";
            SSH_KEY=$(cat ~/.ssh/id_rsa_studio.pub);
            echo -e "\nThis is your current key, stored in ~/.ssh/id_rsa_studio.pub \n\n$SSH_KEY";
            echo -e "Host github.com\n\tHostName github.com\n\tUser git\n\tIdentityFile ~/.ssh/id_rsa_studio" > ~/.ssh/config;
        else 
            already "SSH";
            SSH_KEY=$(cat ~/.ssh/id_rsa_studio.pub);
            echo -e "\nThis is your current key, stored in ~/.ssh/id_rsa_studio.pub \n\n$SSH_KEY";
        fi ;;
    "FRONT") 
        msg=$(ssh -T git@github.com 2>&1)
        if [[ $msg != *"denied"* ]]; then 
            # select path to clone
            read -p "Enter path which to clone frontend ($PWD): " PATH_FRONT ;
            [[ -z $PATH_FRONT ]] && PATH_FRONT="frontend";
            git clone $GIT_CLONE $PATH_FRONT;
        else
            echo "Error: add your ssh key to git";
        fi
        ;;
    "BACK")
        msg=$(ssh -T git@github.com 2>&1)
        if [[ $msg != *"denied"* ]]; then 
            # select path to clone
            read -p "Enter path which to clone backend ($PWD): " PATH_BACK ;
            [[ -z $PATH_BACK ]] && PATH_BACK="backend";
            git clone $GIT_BACK $PATH_BACK;
        else
            echo "Error: add your ssh key to git";
        fi 
        ;;
    *)  
        if [ -n $value ]; then echo ""; else echo "Command not found: $value"; fi ;;
    esac
}

# END INSTALL SECTION -----------------------------------------------------------------------------


# BEGIN MAIN SECTION ------------------------------------------------------------------------------

linux_release
exit_status=$?
check
if [ $exit_status = 0 ]; then
    if [ ${#CHOOSE} != 0 ]; then
        echo -e "The chosen softwares are: \n\t ${bold}$CHOOSE${normal}"
		echo "Software installation can require sudo privileges."
		read -p "Confirm (y/N): " CONFIRM
        echo ""

        if [[ "$CONFIRM" == "y" ]]; then
            for e in $CHOOSE; do installer $e; done
            exit_status=1;
        fi
    fi
    [ -z "$CHOOSE" ] && echo "You choose Cancel";
fi        

# END MAIN SECTION --------------------------------------------------------------------------------