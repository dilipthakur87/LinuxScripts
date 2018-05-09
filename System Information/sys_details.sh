#!/bin/sh

# Script to get system information

RED="\033[0;31m"
ENDCOLOR="\033[0m"

echo -e $RED"HOSTNAME INFORMATION"$ENDCOLOR
df -h
echo ""

echo -e $RED"UPTIME AND LOAD OF SYSTEM"$ENDCOLOR
uptime
echo ""

echo -e $RED"CURRENTLY LOGGED IN USERS"$ENDCOLOR
who
echo ""

echo -e $RED"MEMORY USAGE"$ENDCOLOR
free
echo ""

echo -e $RED"FILE SYSTEM DISK USAGE"$ENDCOLOR
df -h
echo ""

echo -e $RED"TOP 10 MEMORY-CONSUMING PROCESSES"$ENDCOLOR
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 11
echo ""
