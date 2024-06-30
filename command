#!/bin/bash

echo -e "\nCommand and Control script for CubeSatSim v1.3.2\n"

sleep 20

	FILE=/home/pi/CubeSatSim/command_control
	if [ -f "$FILE" ]; then
    		echo "Radio command and control is ON"
#			echo "Turning Command and control to OFF"
#			sudo rm /home/pi/CubeSatSim/command_control
#			echo "rebooting"
#			sudo systemctl stop rpitx
#			sudo reboot now	
#		fi

	else 
    		echo "Radio command and control is OFF"
		exit 1
	fi


# if [[ $(grep 'dtparam=audio=on' /boot/config.txt) ]]; then
 if [[ $(arecord -l | grep card) ]]; then

	echo "Starting direwolf"

	if [ "$1" = "d" ]; then
	
		echo "debug mode"
	
		direwolf -c /home/pi/CubeSatSim/direwolf-cc.conf -t 0l | python3 /home/pi/CubeSatSim/aprs_in.py d
	
	else
	
		direwolf -c /home/pi/CubeSatSim/direwolf-cc.conf -t 0l | python3 /home/pi/CubeSatSim/aprs_in.py
	
	fi
else
	echo "Starting squelch C&C"

	if [ "$1" = "d" ]; then
	
		echo "debug mode"
	
		python3 /home/pi/CubeSatSim/squelch_cc.py d
	
	else
	
		python3 /home/pi/CubeSatSim/squelch_cc.py
	
	fi	 
fi
