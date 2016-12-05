#!/bin/sh
export DATETIME=`date +%Y%m%d%H%M%S`
export DATE=`date +%F`
export TIME=`date +%T`

ip='192.168.1.251'


hurl='http://'$ip'/cgi-bin/getsnapshot.cgi'
wget $hurl -O snap.jpg
#wget $hurl -O snap_$DATETIME.jpg


#rtsp_port='554'
#rurl='rtsp://'$ip':'$rtsp_port'/live0.264'
#ffmpeg -r 25 -y -i $rurl -updatefirst 1 -r 2 cam.bmp

ss="let text = '"
sp="  "
es="';"
echo $ss$DATE$sp$TIME$es > ts.js

scp -i "ggp1.pem" snap.jpg ts.js ubuntu@ec2-54-172-171-223.compute-1.amazonaws.com:/mnt/data/catch/camfwd/.
