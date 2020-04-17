#!/bin/sh
#
# bat_watcher.sh
# Copyleft (C) 2020 hyphenrf
#
# Distributed under terms of the MIT license.
#

hb=/usr/local/bin/hb

acpi=/usr/bin/acpi
notify=/usr/bin/notify-send
grep=/bin/grep


if $acpi -b |$grep -v Charging
then
	percent=$( $acpi -b |cut -d, -f2 |tr -d '% ' )
	
	[ $percent -gt 15 ] || {
		
		$notify -u critical -i gnome-power-manager "Bat Watcher" \
		"Battery critical: $percent%, hibernating in 10 seconds";

		sleep 10;

		if $acpi -b |$grep -v Charging; 
		then $hb; 
		fi;
	}
fi

