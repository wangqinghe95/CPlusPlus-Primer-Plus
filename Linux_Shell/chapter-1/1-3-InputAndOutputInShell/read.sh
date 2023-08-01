#!/bin/bash
<<READCOMMONLYUSEDOPTIONS
-p: show prompt message
-t: set the timeout time for read-in data
-n: set the number of read-in characters, one line of data is read by default
-r: support for read character '\', which is regarded as an escape character
-s: the slient mode, which doesn't display the standard input
READCOMMONLYUSEDOPTIONS

# this 
# Read User's name and password from standard input
read -p "please input user name:" user
read -s -p "please input password:" pass
useradd "$user"
echo "$pass" | passwd --stdin "$user"

# read read content from standard input, for example, read data from terminal