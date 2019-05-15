#!/bin/bash

NC='\033[0m'
LG='\033[1;32m'
RD='\033[1;31m'

CDOCSRV=$1
cdocproject=$2
gitrepo=$3
rootdomain=$4
gituser=$5
gitpass='D0nat123^&#'
randTime=$(( ( RANDOM % 7 )  + 1 ))

cd /root/cdoc
source /root/cdoc/scripts/spinner.sh
printf "\n"

#start_spinner 'Deploying to netlify'
#printf "\n"
#cd /root/cdoc/projects/
#git clone https://"$gituser"@github.com/"$gituser"/"$gitrepo.$rootdomain".git
#cd /root/cdoc/projects/"$gitrepo.$rootdomain"
#sleep 1
#rm -rf .git
#sleep "$randTime"m
#echo -ne '\n' | netlify deploy -p /root/cdoc/projects/"$gitrepo.$rootdomain"
#netlify update -n "$gitrepo"
#sleep 10s
#stop_spinner $?
#printf "\n"
#sleep 20s

start_spinner 'Downloading CDOC project'
printf "\n"
mkdir /root/cdoc/projects/"$gitrepo.$rootdomain"
cd /root/cdoc/projects/"$gitrepo.$rootdomain"
rm -rf *
sleep "$randTime"m
wget -q -O "$cdocproject".zip  "https://"$CDOCSRV".docivy.com/helper/download-pdf-html/"$cdocproject".zip?url=https://"$gitrepo.$rootdomain"&sm=1"
unzip "$cdocproject".zip && rm -rf "$cdocproject".zip
gzip -c9 sitemap.xml > sitemap.xml.gz
sed -i "s#Disallow:#Allow: /#g" robots.txt
sed -i "s#sitemap.xml#sitemap.xml.gz#g" robots.txt
rm -f sitemap.xml
rm -rf /root/cdoc/projects/"$gitrepo.$rootdomain"/06-*
echo -ne '\n' | netlify deploy -p /root/cdoc/projects/"$gitrepo.$rootdomain"
netlify update -n "$gitrepo"
sleep 10s
stop_spinner $?
printf "\n"

#start_spinner 'Deploying sitemap to github'
#printf "\n"
#cd /root/cdoc/projects/"$gitrepo.$rootdomain"
#curl -X DELETE -s -u "$gituser":"$gitpass" https://api.github.com/repos/"$gituser"/"$gitrepo.$rootdomain" > /dev/null
#curl -s -u "$gituser":"$gitpass" https://api.github.com/user/repos -d '{ "name": "'"$gitrepo.$rootdomain"'" }' > /dev/null
#git clone https://"$gituser":"$gitpass"@github.com/"$gituser"/"$gitrepo.$rootdomain".git
#cd /root/cdoc/projects/"$gitrepo.$rootdomain"/"$gitrepo.$rootdomain"
#cd
#printf "\n"
#printf "Sites\n"
#printf "++++++++++++++++++\n"
#printf "${LG}$gitrepo.$rootdomain${NC}\n"

printf "\n"
printf "Ping Status\n"
printf "++++++++++++++++++\n"
sleep 5m
if curl --output /dev/null --silent --head --fail https://"$gitrepo.$rootdomain"/sitemap.xml.gz
then
	wget -qO- "https://www.google.com/webmasters/tools/ping?sitemap=https://$gitrepo.$rootdomain/sitemap.xml.gz" &> /dev/null
	wget -qO- "https://www.bing.com/ping?siteMap=https://$gitrepo.$rootdomain/sitemap.xml.gz" &> /dev/null
	printf "${LG}https://$gitrepo.$rootdomain ${NC}\n"
	printf "${RD}[${LG} https://$gitrepo.$rootdomain ${RD}] : [${LG} DONE ${RD}] ${NC}\n">> /root/deploylists.txt
	rm -rf /root/cdoc/projects/"$gitrepo.$rootdomain"
	screen -S netdeployer-"$gitrepo.$rootdomain" -X quit
else
	printf "${RD}[${LG} https://$gitrepo.$rootdomain ${RD}] : [${RD} FAIL ${RD}] : [${LG} sitemap not found ${RD}] ${NC}\n">> /root/faileddeploylists.txt
fi