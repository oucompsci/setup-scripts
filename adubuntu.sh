#!/bin/bash

usage() {
        printf "Usage: sudo bash adubuntu.sh OPTIONS\n"
        printf "Join machine to domain with specified user account\n\n"
        printf "Options:\n"
        printf "  -u, --username"
}


##### Main

if [ "$(id -u)" != "0" ]; then
	echo "Elevating to root"
	sudo "$0" "$@"
	exit $?
fi

set -e

while [ "$1" != "" ]; do
    case $1 in
        -u | --username)        shift
                                username=$1
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [[ $username == "" ]]; then
	echo "Please enter a username: -u 4x4"
	exit
fi

echo "Installing updates"
sudo apt update
sudo apt upgrade -y

sudo apt install -y sssd-ad sssd-tools realmd adcli krb5-user

realm discover sooner.net.ou.edu

list=$(realm list)

if [[ $list == "" ]]; then
 echo "testing"
	sudo realm join --user="$username" sooner.net.ou.edu

	echo 'ad_gpo_access_control = permissive' | sudo tee -a /etc/sssd/sssd.conf

	echo 'case_sensitive = false' | sudo tee -a /etc/sssd/sssd.conf
fi	
echo "Connecting to domain. Please wait. This may take some time."
sudo adcli join -D sooner.net.ou.edu -U "$username"

sudo pam-auth-update --enable mkhomedir

sudo systemctl restart sssd

echo "Complete!"
