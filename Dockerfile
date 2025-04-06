FROM ubuntu:22.04

# Install Java and wget
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget

# Download and install Tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.39/bin/apache-tomcat-10.1.39.tar.gz && \
    tar -xvf apache-tomcat-10.1.39.tar.gz && \
    mv apache-tomcat-10.1.39 /usr/local/tomcat && \
    rm apache-tomcat-10.1.39.tar.gz

# Set the working directory
WORKDIR /usr/local/tomcat

# Copy the WAR file
COPY Amazon.war webapps/

# Expose the port
EXPOSE 8080

# Start Tomcat
ENTRYPOINT ["sh", "bin/catalina.sh", "run"]

