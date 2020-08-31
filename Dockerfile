# Jenkins JNPL slave with node lts + cypress
# Base is the latest official jnlp-slace, which at the moment is a debian stretch image

# DGB 2020-08-31 12:36 Added libgdm for cypress 5

FROM jenkinsci/jnlp-slave:latest

USER root

# HOST is used by many frameworks to specify from where to accept traffic
ENV HOST 0.0.0.0

# Nuxt
EXPOSE 3000

# curl to install node
RUN apt-get update \
    && apt-get install -y jq curl

# node-gyp dependencies
RUN apt-get install -y \
  gyp \
  g++ \
  make

# cypress dependencies
RUN apt-get install --no-install-recommends -y \
  libgtk2.0-0 \
  libgtk-3-0 \
  libnotify-dev \
  libgconf-2-4 \
  libnss3 \
  libxss1 \
  libasound2 \
  libgbm1 \
  libxtst6 \
  xauth \
  xvfb

# 12.x is the LTS at the moment
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get install -y nodejs

RUN apt-get -y autoclean
RUN rm -rf /var/lib/apt/lists/*

# a few environment variables to make NPM installs easier
# good colors for most applications
ENV TERM xterm

# avoid million NPM install messages
ENV npm_config_loglevel warn

# Node libraries
RUN node -p process.versions

RUN chown -R jenkins:jenkins /home/jenkins

USER jenkins

# versions of local tools
RUN echo  " node version:    $(node -v) \n" \
  "npm version:     $(npm -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "user:            $(whoami) \n"
