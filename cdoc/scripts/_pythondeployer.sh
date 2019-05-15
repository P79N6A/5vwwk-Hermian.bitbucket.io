#!/bin/bash

CDOCSRV=$1
cdocproject=$2
gitrepo=$3
rootdomain=$4
gituser=$5
gitpass=$6

cd /root/cdoc
source /root/cdoc/scripts/spinner.sh
printf "\n"

start_spinner 'Deploying to pythonanywhere'
printf "\n"
stop_spinner $?
printf "\n"

printf "\n"
printf "Done\n"
printf "++++++++++++++++++\n"
printf "git clone https://$gituser@github.com/$gituser/$gitrepo.$rootdomain.git /home/$gitrepo/www\n">> /root/uploadlists.txt
screen -S pythuploader-"$gitrepo.$rootdomain" -X quit
printf "\n"