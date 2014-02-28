#!/bin/bash

length=$(tput cols);
printf -v line "%*s" "$((length/2))"

menu=$(cat <<MENU
`echo ${line// /-}`
\n
\nBash and vim configuration file installer
\n
\n`echo ${line// /-}`
MENU
)
echo -e $menu 1>&2
unset length menu

# install vim if it isn't already installed
if [[ ! -e /usr/bin/vim ]]; then
  echo -n "Installing vim... ";
  sudo apt-get install vim -y &> /dev/null;
  if [[ -e /usr/bin/vim ]]; then echo "Success!"; else echo "Fail"; fi
fi

# Get the directory that contains the conf files to install
prefix=$(./.menu.sh)
if [[ "$prefix" == "Abort" ]]; then
  return 130;
fi

btime=`date +%Y%m%d.%H%M.bak`;
for filename in `ls -1a ./${prefix}.bash* ./${prefix}.vimrc | cut -d'/' -f3`; do
  
  docopy=yes;

  # Print a line separating the output of each itereation
  separator_length=$(tput cols);
  printf -v line "%*s" "$separator_length"
  echo ${line// /-}; 

  dstfile=~/${filename};
  srcfile=./${prefix}${filename};
  # If the destination file exists, do a backup of the original file first;
  # else just copy the file in place
  if [[ -f $dstfile ]]; then

    # If the dest and src files are different, copy src to dest; 
    # else do nothing.
    diff $dstfile $srcfile &> /dev/null ; diffstat=$? ;
    if [[ $diffstat -ne 0 ]]; then
      echo "$dstfile and $srcfile are different" ;

      # Make the initial backup to destfile.orig;
      # But, if .orig already exists, backup to destfile.time.bak
      backup=${dstfile}.orig ; 
      if ls ${backup} &> /dev/null ; then
      	echo -e "\t${backup} already exits" ;
        backup=${dstfile}.${btime};
      fi

      echo -en "\tBacking up ${dstfile} to ${backup}... " ;
      mv $dstfile ${backup};
      if [[ $? -eq 0 ]]; then echo "Success!"; else echo "Fail :("; fi
    else
      docopy=no;
      echo $dstfile and $srcfile are the same... skip
    fi
  else
    echo "$dstfile doestn't exist";
  fi

  if [ "$docopy" = "yes" ]; then
    echo -en "\tCopying ${srcfile} to ${dstfile}... ";
    cp ${srcfile} ${dstfile};
    if [[ $? -eq 0 ]]; then echo "Success!"; else echo "Fail :("; fi
  fi
done

if [[ -f ~/.bash_profile ]] ; then
  . ~/.bash_profile;
fi

