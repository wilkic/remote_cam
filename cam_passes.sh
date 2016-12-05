#!/bin/bash

DATETIME=`date +%Y%m%d%H%M%S`

ips=(
    '192.168.1.251'
    '192.168.1.251'
    '192.168.1.251'
    )

dest='ubuntu@ec2-54-172-171-223.compute-1.amazonaws.com:/mnt/data/catch/bpark/.'

sp="  "
es="';"
i=0
for ip in ${ips[@]}; do
    hurl='http://'$ip'/cgi-bin/getsnapshot.cgi'
    echo "Fetching snap from $ip"
    echo "... $hurl"
    ((i++))
    wget $hurl -O cam$i.jpg
    
    DATE=`date +%F`
    TIME=`date +%T`
    ss="let text$i = '"
    echo $ss$DATE$sp$TIME$es > ts$i.js
    
    scp -i "ggp1.pem" cam$i.jpg ts$i.js $dest
done

##rtsp_port='554'
##rurl='rtsp://'$ip':'$rtsp_port'/live0.264'
##ffmpeg -r 25 -y -i $rurl -updatefirst 1 -r 2 cam.bmp

