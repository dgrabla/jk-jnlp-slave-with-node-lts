# Jenkins JNPL slave with node lts
FROM jenkinsci/jnlp-slave:latest

USER root

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get install -y nodejs

RUN chown -R jenkins:jenkins /home/jenkins

USER jenkins
