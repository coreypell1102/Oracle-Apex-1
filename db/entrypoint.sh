#!/bin/bash

# whatever set -e does
set -e

# Start Oracle
/opt/oracle/runOracle.sh &

# Sleep for 1 minute to give Oracle time to create the default DB
sleep 1m &&

# Set the sys password
/home/oracle/setPassword.sh oracle &&

# Install Oracle APEX
echo -e "exit" | sqlplus sys/oracle as sysdba @apexins.sql SYSAUX SYSAUX TEMP /i/ &&

# Reset the apex_public_user password and unlock the account
echo -e "alter user apex_public_user identified by oracle account unlock;\nexit" | sqlplus sys/oracle as sysdba &&

# Congigure Oracle APEX RESTful Services
echo -e "oracle\noracle\nexit" | sqlplus sys/oracle as sysdba @apex_rest_config.sql &&

# create a new Instance Admin (this need work WIP)
#echo -e "admin\nadmin\nWelcome_1\n" | sqlplus sys/oracle as sysdba @apxchpwd.sql &&

# Continue to run the container as normal
exec "$@"