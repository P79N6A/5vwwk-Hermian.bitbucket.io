#!/bin/bash

NC='\033[0m'
LG='\033[1;32m'
RD='\033[1;31m'

CDOCSRV=$1
cdocproject=$2
gitrepo=$3
rootdomain=$4
gituser=$5
gitpass=$6
randTime=$(( ( RANDOM % 7 )  + 1 ))

cd /root/cdoc
source /root/cdoc/scripts/spinner.sh
printf "\n"

#start_spinner 'Creating repository'
#printf "\n"
#sleep 1
#request=`curl --request POST "https://gitlab.com/api/v3/session?login=$gitrepo&gitpass=$gitpass"`
#token=`echo $request | cut -d , -f 28 | cut -d : -f 2 | cut -d '"' -f 2`
#curl -H "Content-Type:application/json" https://gitlab.com/api/v3/projects?private_token=$token -d '{"name":"'$repo_name'"}' > /dev/null
#request=`curl --request POST "https://gitlab.com/api/v3/session?login=$gitrepo&password=$gitpass"`
#token=`echo $request | cut -d , -f 28 | cut -d : -f 2 | cut -d '"' -f 2`
#curl -H "Content-Type:application/json" https://gitlab.com/api/v3/projects?private_token=$token -d '{"name":"'$gitrepo.$rootdomain'"}' > /dev/null 2>&1
#sleep 10s
#stop_spinner $?
#printf "\n"
#

start_spinner 'Deploying to Gitlab'
printf "\n"
cd /root/cdoc/projects/
git clone https://"$gituser"@github.com/"$gituser"/"$gitrepo.$rootdomain".git
cd /root/cdoc/projects/"$gitrepo.$rootdomain"
sleep 1
rm -rf .git
wget -q https://www.dropbox.com/s/r7n4ht1502wh5qg/.gitlab-ci.yml
git init
git add --all
git commit -m "Initial Commit"
git config --global user.email "$gitrepo"@gmail.com
git config --global user.name "$gitrepo"
git remote add origin https://"$gitrepo"@gitlab.com/"$gitrepo"/"$gitrepo.$rootdomain".git
sleep "$randTime"m
git push --force https://"$gitrepo:$gitpass"@gitlab.com/"$gitrepo"/"$gitrepo.$rootdomain".git master
sleep 10s
stop_spinner $?
printf "\n"
sleep 20s

printf "\n"
printf "Sites\n"
printf "++++++++++++++++++\n"
printf "${LG}https://$gitrepo.$rootdomain${NC}\n"

printf "\n"
printf "Ping Status\n"
printf "++++++++++++++++++\n"
sleep "$randTime"m
if curl --output /dev/null --silent --head --fail https://"$gitrepo.$rootdomain"/sitemap.xml.gz
then
	wget -qO- "https://www.google.com/webmasters/tools/ping?sitemap=https://$gitrepo.$rootdomain/sitemap.xml.gz" &> /dev/null
	wget -qO- "https://www.bing.com/ping?siteMap=https://$gitrepo.$rootdomain/sitemap.xml.gz" &> /dev/null
	printf "${LG}https://$gitrepo.$rootdomain ${NC}\n"
	printf "${RD}[${LG} https://$gitrepo.$rootdomain ${RD}] : [${LG} DONE ${RD}] ${NC}\n">> /root/deploylists.txt
	rm -rf /root/cdoc/projects/"$gitrepo.$rootdomain"
	screen -S labdeployer-"$gitrepo.$rootdomain" -X quit
else
	printf "${RD}[${LG} https://$gitrepo.$rootdomain ${RD}] : [${RD} FAIL ${RD}] : [${LG} sitemap not found ${RD}] ${NC}\n">> /root/faileddeploylists.txt
	rm -rf /root/cdoc/projects/"$gitrepo.$rootdomain"
	screen -S labdeployer-"$gitrepo.$rootdomain" -X quit
fi