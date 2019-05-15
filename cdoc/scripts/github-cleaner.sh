#!/bin/bash
NF='\e[0m'
GC='\e[92m'
RC='\e[91m'
BC='\e[94m'
BF='\e[1m'

## Prompt for inputs
read -p "Github User: " githubUser
read -p "Github Pass: " githubPass

for row in $(curl -s -u "$githubUser":"$githubPass" https://api.github.com/user/repos | jq -r '.[] | @base64'); do
	_jq() {
		echo ${row} | base64 --decode | jq -r ${1}
	}
	repo=$(_jq '.name')

	curl -s -u "$githubUser":"$githubPass" -X DELETE https://api.github.com/repos/"$githubUser"/"$repo"
	echo "Repo $repo removed"
	sleep 3s
done