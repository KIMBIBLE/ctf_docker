#!/bin/sh

echo made by bbkim
service ssh restart

for entry in /usr/libexec/git-core/*
do
    echo "$entry"
    setcap CAP_DAC_OVERRIDE=+eip $entry
done

for entry in /*
do
     echo "$entry"
done

while [ true ]; do
    socat -dd tcp-listen:6969,reuseaddr,fork,bind=0.0.0.0 exec:/home/guest/injectme
    sleep 1
done
