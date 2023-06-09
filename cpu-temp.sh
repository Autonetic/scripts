#!/bin/sh
YELLOW='\033[0;33m'
BYELLOW='\033[1;33m'
GREEN='\033[0;32m'
BGREEN='\033[1;32m'
BRED='\033[1;31m'
URED='\033[4;31m'
ON_RED='\033[41m'
BPURPLE='\033[1;35m'
ON_GREEN='\033[42m'
NC='\033[0m' # No Color
clear
echo "${ON_GREEN}+-----------------------------------------+${NC}"
echo "${ON_GREEN}|\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\|${NC}"
echo "${ON_GREEN}|-=[${NC} ${BPURPLE}Automated CPU Temperature Monitor${NC} ${ON_GREEN}]=-|${NC}"
echo "${ON_GREEN}|-------------=${NC}${BGREEN}(^C to quit)${NC}${ON_GREEN}=--------------|${NC}"
echo "${ON_GREEN}|/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|${NC}"
echo "${ON_GREEN}+-----------------------------------------+${NC}"

while :
do

TEMP_FILE=/sys/class/thermal/thermal_zone0/temp

ORIGINAL_TEMP=$(cat $TEMP_FILE)
TEMP_C=$((ORIGINAL_TEMP/1000))
TEMP_F=$(($TEMP_C * 9/5 + 32))
date=$(date '+(%d-%m-%Y %H:%M:%S)')
#Create a log function
log() {
	echo "+---------------------+" >> cpu-log.txt;
	echo "|$date|" >> cpu-log.txt;
	echo "|Temperature was:" "$TEMP_C C|" >> cpu-log.txt;
	echo "+---------------------+" >> cpu-log.txt;
}
#create critical temp function
crit() {
	echo "${ON_RED}CPU Temperature Is Critical:" "${URED}$TEMP_C C${NC}";
	echo "${ON_RED}RUNNING KILL SCRIPT...${NC}"; 
	echo "CPU Temp Was Critical" >> cpu-log.txt;
	zenity --warning --title="CPU Temp Critical" --text="CPU temperature is critical...";
	zenity --notification --title="CPU Temp Critical" --text="CPU temperature is critical...";
}
echo "${BGREEN}$date"
if [ $TEMP_C -le 35 ] 
        then 
        	echo "${YELLOW}Current Temperature:" "${BGREEN}$TEMP_C C" && log;
elif [ $TEMP_C -le 80 ] 
        then 
        	echo "${YELLOW}Current Temperature:" "${BYELLOW}$TEMP_C C" && log;
elif [ $TEMP_C -le 90 ]
        then 
        	echo "${YELLOW}Current Temperature:" "${BRED}${URED}$TEMP_C C${NC}" && log;
else [ $TEMP_C -ge 91 ]
		echo "${ON_RED}CPU Temperature is critical" "${URED}$TEMP_C C${NC}" && log;
		crit;
		break;
fi
  sleep 10
done
