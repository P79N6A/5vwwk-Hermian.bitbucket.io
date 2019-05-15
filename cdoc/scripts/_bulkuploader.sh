#!/bin/bash

CDOCSRV=$1
cdocproject=$2
gitrepo=$3
rootdomain=$4
gituser=$5
gitpass=$6
randTime=$(( ( RANDOM % 7 )  + 1 ))

#if [[ $gituser = $5 ]]; then
#        sed -n "$5p" < /root/githubusername.txt
#fi

cd /root/cdoc
source /root/cdoc/scripts/spinner.sh
printf "\n"

start_spinner 'Creating repository'
printf "\n"
sleep 1
curl -s -u "$gituser":"$gitpass" https://api.github.com/user/repos -d '{ "name": "'"$gitrepo.$rootdomain"'" }' > /dev/null
sleep 10s
stop_spinner $?
printf "\n"

start_spinner "Cloning & Downloading"
printf "\n"
sleep 1
cd /root/cdoc/projects/
git clone https://"$gituser":"$gitpass"@github.com/"$gituser"/"$gitrepo.$rootdomain".git
cd /root/cdoc/projects/"$gitrepo.$rootdomain"
rm -rf *
sleep "$randTime"m
wget -q -O "$cdocproject".zip  "http://"$CDOCSRV".docivy.com/helper/download-pdf-html/"$cdocproject".zip?url=https://"$gitrepo.$rootdomain"&sm=1"
unzip "$cdocproject".zip && rm -rf "$cdocproject".zip
gzip -c9 sitemap.xml > sitemap.xml.gz
sed -i "s#Disallow:#Allow: /#g" robots.txt
sed -i "s#sitemap.xml#sitemap.xml.gz#g" robots.txt
rm -f sitemap.xml
sleep 10s
stop_spinner $?
printf "\n"

start_spinner "Deploying"
printf "\n"
sleep 1
cd /root/cdoc/projects/"$gitrepo.$rootdomain"
git config user.name "$gituser"
git config user.email "$gituser"@gmail.com
git add .
git commit -q -m Init
git push https://"$gituser":"$gitpass"@github.com/"$gituser"/"$gitrepo.$rootdomain".git master
sleep 10s
stop_spinner $?
printf "\n"
sleep 20s

printf "Ping Status\n"
printf "++++++++++++++++++\n"
sleep 5m
if curl --output /dev/null --silent --head --fail https://github.com/"$gituser"/"$gitrepo.$rootdomain"/blob/master/sitemap.xml.gz?raw=true
then
	wget -qO- "https://www.google.com/webmasters/tools/ping?sitemap=https://github.com/$gituser/$gitrepo.$rootdomain/blob/master/sitemap.xml.gz?raw=true" &> /dev/null
	wget -qO- "https://www.bing.com/ping?siteMap=https://github.com/$gituser/$gitrepo.$rootdomain/blob/master/sitemap.xml.gz?raw=true" &> /dev/null
	printf "${LG}https://$gitrepo.$rootdomain ${NC}\n"
	printf "${RD}[${LG} https://github.com/$gituser/$gitrepo.$rootdomain/blob/master/sitemap.xml.gz?raw=true ${RD}] : [${LG} DONE ${RD}] ${NC}\n">> /root/uploadlists.txt
	rm -rf /root/cdoc/projects/"$gitrepo.$rootdomain"
	screen -S bulkuploader-"$gitrepo.$rootdomain" -X quit
else
	printf "${RD}[${LG} https://github.com/$gituser/$gitrepo.$rootdomain/blob/master/sitemap.xml.gz?raw=true ${RD}] : [${RD} FAIL ${RD}] : [${LG} sitemap not found ${RD}] ${NC}\n">> /root/faileduploadlists.txt
fi