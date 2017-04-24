#! /bin/sh
#
# startup script for FlowBAT/SiLK Docker instance
# Run when Docker instance is started up

# exec > >(tee -a /home/flowbat/FlowBAT/flowbat.log) 
# exec 2> >(tee -a /home/flowbat/FlowBAT/flowbat.log >&2) 

# Start rwflowpack
/usr/local/sbin/rwflowpack --compression-method=best --sensor-configuration=/data/sensors.conf --site-config-file=/data/silk.conf --output-mode=local-storage --root-directory=/data/ --pidfile=/var/log/rwflowpack.pid --log-level=info --log-directory=/var/log --log-basename=rwflowpack

# Start yaf
nohup /usr/local/bin/yaf --silk --ipfix=tcp --live=pcap  --out=127.0.0.1 --ipfix-port=18001 --in=eth0 --applabel --max-payload=384

# start mongodb
sudo service mongodb start

cat /home/flowbat/FlowBAT/flowbat.log

# start FlowBAT
. /home/flowbat/FlowBAT/startFlowBAT.sh

