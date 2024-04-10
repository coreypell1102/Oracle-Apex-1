#!/bin/bash
# Wait for Oracle Database to fully start
echo "Waiting for Oracle Database to be fully operational..."
while ! sqlplus -s / as sysdba <<< "exit" >/dev/null 2>&1; do
  sleep 10
done
echo "Oracle Database is operational."

# Navigate to the APEX installation directory
cd /opt/oracle/apex

# Install APEX
sqlplus / as sysdba <<EOF
-- Installing APEX
@apexins.sql SYSAUX SYSAUX TEMP /i/
-- Configure RESTful Services (optional)
@apex_rest_config.sql
-- Add additional configuration as necessary
EOF
