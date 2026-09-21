#!/bin/bash

LOG="$HOME/system-update.log"

echo "==== Update started: $(date) ====" >> "$LOG"

#Update Package lists
if sudo apt-get update >> "$LOG" 2>&1
then
	echo "Package list update succesful." >> "$LOG"
else
	echo "ERROR: Package list update failed." >> "$LOG"
	echo "==== Update failed $(date) ====" >> "$LOG"
	echo "" >> "$LOG"
	exit 1
fi

#Install available upgrades
if sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y >> "$LOG" 2>&1
then
	echo "Package upgrade successful." >> "$LOG"
else
	echo "ERROR: Package upgrade failed." >> "$LOG"
	echo "==== Update failed: $(date) ====" >> "$LOG"
	echo "" >> "$LOG"
	exit 1
fi

#Show succesful script
echo "==== Update completed succesfully: $(date) ====" >> "$LOG"
echo "" >> "$LOG"

exit 0
