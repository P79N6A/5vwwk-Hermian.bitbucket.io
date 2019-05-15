#!/bin/bash

update=$1

rm -f /etc/profile.d/locale.sh
echo "export LANG=en_US.UTF-8" >> /etc/profile.d/locale.sh
echo "export LANGUAGE=en_US.UTF-8" >> /etc/profile.d/locale.sh
source /etc/profile.d/locale.sh

NC='\033[0m'
LG='\033[1;32m'
RD='\033[1;31m'

# Prepare Blogx workspace
mkdir -p /root/cdoc
mkdir -p /root/cdoc/scripts
mkdir -p /root/cdoc/projects
mkdir -p /root/cdoc/tmp

# Download partials scripts
cd /root/cdoc/scripts

# Spinner
rm -f spinner.sh
wget -q -o /dev/null https://www.dropbox.com/s/6xvpc7ikns1jkck/spinner.sh && chmod 0700 spinner.sh
source "$(pwd)/spinner.sh"

# Github Cleaner
rm -f github-cleaner.sh
wget -q -o /dev/null https://www.dropbox.com/s/5sswqit0nx775yy/github-cleaner.sh && chmod 0700 github-cleaner.sh

# Github Cdoc Partial
rm -f _gitdrive.sh
wget -q -o /dev/null https://www.dropbox.com/s/aoj8eqotygbtn50/_gitdrive.sh && chmod 0700 _gitdrive.sh
rm -f _wedeployer.sh
wget -q -o /dev/null https://www.dropbox.com/s/c3od2t8pfg8xfx9/_wedeployer.sh && chmod 0700 _wedeployer.sh
rm -f _gitwedeployer.sh
wget -q -o /dev/null https://www.dropbox.com/s/z7qjzzr03n750em/_gitwedeployer.sh && chmod 0700 _gitwedeployer.sh

# Bitbucket Cdoc Partial
rm -f _bitdeployer.sh
wget -q -o /dev/null https://www.dropbox.com/s/04t64druhpgtzp7/_bitdeployer.sh && chmod 0700 _bitdeployer.sh

# Firebase Cdoc Partial
rm -f _firedeployer.sh
wget -q -o /dev/null https://www.dropbox.com/s/pdkqksemnbhh7hj/_firedeployer.sh && chmod 0700 _firedeployer.sh

# Netlify Cdoc Partial
rm -f _netdeployer.sh
wget -q -o /dev/null https://www.dropbox.com/s/76dbq52i6yigk5u/_netdeployer.sh && chmod 0700 _netdeployer.sh

# Pythonanywhere Cdoc Partial
rm -rf _pythongit.sh
wget -q -o /dev/null https://www.dropbox.com/s/8ex9iqy872ex7bu/_pythongit.sh && chmod 0700 _pythongit.sh
rm -f _pythondeployer.sh
wget -q -o /dev/null https://www.dropbox.com/s/whefv9rbu6f4m7e/_pythondeployer.sh && chmod 0700 _pythondeployer.sh

# Bulkuploader
rm -f _bulkuploader.sh
wget -q -o /dev/null https://www.dropbox.com/s/oqlv8toga8y0nmf/_bulkuploader.sh && chmod 0700 _bulkuploader.sh

# Gitlab Cdoc Partial
rm -f _labdeployer.sh
wget -q -o /dev/null https://www.dropbox.com/s/sbwtlbpud78ozgm/_labdeployer.sh && chmod 0700 _labdeployer.sh

# Installing requirement
if [[ $1 = update ]]; then
		start_spinner "Install and update modules.."
		sleep 1
		# Prepare repository
		yum -q -y install epel-release
		yum -q -y update
		
		# Install modules
		yum install -y -q git jq ncftp tree unzip
		
		{
			curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
		} > /dev/null
		
		yum install -y -q nodejs
		npm install -g -q blogxstatic
		npm install -g firebase-tools
		npm install -g netlify-cli
		sleep 3s
		stop_spinner $?
fi

# Main
cd /root/cdoc

