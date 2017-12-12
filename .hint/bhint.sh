#!/bin/bash

info[0]='Ctrl + u'
value[0]='Clears the entire line'

info[1]='Crtl + k'
value[1]='Deletes from cursor to end of line'

info[2]='Crtl + w'
value[2]='Deletes the word before the cursor'

info[3]='Ctrl + r'
value[3]='History Search'

info[4]='Ctrl + l'
value[4]='Clear Screen'

info[5]='Esc + b'
value[5]='Jumps left between arguments'

info[6]='Esc + e'
value[6]='Jumps right between arguments'

info[7]='cd ..'
value[7]='Changes working directory to parent directory'

info[8]='cd -'
value[8]='Changes working directory to last working directory'

info[9]='!<command>'
value[9]='Executes the last command that used <command>'

info[10]='!<command>:p'
value[10]='Displays the last command that used <command>'

info[11]='!$'
value[11]='Represents the arguments from the last command'

info[12]='^<typo>^<correction>'
value[12]='Replaces <typo> with <correction> in last command used'

info[13]='!<cmd history number>'
value[13]='Runs the command with the number from the command history'

info[14]='{<opt 1>,<opt 2>[,<opt n>..]}'
value[14]='Expands the command entered to two arguments with <opt 1> and <opt 2>'

info[15]='{,<opt 1>[,<opt n>..]}'
value[15]='Expands the command entered to two arguments'

info[16]='{<opt 1>,[,<opt n>..]}'
value[16]='Expands the command entered to two arguments'

info[17]='ls -l <dir> | wc -l'
value[17]='Displays the number of files in <dir>'

info[18]='<command> !$'
value[18]='Execute command with previous parameter'


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

