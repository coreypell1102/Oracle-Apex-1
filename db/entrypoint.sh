#!/bin/bash

# start Oracle Database
/opt/oracle/runOracle.sh

# Wait for Oracle Database to fully start
echo "Waiting for Oracle Database to be fully operational..."
while ! sqlplus -s / as sysdba <<< "exit" >/dev/null 2>&1; do
  sleep 10
done
echo "Oracle Database is operational."

# Install APEX
cd $APEX_INSTALL_DIR && unzip apex_${APEX_VERSION}.zip && cd apex

# Install APEX
sqlplus / as sysdba <<EOF
-- Installing APEX
@apexins.sql SYSAUX SYSAUX TEMP /i/
-- Configure RESTful Services (optional)
@apex_rest_config.sql oracle oracle
-- Add additional configuration as necessary
EOF

# Continue running the container
exec "$@"