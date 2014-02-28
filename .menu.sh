#!/bin/bash

menu=""
index=0
declare -a choices
echo Choose a directory to install: 1>&2
for dir in `ls -d1 */; echo Abort` ; do
  choices[$index]=$dir;
  menu="${menu}\n${index}) ${dir}" ;   
  (( index++ )); 
done

exit=$((${index}-1))
stop=1
max=3
try=0
sep="**********"
msg="Please enter the NUMBER of the directory you want to install";
retval="Abort"
while [[ $stop != 0 && $try -lt $max ]]; do
  
  # Display the menu options.
  echo -e "${menu}\n" 1>&2;

  # Prompt for the user's selection.
  read -e -p "Enter the number> " number

  # Check the input, if it's either not a number or not a menu option and not the exit 
  # value, notify the user of the mistake and increment the try count...
  if [[  $number != [0-9]* || $number -lt 0 || $number -gt $((${#choices[@]}-1)) && $number -ne $exit ]]; then
    echo "Invalid choice, you entered ${number}" 1>&2;
    (( try++ ));
    notice="";
    # Build a notification message if the current try is not the max.
    if [[ $try == $((${max}-1)) ]]; then
      notice="${sep}\nLAST CHANCE: ${msg}\n"; 
    elif [[ $try -lt $((${max}-1)) ]]; then
      notice="${sep}\n${msg}\n";  
    fi
    echo -en "$notice" 1>&2;
  # ... otherwise, Stop prompting immediately if the user chose to abort
  elif [[ $number -eq $exit ]]; then
    stop=0;
  # ... the menu option was valid and not abort, confirm the selection
  # and set the return value according to the menu selection.
  else
    echo "You chose ${choices[$number]}" 1>&2;
    confirm=Y;
    read -e -p "Is this correct [Y/n]> " confirm;
    case $confirm in
      "Y"|"y"|"")
        stop=0;
        retval=${choices[$number]};
        ;;
      "N"|"n")
        (( try-- ));
        ;;
      *)
        echo "Illegal choice:  $confirm" 1>&2;
        (( try-- ));
        ;;
    esac
  fi
done

echo $retval
