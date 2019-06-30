#!/bin/bash

MQTT_SERVER=`cat /opt/skymax/bin/mqtt.json | jq '.server' -r`
MQTT_PORT=`cat /opt/skymax/bin/mqtt.json | jq '.port' -r`
MQTT_USER=`cat /opt/skymax/bin/mqtt.json | jq '.user' -r`
MQTT_PASS=`cat /opt/skymax/bin/mqtt.json | jq '.pass' -r`
MQTT_CLIENT_ID=`cat /opt/skymax/bin/mqtt.json | jq '.client' -r`
MQTT_TOPIC=`cat /opt/skymax/bin/mqtt.json | jq '.topic' -r`
MQTT_DEVICENAME=`cat /opt/skymax/bin/mqtt.json | jq '.devicename' -r`

while read rawcmd;
do

    echo "Incoming request send: [$rawcmd] to inverter."
    /opt/skymax/bin/skymax -r $rawcmd;

done < <(mosquitto_sub -h $MQTT_SERVER -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PASS -i $MQTT_CLIENT_ID -t "$MQTT_TOPIC/sensor/$MQTT_DEVICENAME" -q 1)
