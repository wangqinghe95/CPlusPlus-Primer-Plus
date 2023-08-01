#!/bin/bash
<<ANNOTATION
Author:luis
Date:2023-4-3
Description:the rule for more  annotations of bash is as follows:
            1. starts with << and any one-string of characters
            2. the content of annotation
            3. end with the specific characters with the start

            for one annotation:
            1. start with a #
ANNOTATION

# this is a line annotation
echo "hello world"