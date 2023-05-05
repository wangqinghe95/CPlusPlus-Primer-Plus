#!/bin/bash

banana=1
for i in {1..8}
do
	banana=$[(banana+1)*2]
done

echo $banana
