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

# install transport https, ca certificates and add repo
#RUN apt-get install -y apt-transport-https ca-certificates software-properties-common
RUN apt-get install -y iptables init-system-helpers libapparmor1

# install Docker
#RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' && apt-get update && apt-get install -y docker-engine && apt-get -f install
#RUN apt-get -y install docker.io
#RUN ln -sf /usr/bin/docker.io /usr/local/bin/docker && sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
#RUN update-rc.d docker.io defaults
RUN wget --no-verbose https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_17.03.0~ce-0~debian-jessie_amd64.deb
RUN apt-get update
#RUN apt-get -f install
RUN dpkg -i docker-engine_17.03.0~ce-0~debian-jessie_amd64.deb

# remove download archive files
RUN apt-get clean

# switch back to jenkins user
USER jenkins

# disable security for Jenkins 2.x
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# install Jenkins plugins
RUN /usr/local/bin/install-plugins.sh maven-plugin docker-plugin docker-slaves build-pipeline-plugin config-file-provider console-column-plugin copy-to-slave extra-columns favorite cloudbees-folder git htmlpublisher javadoc workflow-aggregator docker-build-step
