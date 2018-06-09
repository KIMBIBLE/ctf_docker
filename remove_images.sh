#!/bin/sh

data=`sudo docker images | awk '{print $3}' | sed s/IMAGE//`
for each in $data
do
        echo $each
            sudo docker rmi -f $each
        done
        echo `sudo docker images`
