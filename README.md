# jenkins

This Jenkins image has the following:
- Latest Jenkins LTS
- OpenJDK 8
- Maven 3
- Nano
- Git
- Minimal plugins to get CI process started

Also included is a docker-compose.yml which starts up this Jenkins image and a Selenium Grid setup (a hub, a Firefox node and a Chrome node).

Pre-installed Jenkins plugins:
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

This image is inspired by JenkinsCI (https://hub.docker.com/r/jenkinsci/jenkins/) and Stephen Reed's Jenkins repo (https://hub.docker.com/r/stephenreed/jenkins-java8-maven-git/).
