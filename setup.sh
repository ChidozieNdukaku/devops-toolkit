#!/bin/bash

## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREENS="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

## Script termination
exit_on_signal_SIGINT() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
    return
}



## banner 
banner() {
echo "
		${GREENS} ____              ___              _____           _ _    _ _   
		${ORANGE}|  _ \  _____   __/ _ \ _ __  ___  |_   _|__   ___ | | | _(_) |_               
		${GREENS}| | | |/ _ \ \ / / | | | '_ \/ __|   | |/ _ \ / _ \| | |/ / | __|            
		${ORANGE}| |_| |  __/\ V /| |_| | |_) \__ \   | | (_) | (_) | |   <| | |_ 
		${GREENS}|____/ \___| \_/  \___/| .__/|___/   |_|\___/ \___/|_|_|\_\_|\__|   
		${ORANGE}                       |_|                              
		${ORANGE}                ${RED}Version : 1.0

		${GREEN}[${WHITE}-${GREENS}]${GREENS} Tool Created by ${RED}mosthated ${GREENS}(umegbewe nwebedu)${WHITE}
"
}
update() {
	if [[ `command -v apt-get` ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Running sudo apt-get update..."
		sudo apt-get -y update >> logs.txt
	elif [[ `command -v yum` ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Running sudo yum update..." 
		sudo yum -y update >> logs.txt
	elif [[ `command -v pacman` ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Running sudo pacman update..."
		sudo pacman -Syy
	else
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Unsupported package manager"
		{ reset_color; exit 1; }
	fi
	}
menu() {
	{ clear; banner; echo; }
	cat <<- EOF
		${RED}[${WHITE}::${RED}]${ORANGE} Select a tool to install ${RED}[${WHITE}::${RED}]${ORANGE}

		${RED}[${WHITE}01${RED}]${ORANGE} Docker        ${RED}[${WHITE}07${RED}]${ORANGE} AWS Cli      ${RED}[${WHITE}13${RED}]${ORANGE} Ngrok
		${RED}[${WHITE}02${RED}]${ORANGE} Vagrant       ${RED}[${WHITE}08${RED}]${ORANGE} Gcloud Cli   ${RED}[${WHITE}14${RED}]${ORANGE} Minikube  
		${RED}[${WHITE}03${RED}]${ORANGE} Ansible       ${RED}[${WHITE}09${RED}]${ORANGE} Azure Cli    
		${RED}[${WHITE}04${RED}]${ORANGE} Jenkins       ${RED}[${WHITE}10${RED}]${ORANGE} Github Cli   	
		${RED}[${WHITE}05${RED}]${ORANGE} Terraform     ${RED}[${WHITE}11${RED}]${ORANGE} Circleci Cli 	
		${RED}[${WHITE}06${RED}]${ORANGE} Kubectl       ${RED}[${WHITE}12${RED}]${ORANGE} Jaeger

		${RED}[${WHITE}99${RED}]${ORANGE} About         ${RED}[${WHITE}00${RED}]${ORANGE} Exit

		EOF
		
	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"
		if [[ "$REPLY" == 1 || "$REPLY" == 01 ]]; then
				docker | docker --version
		elif [[ "$REPLY" == 2 || "$REPLY" == 02 ]]; then
				vagrant | vagrant --version
		else
		echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
				{ sleep 1; menu; }
		fi
}




##docker
docker() {
	if [[ `command -v docker` ]]; then
		echo -e "\n${RED}[${WHITE}+${RED}] ${WHITE} Docker already installed!!!!!!"
	elif [[ `command -v apt-get` ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Getting requirements....."
		sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release >> logs.txt
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Adding Docker’s official GPG key........"
		#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg > /dev/null
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Installing Docker......."
		sudo apt-get install docker-ce docker-ce-cli containerd.io >> logs.txt
	elif [[ `command -v yum` ]]; then
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Grabbing Docker 20.10.7:stable.........."
	wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.7.tgz >> logs.txt
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Unpacking..........."
	tar xzvf docker-20.10.7.tgz >> logs.txt
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} copying binaries to /usr/bin"
	sudo cp docker/* /usr/bin/
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Docker version"
	docker --version
	elif [[ `command -v pacman` ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Running sudo pacman update..."
		sudo pacman -Syy
	else
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Grabbing Docker 20.10.7:stable.........."
	wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.7.tgz >> logs.txt
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Unpacking..........."
	tar xzvf docker-20.10.7.tgz >> logs.txt
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} copying binaries to /usr/bin"
	sudo cp docker/* /usr/bin/
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Docker version"
	docker --version
		{ reset_color; exit 1; }
	fi
}

vagrant() {
	
	if [[ `command -v umegbewe` ]]; then
		echo -e "\n${RED}[${WHITE}+${RED}] ${WHITE} Vagrant already installed!!!!!!"
	elif [[ `command -v apt-get` ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Getting requirements....."
		sleep 1
		curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - >> logs.txt
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Adding Vagrant Repository"
		sleep 1
		sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Installing Docker......."
		sleep 1
		sudo apt-get update && sudo apt-get install vagrant
	elif [[ `command -v yum` ]]; then
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Getting requirements..........."
		sleep 1
		sudo yum install -y yum-utils
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Adding Repo................."
		sleep 1
	sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Installing Vagrant"
		sleep 1
	sudo yum -y install vagrant
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Vagrant version"
		sleep 1
	vagrant --version
	elif [[ `command -v pacman` ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREENS}]${GREENS} Running sudo pacman update..."
		sudo pacman -Syy
	else
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Grabbing Docker 20.10.7:stable.........."
	wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.7.tgz >> logs.txt
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Unpacking..........."
	tar xzvf docker-20.10.7.tgz >> logs.txt
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} copying binaries to /usr/bin"
	sudo cp docker/* /usr/bin/
	echo -e "\n${RED}[${WHITE}!${RED}]${RED} Docker version"
	docker --version
		{ reset_color; exit 1; }
	fi
}


#add helm and kind kubernetes
banner
update
menu
