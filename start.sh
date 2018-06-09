#!/bin/sh

echo made by bbkim
service ssh restart

while [ true ]; do
    socat -dd tcp-listen:6969,reuseaddr,fork,bind=0.0.0.0 exec:/home/guest/injectme
    sleep 1
done
