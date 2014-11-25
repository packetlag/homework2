homework2
=========
change_name.sh is just a skeleton describing inital input parameters, testing/validation
against arguments, followed by a sophmoric attempt to simulate what I believe this tool
should look like when executed. A final request (y/n) to confirm the change is presented before executing.

It will refuse to run if no arguments are passed, as well as if syntax of -d, -o, and -n fail
to be formated properly. -h has a bit of proper formatting notes.

## Sample script execution ##
./change_name.sh -d "andrew.com." -o "test-server-1 IN CNAME iad17" -n "test-server-1 IN CNAME iad18"
