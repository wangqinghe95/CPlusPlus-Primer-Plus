#!/bin/bash
<<COMMONESCAPECHARACTERS
\b backspace
\f change the lines but still stay in the original position
\n change the lines and move the cursor to the of the line
\r the cursor moves to the top of the line but no line
\t insert the tab
\\ print char '\'
\033 or \e set terminal property such as color of font, background color , cursor position 
COMMONESCAPECHARACTERS
echo "test \t"
echo "hello\tworld"
# -e \t 空格转移字符
echo "test -e \t"
echo -e "hello\tworld"
# \f
echo "test -f \t"
echo -e "hello\fworld"
# \b
echo "test -b \t"

echo -e "hello\bworld"
# \n
echo "test -n \t"
echo -e "hello\nworld"

# \r
echo -e "hello\rworld"

# overstriking
<<ECHO
\033 or \3 set different terminal property
1m means that show overstriking string 
0m means to stop the display
OK is the string intend to show
ECHO
echo -e "\033[1mOK\033[0m"

# dispaly string with underline
echo -e "\e[4mOK\e[0m"

# display a string with flash
echo -e "\e[5mOK\e[0m"

# display a string with black
echo -e "\e[30mOK\e[0m"

# display a string with red
echo -e "\e[31mOK\e[0m"

<<ECHOCOLOR
# 32 green 33 brown 34 blue 35 purple 
ECHOCOLOR
# 36 bluish green
echo -e "\e[36mOK\e[0m"
# bright gray
echo -e "\e[37mOK\e[0m"
# bright yellow
echo -e "\e[1;33mOK\e[0m"
# 42-green background
echo -e "\e[42mOK\e[0m"
# 44 blue background
echo -e "\e[44mOK\e[0m"
# 32;44 green and blue background

echo -e "\e[32;44mOK\e[0m"

# set color,size,background of font

# show "OK" in the three rows and ten columns
echo -e "\e[3;10HOK

# printf 等同 echo，用法同 C 的用法类似

