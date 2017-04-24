# SiLK and FlowBAT in Docker

Docker image containing SiLK (and associated files) collect Netflow info, 
as well as FlowBAT to provide a graphical display.

**_THIS DOCKERFILE DOES NOT WORK YET_** I'm posting it to github to see if I can get it working.

SiLK and libfixbuf installed and configured according to CERT.org's instructions:
  HTML: http://tools.netsa.cert.org/silk/silk-install-handbook.html
  PDF:  http://tools.netsa.cert.org/silk/silk-install-handbook.pdf

The SiLK installation supports:
  - Netflow 1, 5, 9, IPFIX, and sFlow formats
  - Single (multiple?) exporters
  - No PySiLK

FlowBat installed via slimmed-down (non-interactive) versions of *silkonabox.sh* and *install\_flowbat_ubuntu.sh* from [http://FlowBAT.com](http://FlowBAT.com)
## To Build the Docker Image

cd to the directory containing these files and type:

`docker build -t silk-flowbat .`

## To poke around with ssh

```
docker run -d silk-flowbat                      # start the image, detached from the terminal
docker ps                                       # to get the container name
docker exec -i -t *<container-name>* /bin/bash  # get a shell on the running container
```

## References

* Flowbat: http://flowbat.com
* SiLK installation script (from Flowbat): http://download.flowbat.com/silkonabox.sh
* Other items in the "Reference Material" folder
