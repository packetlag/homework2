#!/bin/bash
 
if (($# == 0)); then
   echo "You need to define domain (-d arg), old cname record (-o arg), and new cname record (-n arg)"
fi

while getopts ":d:o:n:" opt; do
  case $opt in
    d)
      echo "-d was triggered, Parameter: $OPTARG" >&2
      echo
      echo "domain will be $OPTARG"
      echo
      ;;
    o)
      echo "-o was triggered, Parameter: $OPTARG" >&2
      echo
      echo "old cname was $OPTARG"
      echo
      ;;
    n)
      echo "-n was triggered, Parameter: $OPTARG" >&2
      echo
      echo "new cname will be $OPTARG"
      echo
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done


echo "POST /v1/authorization/token"
echo "grant_type=password&username=USER_NAME&password=PASSWORD"

echo "Content-Type: application/x-www-form-urlencoded"

echo "Authorization: Bearer ACCESS_TOKEN"


