#!/bin/bash
set -e

UFP_SOCKETS_DIR=/var/run/unifi-protect
UFP_BACKUPS_DIR=/etc/unifi-protect/backups
UFP_DATADIR=/srv/unifi-protect
UFP_TMPFS_DIR=/srv/unifi-protect/temp
UFP_TMPFS_SIZE=256m

. /etc/default/unifi-protect

. /usr/share/unifi-protect/app/hooks/pre-start

/usr/bin/node --expose_gc --optimize_for_size --memory_reducer --max_old_space_size=512 /usr/share/unifi-protect/app/daemon.js
