#!/bin/sh
#
# bat_watcher.sh
# Copyleft (C) 2020 hyphenrf
#
# Distributed under terms of the MIT license.
# TODO: these scripts run as root - things like notify-send won't work in user
# session, not trivially.

hb=/usr/local/bin/hb
crit=15

acpi=/usr/bin/acpi
notify=/usr/bin/notify-send
grep=/bin/grep


if $acpi -b |$grep -qv Charging
then
	percent=$( $acpi -b |cut -d, -f2 |tr -d '% ' )
	
	[ $percent -gt $crit ] || {
		
		$notify -u critical -i gnome-power-manager "Bat Watcher" \
		"Battery critical: $percent%, hibernating in 10 seconds" ;

		sleep 10;

		if $acpi -b |$grep -qv Charging; 
		then $hb; 
		fi;
	}
fi

