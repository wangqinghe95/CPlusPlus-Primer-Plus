#!/bin/bash

for i in `ls /etc/*.conf`
do
	tar -czf /tmp/log/$(basename $i).tar.gz $i
done
