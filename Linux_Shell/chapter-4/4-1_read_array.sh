#!/bin/bash

root=($(df / | tail -n +2))

echo ${root[*]}
