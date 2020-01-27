#!/bin/sh
set +x

ssh-keygen -A
chown borg.borg /backups

mkdir -p /home/borg/.ssh
touch /home/borg/.ssh/authorized_keys

chown -R borg.borg /home/borg/.ssh
chmod 700 /home/borg/.ssh
chmod 644 /home/borg/.ssh/authorized_keys

/usr/bin/supervisord