#!/bin/bash

// in the  standard ASCII, lowercase bigger than capital, which bigger than number
LANG=C
[[ b > A ]] && echo Y || echo N
[[ A > 6 ]] && echo Y || echo N

[ yes == yes -a no == no ] && echo Y || echo N
[[ A == A && 6 -eq 6 && C == C ]] && echo Y || echo N

name=Jacob
[[ $name == J* ]] && echo Y || echo N
