#!/bin/bash
localIp=$(ifconfig | grep Mask | tr -s " " | cut -d " " -f3)
mem=$(free | grep Mem | tr -s " " | cut -d " " -f7)
cpu=$(uptime | tr -s " " | cut -d " " -f11)
echo "the local IP address:$localIp"
echo "the local remain memory:$mem"
echo "the CPU 15min average:$cpu"
