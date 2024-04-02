FROM container-registry.oracle.com/database/express:latest

# Environment variables
ENV ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
ENV ORACLE_SID=XE
ENV ORACLE_USER=sys
ENV ORACLE_PASSWORD=password1!
ENV PATH=$ORACLE_HOME/bin:$PATH
ENV APEX_ZIP=apex_21.2_en.zip
ENV APEX_PASSWORD=password1!

# Make oracle directory
RUN mkdir -p /opt/oracle

# Set the sys password
RUN /home/oracle/setPassword.sh $ORACLE_USER $ORACLE_PASSWORD

# Copy apex installation files
COPY $APEX_ZIP /opt/oracle

# Copy the setup.sql script
COPY setup.sql /tmp

# Unzip apex installation files
RUN unzip /opt/oracle/$APEX_ZIP -d /opt/oracle && \
    rm /opt/oracle/$APEX_ZIP && \
    cd /opt/oracle/apex

# Run the setup.sql script
RUN sqlplus sys/$ORACLE_PASSWORD as sysdba @/tmp/setup.sql

# Expose ports
EXPOSE 1521