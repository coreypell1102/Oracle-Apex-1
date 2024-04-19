# Use an official Oracle Database image as the base
FROM container-registry.oracle.com/database/express:latest

# Define environment variables for the installation and configuration
ENV APEX_VERSION=21.2_en \
    ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE \
    ORACLE_SID=XE \
    APEX_INSTALL_DIR=/opt/apex

# Switch to the root user
USER root

# Copy the entrypoint script from your host to the image and make it executable
COPY entrypoint.sh /opt/oracle
RUN chmod +x /opt/oracle/entrypoint.sh

# Make the APEX installation directory
RUN mkdir -p ${APEX_INSTALL_DIR}

# Set the working directory
WORKDIR ${APEX_INSTALL_DIR}

# Copy the APEX installation archive from your host to the image
COPY apex_${APEX_VERSION}.zip ${APEX_INSTALL_DIR}/

# Unpack the APEX installation archive and prepare for configuration
RUN unzip $APEX_INSTALL_DIR/apex_${APEX_VERSION}.zip -d $APEX_INSTALL_DIR/ && \
    rm -rf $APEX_INSTALL_DIR/apex_${APEX_VERSION}.zip && \
    mv apex/* ${APEX_INSTALL_DIR}/ && \
    rm -rf $APEX_INSTALL_DIR/apex/ && \
    chown -R oracle:root ${APEX_INSTALL_DIR}

# Switch back to the oracle user
USER oracle

# Expose the default TNS listener port
EXPOSE 1521

# Define the entrypoint script
ENTRYPOINT ["/opt/oracle/entrypoint.sh"]
CMD [ "/opt/oracle/runOracle.sh" ]