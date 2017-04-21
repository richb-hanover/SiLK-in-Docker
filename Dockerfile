# Dockerfile for docker-silk-flowviewer
# SiLK from cert.org is a netflow/sFlow/ipfix collector
# FlowViewer from NASA is a web-based graphical display program

FROM ubuntu:trusty
MAINTAINER Rich Brown <richb.hanover@gmail.com>

# Current versions as of March 2017
ENV LIBFIXBUF_VERSION 1.7.1
ENV SILK_VERSION 3.15.0
ENV RRD_TOOL 1.6.0
ENV FLOWVIEWER 4.6.1

RUN apt-get update && apt-get -y install \
    wget

RUN wget http://download.flowbat.com/silkonabox.sh \
    && chmod +x silkonabox.sh \
    && export TERM=dumb \
    && ./silkonabox.sh

