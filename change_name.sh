#!/bin/bash

## This script is designed to take in three parameters and execute restAPI calls against Nuestar's UltraDNS product.


## This section validates that you've passed the right number of arguments at initiation of script.
 
if (($# == 0)); then
   printf "\n""You are missing the domain (-d \"<arg>\"), old cname record (-o \"<arg>\"), and new cname record (-n \"<arg>\").""\n""Try using -h for help. ""\n\n"
   exit 1
elif (($# >=2 && $# <= 5)); then
   printf "\n""You may be missing one or more aguments.""\n""Try using -h for help.""\n\n"
   exit 1
elif (($# >= 7)); then
   printf "\n""You have too many arguments. Or you forgot to incapsulate arguments with quotes.""\n""Try using -h for help.""\n\n"
   exit 1
fi

## This section validates inputs are 
#echo $#


## This section parses the arguments passed to the script, rejecting those that require additional input but is missing said input.

while getopts ":d:o:n:h" opt; do
  case $opt in
    h)
      printf "\n""This tool is intended for updating cname records for a specific zone.""\n""Usage: $ ./chang_name.sh -d \"<domain>\" -o \"<old_cname>\" -n \"<new_cname>\" ""\n\n""** Don't forget to incapsulate arguments with quotes - \"\" **""\n\n"
      exit 0
      ;;
    d)
      printf "Domain:  $OPTARG""\n"
      DOMAIN=$OPTARG
      ;;
    o)
      printf "Old CNAME:  $OPTARG""\n"
      OLD_CNAME=$OPTARG
      ;;
    n)
      printf "New CNAME:  $OPTARG""\n"
      NEW_CNAME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done


#echo $DOMAIN, $OLD_CNAME, $NEW_CNAME


## This section pretends to interface with UltraDNS REST API, executing the dersired cname change captured above.

# We need to generate an authorization token. I understand it is a terrible idea to hardcode unhashed credentials (or at all) in a script.
USER_NAME=andrew
PASSWORD=password

# Requests token be generated
printf "\n""Generating authorizaion token...""\n"
sleep 2

printf "POST /v1/authorization/token""\n"
#POST /v1/authorization/token
sleep 2

printf "grant_type=password&username=$USER_NAME&password=$PASSWORD""\n""Content-Type: application/x-www-form-urlencoded""\n\n"
sleep 2

# Token is retrieved and stored 
printf "Retrieving authorization token...""\n"
sleep 1

printf "AUTH_TOKEN = GET /v1/authorization/token""\n"
#AUTH_TOKEN = GET /v1/authorization/token
AUTH_TOKEN=lfdskjw3lj2o9u3209qrlkef1p30rlkj21
printf $AUTH_TOKEN"\n\n"
sleep 1

printf "Retrieving CNAMES for domain $DOMAIN ...""\n"
sleep 1

printf "GET /v1/zones/$DOMAIN./rrsets/CNAME""\n"
sleep 2

printf "chef-server-1 IN CNAME iad15""\n""chef-server-2 IN CNAME iad16""\n""$OLD_CNAME""\n\n"

read -p "You are about to change CNAME records from:
** $OLD_CNAME **
to
** $NEW_CNAME ** 
-- Execute? [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    printf "\n""POST /v1/zones/$DOMAIN/rrsets/CNAME/$NEW_CNAME""\n"
    exit 0
else
    printf "\n""Aborting production change""\n"
fi

exit
