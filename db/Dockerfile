# Use an official Oracle Database image as the base
FROM container-registry.oracle.com/database/express:latest

# Define environment variables for the installation and configuration
ENV APEX_VERSION=21.2_en \
    ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE \
    ORACLE_SID=XE \
    APEX_INSTALL_DIR=/opt/oracle

# Switch to the root user to perform installation steps
USER root

# Install necessary packages (example: unzip, rlwrap for convenience)
RUN yum install -y unzip rlwrap && \
    yum clean all

# Switch back to the Oracle user to perform Oracle-related installation tasks
USER oracle

# Copy the APEX installation archive from your host to the image
COPY apex_${APEX_VERSION}.zip $APEX_INSTALL_DIR/

# Install APEX
RUN cd $APEX_INSTALL_DIR && \
    unzip apex_${APEX_VERSION}.zip && \
    cd apex && \
    sqlplus / as sysdba <<EOF
-- Installing APEX
@apexins.sql SYSAUX SYSAUX TEMP /i/
-- Configure RESTful Services (optional)
@apex_rest_config.sql
-- Add additional configuration as necessary
EOF

# Expose the default TNS listener port
EXPOSE 1521
