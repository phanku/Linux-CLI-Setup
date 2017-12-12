#!/bin/bash

source /home/phanku/.hint/shint.conf

function edl {
   printf '\e[32m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
}

function esl {
   printf '\e[32m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

function floor() {
   float_in=$1
   floor_val=${float_in/.*}
}

function real_length {
   real_string=$(echo ${1} | sed -r "s/\\e\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
   RESULT=${#real_string}
}

STRTOLONG=100
SCREENWIDTH=$(tput cols)
COLWIDTH=$(expr $SCREENWIDTH / 2)

edl
echo 'Server Commands'
esl
OUTPUTCOUNT=0
OUTPUTSTRLENGTH=0
OUTPUTSTR=""
TOOLONGSTR=""
SPACELEFT=$SCREENWIDTH
COMPLETEDOUTSTR=""
for i in "${!info[@]}"
do
   OUTPUT=0
   TEMPSTR="\e[33m${info[$i]}\e[0m ${value[$i]}"
   real_length "${TEMPSTR}"
   STRLENGTH=$RESULT
   if (($STRLENGTH > $COLWIDTH))
   then
      TOOLONGSTR=$TOOLONGSTR$TEMPSTR'\n'
   else   
      if (("$OUTPUTCOUNT" == "2"))
      then
         OUTPUTCOUNT=0
         OUTPUT=1
         COMPLETEDOUTSTR=$OUTPUTSTR
         SPACELEFT=$SCREENWIDTH
         OUTPUTSTR=""
         real_length "${TEMPSTR}"
         SPACENEEDED=$(expr $COLWIDTH - ${RESULT})
         SPACE=$(printf '%*s\n' "$SPACENEEDED" '') 
         OUTPUTSTR=$OUTPUTSTR$TEMPSTR$SPACE"\e[32m||\e[0m"
         real_length "${OUTPUTSTR}"
         SPACELEFT=$(expr $SCREENWIDTH - ${RESULT})
         OUTPUTCOUNT=$(expr $OUTPUTCOUNT + 1)
      else 
         real_length "${TEMPSTR}"
         SPACENEEDED=$(expr $COLWIDTH - ${RESULT})
         SPACE=$(printf '%*s' "$SPACENEEDED" '') 
         OUTPUTSTR=$OUTPUTSTR$TEMPSTR$SPACE"\e[32m||\e[0m"
         real_length "${OUTPUTSTR}"
         SPACELEFT=$(expr $SCREENWIDTH - ${RESULT})
         OUTPUTCOUNT=$(expr $OUTPUTCOUNT + 1)
      fi;
   fi;

   if (("${OUTPUT}" > "0"))
   then
      printf "$COMPLETEDOUTSTR\n"
      COMPLETEDOUTSTR=""
      OUTPUT=false
   fi;
done;
if (("${#OUTPUTSTR}" > "0"))
then
   if (("$OUTPUTCOUNT" == "1"))
   then
      OUTPUTCOUNT=$(expr $OUTPUTCOUNT + 1)
      SPACENEEDED=$(expr $COLWIDTH - 2)
      SPACE=$(printf '%*s' "$SPACENEEDED" '') 
      OUTPUTSTR=$OUTPUTSTR$SPACE"\e[32m||\e[0m"
      real_length "${OUTPUTSTR}"
      SPACELEFT=$(expr $SCREENWIDTH - ${RESULT})
      printf "$OUTPUTSTR\n"
   else
      printf "$OUTPUTSTR\n"
   fi;
fi;
if (("${#TOOLONGSTR}" > "0"))
then
   echo -e "\n"$TOOLONGSTR
fi;
edl

