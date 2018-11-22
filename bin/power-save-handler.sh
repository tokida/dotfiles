#!/bin/bash
powertop --auto-tune
echo 'on' > '/sys/bus/usb/devices/2-1/power/control';
exit 0
