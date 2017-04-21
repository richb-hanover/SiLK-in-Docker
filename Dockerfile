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
WORKDIR /home/$USERACCT

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

# COPY install_flowbat_ubuntu.sh $USERHOME # 

# RUN export TERM=dumb \
#     && ls -al \
#     && sudo chown $USERACCT:$USERACCT install_flowbat_ubuntu.sh \
#     && chmod +x install_flowbat_ubuntu.sh \
#     && export TERM=dumb \
#     && ./install_flowbat_ubuntu.sh


CMD pwd \
    && whoami \
    && ls -al \
#     && cd FlowBAT \
    && cat startup.sh \
    && sudo /bin/sh startup.sh
