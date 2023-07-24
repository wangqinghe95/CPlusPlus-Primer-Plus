#!/bin/bash

set -u
sudo useradd $1
echo "$2" | sudo chpasswd $1
