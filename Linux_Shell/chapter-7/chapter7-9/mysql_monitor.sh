#!/bin/bash
MYSQL_USER=root
MYSQL_PASS=user000
MYSQL_PORT=3306
MYSQL_HOST=localhost
MYSQL_ADMIN="mysqladmin -u$MYSQL_USER -p$MYSQL_PASS \
    -P$MYSQL_PORT -h$MYSQL_HOST"
MYSQL_COMM="mysql -u$MYSQL_USER -p$MYSQL_PASS \
            -P$MYSQL_PORT -h$MYSQL_HOST -e"

SUCCESS="echo -en \\033[1;32m"
FAILURE="echo -en \\033[1;31m"
WARNING="echo -en \\033[1;33m"
NORMAL="echo -en \\033[0;39m"

$MYSQL_ADMIN ping &> /dev/null
if [ $? -ne 0 ];then
    $FAILURE
    echo "Can not connect Mysql Server"
    $NORMAL
    # exit
else
    echo -n "The Status of Mysql: "
    $SUCCESS
    echo "[OK]"
    $NORMAL
fi

RUN_TIME=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'uptime'" |  awk '/Uptime/{print $2}')
echo -n "The Mysql runing time: "
$SUCCESS
echo $RUN_TIME
$NORMAL

DB_LIST=$($MYSQL_COMM "SHOW DATABASES")
DB_COUNT=$($MYSQL_COMM "SHOW DATABASES" | awk 'NR>=2&&/^[^+]/{db_count++} END{print db_count}')
echo -n "The Database have $DB_COUNT data tables, and they are respectively: "
$SUCCESS
echo $DB_LIST
$NORMAL

MAX_CON=$($MYSQL_COMM "SHOW VARIABLES LIKE 'max_connections'" | awk '/max/{print $2}')
echo -n "MySQL Maximum number of concurrent connections: "
$SUCCESS
echo $MAX_CON
$NORMAL

NUM_SELECT=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'com_select'" | awk '/Com_select/{print $2}')
echo -n "The Number of times being performed for Command of SELECT: "
$SUCCESS
echo $NUM_SELECT
$NORMAL

NUM_UPDATE=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'com_update'" | awk '/Com_update/{print $2}')
echo -n "The Number of times being performed for Command of UPDATE: "
$SUCCESS
echo $NUM_UPDATE
$NORMAL

NUM_DELETE=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'com_delete'" | awk '/Com_delete/{print $2}')
echo -n "The Number of times being performed for Command of DELETE: "
$SUCCESS
echo $NUM_DELETE
$NORMAL

NUM_INSERT=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'com_insert'" | awk '/Com_insert/{print $2}')
echo -n "The Number of times being performed for Command of INSERT: "
$SUCCESS
echo $NUM_INSERT
$NORMAL

NUM_COMMIT=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'com_commit'" | awk '/Com_commit/{print $2}')
echo -n "The Number of times being performed for Command of COMMIT: "
$SUCCESS
echo $NUM_COMMIT
$NORMAL

NUM_ROLLBACK=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'com_rollback'" | awk '/Com_rollback/{print $2}')
echo -n "The Number of times being performed for Command of ROLLBACK: "
$SUCCESS
echo $NUM_ROLLBACK
$NORMAL

NUM_QUESTION=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'Questions'" | awk '/Questions/{print $2}')
echo -n "The Number of times being performed for Command of Questions: "
$SUCCESS
echo $NUM_QUESTION
$NORMAL

NUM_SLOW_QUERY=$($MYSQL_COMM "SHOW GLOBAL STATUS LIKE 'slow_queries'" | awk '/Slow_queries/{print $2}')
echo -n "The Number of times being performed for Command of Slow Query: "
$SUCCESS
echo $NUM_SLOW_QUERY
$NORMAL

echo -n "Database QPS: "
$SUCCESS
awk 'BEGIN{print '"$NUM_QUESTION/$RUN_TIME"'}'
$NORMAL

echo -n "Database TPS: "
$SUCCESS
awk 'BEGIN{print '"($NUM_COMMIT+$NUM_ROLLBACK)/$RUN_TIME"'}'
$NORMAL