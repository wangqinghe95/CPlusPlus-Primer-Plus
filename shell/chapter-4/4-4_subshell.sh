#!/bin/bash

hi="hello"
echo "+++++++++++++++++++++"
echo "+ I'am father shell +"
echo "+++++++++++++++++++++"

echo "PWD=$PWD"

echo "bash_subshell=$BASH_SUBSHELL"

# open subshell by ()
(
sub_hi="I am a subshell"
echo -e "\t+++++++++++++++++++++"
echo -e "\t+ enter sub shell   +"
echo -e "\t+++++++++++++++++++++"
echo -e "\tPWD=$PWD"
echo -e "\tbash_subshell=$BASH_SUBSHELL"
echo -e "\thi=$hi"
echo -e "\tsub_hi=$sub_hi"

cd /etc;echo -e "\tPWD=$PWD"
)


echo "++++++++++++++++++++++++"
echo "+ return father shell  +"
echo "++++++++++++++++++++++++"
echo "PWD=$PWD"
echo "hi=$hi"
echo "sub_hi=$sub_hi"
echo "bash_subshell=$BASH_SUBSHELL"