ask=1
gitcount=1
ftpcount=1
gpycount=1
while [ ${ask} -eq 1 ]
do
	printf "\n"
	printf "Please choose target type (CdocServer, CdocProject, SubDomainTarget, RootDomainTarget, GithubUsername, GithubPassword).\n"
	printf "[1] Github Uploader\n"
	printf "[2] Pythonanywhere Deployer\n"
	printf "[3] Firebase Deployer\n"
	printf "[4] Bitbucket Deployer\n"
	printf "[5] Netlify Deployer\n"
	printf "[6] We Uploader (CdocServer, CdocProject, WedeployService, WedeployProject, RootDomainTarget, GithubUsername, GithubPassword)\n"
	printf "[7] Bulk Uploader\n"
	printf "[8] Gitlab Deployer\n"
	#printf "[9] Suspended Github to Wedeploy\n"
	printf "[9] Python Git Uploader\n"
	printf "\n"
	read -p "Select target type: " target_type
	case $target_type in
		1*)
			printf "\n"
			printf "### GithubUploader\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S uploader-"$gitrepo.$rootdomain"
			screen -S uploader-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_gitdrive.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		2*)
			printf "\n"
			printf "### Pythonanywhere\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S pythuploader-"$gitrepo.$rootdomain"
			screen -S pythuploader-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_pythondeployer.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		3*)
			printf "\n"
			printf "### Firebase\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S firedeployer-"$gitrepo.$rootdomain"
			screen -S firedeployer-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_firedeployer.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		4*)
			printf "\n"
			printf "### Bitbucket\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S bitdeployer-"$gitrepo.$rootdomain"
			screen -S bitdeployer-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_bitdeployer.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		5*)
			printf "\n"
			printf "### Netlify\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S netdeployer-"$gitrepo.$rootdomain"
			screen -S netdeployer-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_netdeployer.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		6*)
			printf "\n"
			printf "### Wedeploy\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Wedeploy Service ID: " serviceId
			read -p "Wedeploy Project ID: " projectId
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S weuploader-"$serviceId"-"$projectId".Wedeploy.io
			screen -S weuploader-"$serviceId"-"$projectId".Wedeploy.io -X stuff "bash /root/cdoc/scripts/_wedeployer.sh "$CDOCSRV" "$cdocproject" "$serviceId" "$projectId" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		7*)
			printf "\n"
			printf "### Bulkuploader\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S bulkuploader-"$gitrepo.$rootdomain"
			screen -S bulkuploader-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_bulkuploader.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		8*)
			printf "\n"
			printf "### GitlabDeployer\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			screen -d -m -S labdeployer-"$gitrepo.$rootdomain"
			screen -S labdeployer-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_labdeployer.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass""$(echo -ne '\015')
			;;
		10*)
			printf "\n"
			printf "### Suspended Github to Wedeploy\n"
			printf "\n"
			read -p "Github AuthToken: " authToken
			read -p "Github SuspenedUsename: " suspendedUser
			read -p "Github SuspendedRepo: " suspendedRepo
			read -p "Github UserName: " gituser
			read -p "Github Password: " gitpass
			read -p "Wedeploy ServiceId: " serviceId
			read -p "Wedeploy ProjectId: " projectId
			screen -d -m -S reweuploader-"$serviceId"-"$projectId".Wedeploy.io
			screen -S reweuploader-"$serviceId"-"$projectId".Wedeploy.io -X stuff "bash /root/cdoc/scripts/_gitwedeployer.sh "$authToken" "$suspendedUser" "$suspendedRepo" "$gituser" "$gitpass" "$serviceId" "$projectId""$(echo -ne '\015')
			;;
		9*)
			printf "\n"
			printf "### PythonGitshub\n"
			printf "\n"
			read -p "Cdoc Server: " CDOCSRV
			read -p "Cdoc Project: " cdocproject
			read -p "Sub Domain Target: " gitrepo
			read -p "Root Domain Target: " rootdomain
			read -p "Github Username: " gituser
			read -p "Github Password: " gitpass
			read -p "Github Token: " githubToken
			screen -d -m -S uploader-"$gitrepo.$rootdomain"
			screen -S uploader-"$gitrepo.$rootdomain" -X stuff "bash /root/cdoc/scripts/_pythongit.sh "$CDOCSRV" "$cdocproject" "$gitrepo" "$rootdomain" "$gituser" "$gitpass" "$githubToken""$(echo -ne '\015')
			;;

		*)
			ask=0
			;;
	esac
done