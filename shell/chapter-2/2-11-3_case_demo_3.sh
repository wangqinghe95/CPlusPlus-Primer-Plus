#!/bin/bash

read -p "Are you sure to exec this operation [y|n]: " key
case $key in
# [Yy] | [Yy] [Ee] [Ss])
[Yy]|[Yy][Ee][Ss])
    echo "Attention! you choose is yes";;
[Nn]|[Nn][Oo])
    echo "Attention! you choose is no";;
*)
    echo "Invalid input";;
esac
