#!/bin/bash
# test whether the computer's cpu band is AMD or Intel
# the parameter of -q means that the command of grep don't output result to screen

if grep -q AMD /proc/cpuinfo; then
echo "AMD CPU"
fi

if grep -q Intel /proc/cpuinfo; then
echo "Intel CPU"
fi
