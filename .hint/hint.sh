#!/bin/bash


function head_end_line {
   printf '\e[32m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
}

function section_line {
   printf '\e[32m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

head_end_line
echo "Hint Reference"
section_line
PS3="Which hint?: "
select option in "Server Commands" "Bash Commands" "Bash Aliases" "Quit"
do
   case $option in 
      "Server Commands")
         head_end_line
         head_end_line
         /home/phanku/.hint/shint.sh
         break;;

      "Bash Commands")
         head_end_line
         head_end_line
         /home/phanku/.hint/bhint.sh
         break;;

      "Bash Aliases")
         head_end_line
         head_end_line
         /home/phanku/.hint/bahint.sh
         break;;

      "Quit")
         exit 1;
         break;;
   esac
done
