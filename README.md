# SiLK and FlowBAT in Docker

Docker image containing SiLK (and associated files) collect Netflow info, 
as well as FlowBAT to provide a graphical display.

**_THIS DOCKERFILE DOES NOT WORK YET_** I'm posting it to github to see if I can get it working.

## To Build the Docker Image

cd to the directory containing these files and type:

`docker build -t silk-flowbat .      # This will take a while the first time`

## To poke around with ssh

```
docker run -d silk-flowbat                      # start the image, detached from the terminal
docker ps                                       # to get the container name
docker exec -i -t <container-name> /bin/bash    # get a shell on the running container
```

## To start debugging

Set up the environment variables

```
cd FlowBAT                      # This is the standard FlowBAT main directory
sudo service mongodb start      # Start the mongodb service
. /home/flowbat/FlowBAT/settings/meteorsettings.json
export PORT=1800
export MONGO_URL=mongodb://localhost:27017/flowbat
export ROOT_URL=http://localhost
```
Then invoke the main.js - it gives the following error:

```
node /home/flowbat/FlowBAT/private/bundle/main.js

/home/flowbat/FlowBAT/private/bundle/programs/server/node_modules/fibers/future.js:245
            throw(ex);
                  ^
TypeError: Cannot read property 'isDebug' of undefined
    at lib/app.coffee:162:39
    at lib/app.coffee:1:1
    at /home/flowbat/FlowBAT/private/bundle/programs/server/boot.js:222:10
    at Array.forEach (native)
    at Function._.each._.forEach (/home/flowbat/FlowBAT/private/bundle/programs/server/node_modules/underscore/underscore.js:79:11)
    at /home/flowbat/FlowBAT/private/bundle/programs/server/boot.js:117:5
```

## References

SiLK and FlowBat installed via slimmed-down (non-interactive) versions of *silkonabox.sh* and *install\_flowbat\_ubuntu.sh* from [http://FlowBAT.com](http://FlowBAT.com)

Other Sources of information:

* Flowbat: http://flowbat.com
* SiLK installation script (from Flowbat): http://download.flowbat.com/silkonabox.sh
* Other items in the "Reference Material" folder
* CERT.org's instructions:
  HTML: http://tools.netsa.cert.org/silk/silk-install-handbook.html
  PDF:  http://tools.netsa.cert.org/silk/silk-install-handbook.pdf

The SiLK installation supports:
  - Netflow 1, 5, 9, IPFIX, and sFlow formats
  - Single (multiple?) exporters
  - No PySiLK
