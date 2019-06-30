#!/bin/bash
export TERM=xterm

# Init the mqtt server for the first time, then every 5 minutes
# This will re-create the auto-created topics in the MQTT server if HA is restarted...
watch -n 300 /opt/skymax/bin/mqtt-init.sh > /dev/null 2>&1 &

# Run the MQTT Subscriber process in the background (so that way we can change the configuration on the inverter from home assistant)
/opt/skymax/bin/mqtt-subscriber.sh &

# execute exactly every 30 seconds...
watch -n 30 /opt/skymax/bin/mqtt-push.sh > /dev/null 2>&1
