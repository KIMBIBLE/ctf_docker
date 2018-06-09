#/bin/sh

ssh-keygen -f "/home/parallels/.ssh/known_hosts" -R [localhost]:31338
ssh -l guest localhost -p 31338
