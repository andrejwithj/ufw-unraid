#!/bin/bash
CONFIGDIR=/boot/config/plugins/ufw

config() {
	NEW="$1"
	OLD="${1%.new}"
	# If there's no config file by that name, mv it over:
	if [ ! -r $OLD ]; then
	mv $NEW $OLD
	elif [ "$(md5sum < $OLD)" = "$(md5sum < $NEW)" ]; then
	# toss the redundant copy
	rm $NEW
	fi
	ln -sr $OLD -t /etc/$(basename $(dirname $OLD))
	}

shopt -s globstar
for file in $CONFIGDIR/**/*.new ; do
	if [ ! -r $file ]; then
		break
	else
		config $file
	fi
done

