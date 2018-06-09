#!/bin/sh
NAME="prob2"

PORT="-p 31338:22 -p 6969:6969"

OPTION="--rm --user guest"

sudo docker run --name $NAME $PORT -i -t -d $OPTION $SHARED $NAME:1.0 /bin/sh
