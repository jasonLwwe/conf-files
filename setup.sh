#!/bin/bash

if [[ ! -e /usr/bin/vim ]]; then
  echo -n "Installing vim... ";
  sudo apt-get install vim -y &> /dev/null;
  if [[ -e /usr/bin/vim ]]; then echo "Success!"; else echo "Fail"; fi
fi

btime=`date +%Y%m%d.%H%M.bak`;
for filename in `ls -1a .bash* .vimrc | xargs -I{} echo -n "{} "`; do
  # Print a line separating the output of each itereation
  separator_length=$(tput cols);
  printf -v line "%*s" "$separator_length"
  echo ${line// /-}; 

  dstfile=~/${filename};
  srcfile=./${filename};
  # If the destination file exists, do a backup of the original file first;
  # else just copy the file in place
  if [[ -f $dstfile ]]; then
    # If the dest and src files are different, copy src to dest; 
    # else do nothing.
    diff $dstfile $srcfile &> /dev/null ; diffstat=$? ;
    if [[ $diffstat -ne 0 ]]; then
      echo $dstfile and $srcfile are different ;

      # Make the initial backup to destfile.orig;
      # But, if .orig already exists, backup to destfile.time.bak
      backup=${dstfile}.orig ; 
      if ls ${backup} &> /dev/null ; then
      	echo -e "\t${backup} already exits" ;
        backup=${dstfile}.${btime};
      fi

      echo -en "\tBacking up ${dstfile} to ${backup}... " ;
      mv $dstfile ${backup};
      if [[ $? -eq 0 ]]; then echo "Sucess!"; else echo "Fail :("; fi
    fi
  else
    echo "$dstfile doestn't exist";
  fi
  echo -en "\tCopying ${srcfile} to ${dstfile}... ";
  cp ${srcfile} ${dstfile};
  if [[ $? -eq 0 ]]; then echo "Sucess!"; else echo "Fail :("; fi
done

if [[ -f /usr/bin/git ]]; then
  username=jasonLwwe;
  usermail=jason.lyerly@wwecorp.com;

  echo -n "Setting git config user.name to ${username}... ";
  git config --global user.name $username;
  if [[ $? -eq 0 ]]; then echo "Success!"; else echo "Fail :("; fi

  echo -n "Setting git config user.email to ${useremail}... ";
  git config --global user.email $usermail;
  if [[ $? -eq 0 ]]; then echo "Success!"; else echo "Fail :("; fi

  echo -n "Setting git config push.default to... ";
  git config --global push.default simple &> /dev/null;
  if [[ $? -eq 0 ]];
    echo "simple";
  else
    git config --global push.default current &> /dev/null;
    if [[ $? -eq 0 ]];
      echo "current";
    else
      echo "failed to set either current or simple";
    fi
  fi
fi

