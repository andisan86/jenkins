# jenkins

## Contents
This Jenkins image has the following:
- Latest Jenkins LTS
- OpenJDK 8
- Maven 3
- Nano
- Git
- Minimal plugins to get CI process started

## Pre-installed Jenkins plugins
- Maven Integration
- Docker and Docker Slaves
- Build Pipeline
- Config File Provider
- Console Column
- Copy to Slave
- Extra Columns
- Favorite
- Folder
- Git
- HTML Publisher
- Javadoc
- Workflow Aggregator
- Docker Build Step

## How to run
1. Pull the docker image: `docker pull andisan/jenkins`
2. Run with this command: `docker run -d -p 8080:8080 -p 50000:50000 -v /var/jenkins_home andisan/jenkins`

## Jenkins global tool configuration
Jenkins global tools are not configured by default. After container is started, supply these variables in Jenkins > Global Tool Configuration:
* JDK > JAVA_HOME: /docker-java-home
* Maven > MAVEN_HOME: /opt/maven

## Additionals
Included is a docker-compose.yml which starts up this Jenkins image and a Selenium Grid setup (a hub, a Firefox node and a Chrome node)
