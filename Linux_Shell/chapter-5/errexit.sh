#!/bin/bash

# 通过 set -e 

set -e
sudo useradd luis
echo "123456" | sudo chpasswd luis
echo "Modify successfully"

