#!/bin/bash

tmpfile="/tmp/tmp_$$.txt"
pagefile="/tmp/page_"
moviefile="/tmp/movie_"
listfile="/tmp/list.txt"

# 网址链接不上
curl -s https://www.dytt8.net > $tmpfile

# 删除所有不包含 id="menu" 和 </div> 的行
sed -i '/id="menu"/,/\/div/!d' $tmpfile

URL=$(sed -n '/id="menu"/,/\/div/p' $tmpfile | awk -F\" '/href/&&/http/{print $2}')

echo -e "\033[32mCatching links to video data in the site"
echo "Maybe it needs more times, Please waiting..."

x=1
y=1
for i in $URL
do
    curl -s $i > $pagefile$x
    sed -i '/class="co_content8"/,/class="x"/!d' $pagefile$x

    SUB_URL=$(awk -F\" '/href/{print "http://www.ygdy8.net"$2}' $pagefile$x)

    for j in $SUB_URL
    do
        curl -s $j > $moviefile$y
        sed -i '/ftp/!d' $moviefile$y
        awk -F\" '{print $6}' $moviefile$y >> $listfile
        let y++
    done

    let x++
done

rm -rf $tmpfile
rm -rf $pagefile
rm -rf $moviefile