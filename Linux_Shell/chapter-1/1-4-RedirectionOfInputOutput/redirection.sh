#!/bin/bash
# > && >> redirection data to file
echo "hello the world" > tmp.txt
# data is appended to the file
echo "I'am a boy" >> tmp.txt
# redirect normal message from someone command to OK.txt and error message to err.txt
ls -al /etc/hosts /nofile > ok.txt 2>err.txt
# redirec all messages for one command to a file
ls -al /etc/hosts /nofile &> test.txt
# redirect error output to standard output
ls -al /etc/hosts /nofile 2&>1
# redirect ouput to /dev/null to discard
ls -al /etc/hosts /nofile > /dev/null
# input message redirection < or <<
