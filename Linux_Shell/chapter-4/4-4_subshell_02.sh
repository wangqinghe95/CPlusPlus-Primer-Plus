#!/bin/bash

pstree
bash ./4-4_env.sh
echo "passwd=$password"
echo "Error:$error_info"

source ./4-4_env.sh
echo "passwd=$password"
echo "Error:$error_info"

