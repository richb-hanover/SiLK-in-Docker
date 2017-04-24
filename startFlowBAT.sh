#! /bin/sh
#
# startup script for FlowBAT

# Start the mongodb
# sudo service mongodb restart

# Start the meteor server
echo 'Starting meteor server...'
export PORT=1800
export MONGO_URL=mongodb://localhost:27017/flowbat
export ROOT_URL=http://localhost
cat /home/flowbat/FlowBAT/settings/meteorsettings.json
. /home/flowbat/FlowBAT/settings/meteorsettings.json
export METEOR_SETTINGS
exec node /home/flowbat/FlowBAT/private/bundle/main.js >> /home/flowbat/FlowBAT/flowbat.log

