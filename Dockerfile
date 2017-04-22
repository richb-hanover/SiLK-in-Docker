# Dockerfile for docker-silk-flowviewer
# SiLK from cert.org is a netflow/sFlow/ipfix collector
# FlowViewer from NASA is a web-based graphical display program

FROM ubuntu:trusty
MAINTAINER Rich Brown <richb.hanover@gmail.com>

# Current versions as of April 2017
ENV LIBFIXBUF_VERSION 1.7.1
ENV SILK_VERSION 3.15.0
ENV RRD_TOOL 1.6.0

ENV USERACCT flowbat

# ---------------------------
# Work as user USERACCT, not root

RUN useradd -ms /bin/bash $USERACCT \
    && echo "$USERACCT ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERACCT \
    && chmod 0440 /etc/sudoers.d/$USERACCT \
    && ls /etc/sudoers.d \
    && cat /etc/sudoers.d/README

USER $USERACCT
ENV USERHOME /home/$USERACCT
WORKDIR $USERHOME

# ---------------------------
# update and retrieve all packages necessary

RUN sudo apt-get update && sudo apt-get -y install \
    build-essential \
    checkinstall \
    curl \
    g++ \
    gcc \
    git-core \
    glib2.0 \
    libglib2.0-dev \
    libpcap-dev \
    make \
    mongodb-server \
    python-dev \
    wget

# ---------------------------
# Install SiLK &c

COPY silkonabox.sh $USERHOME

RUN ls -al \ 
    && sudo chown $USERACCT:$USERACCT silkonabox.sh \
    && chmod +x silkonabox.sh \
    && export TERM=dumb \
    && ./silkonabox.sh

# ---------------------------
# Install FlowBAT

RUN echo 'Installing node...' \
    && curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - \
    && sudo apt-get -y install nodejs 

RUN echo "Installing Meteor..." \
    && curl https://install.meteor.com | /bin/sh

RUN echo "Cloning and configuring FlowBAT..." \
    && cd $USERHOME \
    && git clone https://github.com/chrissanders/FlowBAT.git 

RUN cd $USERHOME/FlowBAT \ 
    && cat private/bundle/settings/prod.sample.json | \
      sed 's/flowbat.com/127.0.0.1:1800/' | \ 
      sed 's/mailUrl.*/mailUrl": "",/' \
      > private/bundle/settings/dev.json \
    && cd private/bundle/programs/server \
    && npm install

# Create startup configuration file for FlowBAT/
COPY flowbat.conf $USERHOME/ 

RUN sudo cp $USERHOME/flowbat.conf /etc/init/flowbat.conf

# ====== Icing on the cake - the actual startup script
CMD pwd \
    && whoami \
    && ls -al \
#     && cd FlowBAT \
    && cat startup.sh \
    && sudo /bin/sh startup.sh
