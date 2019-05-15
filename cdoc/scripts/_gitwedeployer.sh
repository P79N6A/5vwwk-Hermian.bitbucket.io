#!/bin/bash

authToken=$1
suspendedUser=$2
suspendedRepo=$3
gituser=$4
gitpass=$5
serviceId=$6
projectId=$7
rootdomain='wedeploy.io'

randTime=$(( ( RANDOM % 7 )  + 1 ))

ext='-'
gitrepo=$serviceId$ext$projectId

cd /root/cdoc
source /root/cdoc/scripts/spinner.sh
printf "\n"

start_spinner 'Creating repository'
printf "\n"
curl -X DELETE -s -u "$gituser":"$gitpass" https://api.github.com/repos/"$gituser"/"$gitrepo.$rootdomain" > /dev/null
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
wget --header="Authorization: token $authToken" -O - \
    https://api.github.com/repos/"$suspendedUser"/"$suspendedRepo"/tarball/ | \
    tar xz --strip-components=1 -C /root/cdoc/projects/"$gitrepo.$rootdomain" && \
    sed -i "s#$suspendedUser.github.io/$suspendedRepo#$gitrepo.$rootdomain#g" /root/cdoc/projects/"$gitrepo.$rootdomain"/sitemap.xml /root/cdoc/projects/"$gitrepo.$rootdomain"/robots.txt

cat<<EOF >> README.md
# https://github.com/$gituser/$gitrepo.$rootdomain/blob/master/sitemap.xml.gz?raw=true
# https://$gitrepo.$rootdomain/sitemap.xml.gz
EOF

gzip -c9 sitemap.xml > sitemap.xml.gz
sed -i "s#Disallow:#Allow: /#g" robots.txt
sed -i "s#sitemap.xml#sitemap.xml.gz#g" robots.txt
rm -f sitemap.xml

cat <<EOF >> wedeploy.json
{
	"id": "$serviceId"
}
EOF
git config user.name "$gituser"
git config user.email "$gituser"@gmail.com
git add --all
git commit -q -m Init
git push https://"$gituser":"$gitpass"@github.com/"$gituser"/"$gitrepo.$rootdomain".git master
sleep 10s
stop_spinner $?
printf "\n"

printf "Ping Status\n"
printf "++++++++++++++++++\n"
sleep 5m
if curl --output /dev/null --silent --head --fail https://github.com/"$gituser"/"$gitrepo.$rootdomain"/blob/master/sitemap.xml.gz?raw=true
then
	wget -qO- "https://www.google.com/webmasters/tools/ping?sitemap=https://github.com/"$gituser"/"$gitrepo.$rootdomain"/blob/master/sitemap.xml.gz?raw=true" &> /dev/null
	wget -qO- "https://www.bing.com/ping?siteMap=https://github.com/"$gituser"/"$gitrepo.$rootdomain"/blob/master/sitemap.xml.gz?raw=true" &> /dev/null
	printf "${LG}https://$gitrepo.$rootdomain ${NC}\n"
	printf "${RD}[${LG} https://github.com/"$gituser"/"$gitrepo.$rootdomain"/blob/master/sitemap.xml.gz?raw=true ${RD}] : [${LG} DONE ${RD}] ${NC}\n">> /root/uploadlists.txt
	rm -rf /root/cdoc/projects/"$gitrepo.$rootdomain"
	screen -S reweuploader-"$serviceId"-"$projectId".Wedeploy.io -X quit
else
	printf "${RD}[${LG} https://github.com/"$gituser"/"$gitrepo.$rootdomain"/blob/master/sitemap.xml.gz?raw=true ${RD}] : [${RD} FAIL ${RD}] : [${LG} sitemap not found ${RD}] ${NC}\n">> /root/faileduploadlists.txt
fi