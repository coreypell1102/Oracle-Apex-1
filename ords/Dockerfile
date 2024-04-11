FROM openjdk:11-jre-bullseye

# Environment variables
ENV ORDS_VERSION=21.4.3 \
    ORDS_HOME=/opt/oracle/ords \
    ORACLE_DB_HOST=oracle-db \
    ORACLE_DB_PORT=1521 \
    ORACLE_SID=ORCLCDB \
    ORACLE_PWD=oracle \
    APEX_PUBLIC_USER_PWD=ApexR3st \
    CONFIG_DIR=/opt/oracle/ords/config
# Make directories
RUN mkdir -p $ORDS_HOME
RUN mkdir -p $CONFIG_DIR

# Set the working directory
WORKDIR $ORDS_HOME

# Install necessary packages
RUN apt-get update && \
    apt-get install -y unzip && \
    apt-get clean

# Copy ORDS and the parameter file into the image
COPY ords-${ORDS_VERSION}.zip $ORDS_HOME/
COPY ords_params.properties $CONFIG_DIR/ords_params.properties

# Unpack ORDS and prepare for configuration
RUN unzip ords-${ORDS_VERSION}.zip && \
    rm ords-${ORDS_VERSION}.zip && \
    mkdir -p $CONFIG_DIR && \
    java -jar ords.war configdir $CONFIG_DIR
    #java -jar ords.war install --parameterFile $CONFIG_DIR/ords_params.properties simple

# Expose the port ORDS listens on
EXPOSE 8080

#CMD ["java", "-jar", "/opt/oracle/ords/ords.war", "install", "simple", "--parameterFile", "/opt/oracle/ords/config/ords_params.properties"]
CMD [ "tail", "-f", "/dev/null" ]