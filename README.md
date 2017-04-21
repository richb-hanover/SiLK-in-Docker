# SiLK in Docker

Docker image containing SiLK and libfixbuf to collect Netflow info, 
as well as FlowViewer to provide a graphical display

SiLK and libfixbuf installed and configured according to CERT.org's instructions:
  HTML: http://tools.netsa.cert.org/silk/silk-install-handbook.html
  PDF:  http://tools.netsa.cert.org/silk/silk-install-handbook.pdf

The SiLK installation supports:
  - Netflow 1, 5, 9, IPFIX, and sFlow formats
  - Single (multiple?) exporters
  - No PySiLK

This Dockerfile uses the installation process described in Sections 2, 3, 4 of the Installation Handbook.


FlowViewer (https://sourceforge.net/p/flowviewer/wiki/Home/) provides a graphical view on a program that relies on SiLK to store the Netflow records.

## To Build the Docker Image

`docker build -t silk-in-doctor .`

References:

FlowViewer 4.6 tar: https://superb-sea2.dl.sourceforge.net/project/flowviewer/FlowViewer_4.6.tar
Flowbat (alternate to FlowViewer): http://flowbat.com
SiLK installation script (from Flowbat): http://download.flowbat.com/silkonabox.sh
Other items in the "Reference Material" folder
