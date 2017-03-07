FROM jenkinsci/jenkins:lts

MAINTAINER Andi Santoso

# change to root to install tools
USER root

# install wget
RUN apt-get update && apt-get install -y wget

# get maven 3.3.9
ENV maven_version 3.3.9
ENV maven_checksum 516923b3955b6035ba6b0a5b031fbd8b
RUN wget --no-verbose -O /tmp/apache-maven-${maven_version}.tar.gz http://archive.apache.org/dist/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz

# verify checksum
RUN echo "${maven_checksum} /tmp/apache-maven-${maven_version}.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-${maven_version}.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-${maven_version} /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-${maven_version}.tar.gz
ENV MAVEN_HOME /opt/maven

# install git
RUN apt-get install -y git

# install nano
RUN apt-get install -y nano

# install docker
RUN apt-get -y dist-upgrade
RUN apt-get install -y apt-transport-https ca-certificates
RUN sh -c "echo deb https://apt.dockerproject.org/repo debian-jessie main > /etc/apt/sources.list.d/docker.list"
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN apt-get update
RUN apt-get install -y docker-engine
RUN service docker start

# remove download archive files
RUN apt-get clean

# switch back to jenkins user
USER jenkins

# disable security for Jenkins 2.x
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# install Jenkins plugins
RUN /usr/local/bin/install-plugins.sh maven-plugin docker-plugin docker-slaves build-pipeline-plugin config-file-provider console-column-plugin copy-to-slave extra-columns favorite cloudbees-folder git htmlpublisher javadoc workflow-aggregator docker-build-step
