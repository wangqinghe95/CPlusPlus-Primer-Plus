#!/bin/bash
test 3 -eq 3 && echo Y || echo N

test 3 -ne 3 && echo Y || echo N

[ 6 -gt 4 ] && echo Y || echo N


