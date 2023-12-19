#!/bin/sh
#colours to work with
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

#functions
printTemp () {
#date for logging and output
date=$(date '+(%d-%m-%Y %H:%M:%S)')
TEMP_FILE=/sys/class/thermal/thermal_zone0/temp
ORIGINAL_TEMP=$(cat $TEMP_FILE)
TEMP_C=$((ORIGINAL_TEMP/1000))
TEMP_F=$(($TEMP_C * 9/5 + 32))
echo "${BGREEN}$date${NC}"
if [ $TEMP_C -le 70 ] 
        then 
        	echo "${YELLOW}Current Temperature:" "${BGREEN}$TEMP_C C${NC}" && $(log);
elif [ $TEMP_C -le 80 ] 
        then 
        	echo "${YELLOW}Current Temperature:" "${BYELLOW}$TEMP_C C${NC}" && $(log);
elif [ $TEMP_C -le 90 ]
        then 
        	echo "${YELLOW}Current Temperature:" "${BRED}${URED}$TEMP_C C${NC}" && $(log);
else [ $TEMP_C -ge 91 ]
		echo "${ON_RED}CPU Temperature is critical" "${URED}$TEMP_C C${NC}" && $(log);

fi
}

log () {
	echo "+---------------------+" >> cpu-log.txt;
	echo "|"$(date '+(%d-%m-%Y %H:%M:%S)')"|" >> cpu-log.txt;
	echo "|Temperature was:" "$TEMP_C C|" >> cpu-log.txt;
	echo "+---------------------+" >> cpu-log.txt;
}

#clear terminal
clear

#start program
echo "${BPURPLE}+-----------------------------------------+${NC}"
echo "${BPURPLE}|\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\|${NC}"
echo "${BPURPLE}|-=[${NC} ${BGREEN}Automated CPU Temperature Monitor${NC} ${BPURPLE}]=-|${NC}"
echo "${BPURPLE}|-------------=${NC}${BGREEN}(^C to quit)${NC}${BPURPLE}=--------------|${NC}"
echo "${BPURPLE}|/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|${NC}"
echo "${BPURPLE}+-----------------------------------------+${NC}"

while :
do
    if printTemp
        then 
            sleep 10
        else
            echo "${BRED}Something went wrong...${NC}"
            break
    fi
done
