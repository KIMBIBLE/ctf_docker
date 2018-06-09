#!/bin/sh

data=$(sudo docker ps -a | awk '{print $NF}' | sed s/NAMES//)
for each in $data
do
        echo $each
            sudo docker rm $each -f
        done
        echo $(sudo docker ps -a)
