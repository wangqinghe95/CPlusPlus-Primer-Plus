#!/bin/bash
a=abcd
test a == a
echo $?

[ $USER == root ];echo $?

[ $USER == root ] && echo Y || echo N

# -z to test if a string is null
[ -z $TEST ] && echo Y || echo N
TEST=123456
[ -z $TEST ] && echo Y || echo N

# Cause the variables using double quotes
[ -n "$Jacob" ] && echo Y || echo N
Jacob=1234
[ -n "$Jacob" ] && echo Y || echo N
