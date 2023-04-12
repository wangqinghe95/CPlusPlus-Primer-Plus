#!/bin/bash
echo "the current USER:$USER, current UID:$UID"
echo "the root folder:$PWD"
echo "A random number:$RANDOM"
echo "the current PID:$$"
echo "the first argu of current script:$1"
echo "the second argument:$2, third argument:$3"
echo "All arguments:$*"
echo "Prepare to create a file..."
touch "$*"
echo "Prepare to create more files..."
touch "$@"

ls /etc/passwd
echo "Correct status code:$?"
ls /etc/pas
echo "Incorrect status code:$?"

