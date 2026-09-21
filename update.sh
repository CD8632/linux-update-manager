#!/bin/bash

LOG="$HOME/system-update.log"
#First bash logging function
log_message() {
	echo "$1" | tee -a "$LOG"
}
log_message "==== Update started: $(date) ===="

#Update Package lists
if sudo apt-get update >> "$LOG" 2>&1
then
	log_message "Package list update successful."
else
	log_message "ERROR: Package list update failed."
	log_message "==== Update failed $(date) ===="
	echo "" >> "$LOG"
	exit 1
fi

#Install available upgrades
if sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y >> "$LOG" 2>&1
then
	log_message "Package upgrade successful."
else
	log_message "ERROR: Package upgrade failed."
	log_message "==== Update failed: $(date) ===="
	echo "" >> "$LOG"
	exit 1
fi

#Show successful script
log_message "==== Update completed successfully: $(date) ===="
echo "" >> "$LOG"

exit 0
