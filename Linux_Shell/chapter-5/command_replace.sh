#!/bin/bash

echo -e "system CPU load:\n$(date +%Y-%m-%d;uptime)"


echo -e "system CPU load:\n`date +%Y-%m-%d;uptime`"

echo "The number of log in:$(who | wc -l)"
echo "The number of log in:`who | wc -l`"

du -sh $(pwd)
