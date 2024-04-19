FROM openjdk:11-jre-bullseye

# Environment variables
ENV ORDS_VERSION=21.4.3 \
    ORDS_HOME=/opt/ords

# Make directories
RUN mkdir -p ${ORDS_HOME}

# Set the working directory
WORKDIR ${ORDS_HOME}

# Install necessary packages
RUN apt-get update && \
    apt-get install -y unzip && \
    apt-get clean

# Copy ORDS zip
COPY ords-${ORDS_VERSION}.zip $ORDS_HOME/

# Unpack ORDS and prepare for configuration
RUN unzip ords-${ORDS_VERSION}.zip && \
    rm -rf ords-${ORDS_VERSION}.zip && \
    java -jar ords.war configdir ${ORDS_HOME}

# Remove old params file and copy over new param file
RUN rm -rf ${ORDS_HOME}/params/ords_params.properties
COPY ords_params.properties ${ORDS_HOME}/params/ords_params.properties

# Expose the port ORDS listens on
EXPOSE 8081

CMD ["java", "-jar", "ords.war", "install", "simple", "--parameterFile", "params/ords_params.properties", "--silent"]
#CMD ["tail", "-f", "/dev/null"]