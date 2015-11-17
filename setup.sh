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

# Get the directory that contains the conf files to install
prefix=$(./.menu.sh)
if [[ "$prefix" == "Abort" ]]; then
  return 130;
fi

# install vim if it isn't already installed
#if [[ ! -e /usr/bin/vim ]]; then
#  echo -n "Installing vim... ";
#  sudo apt-get install vim -y &> /dev/null;
#  if [[ -e /usr/bin/vim ]]; then echo "Success!"; else echo "Fail"; fi
#fi

function result_msg() {
   if [[ $? -eq 0 ]]; then echo "Success!"; else echo -e "Fail\n$1"; fi
}

# Make bin folder in ~ and put some scripts in it.
userbin=~/bin
srcbin=./.bin
if [[ ! -d $userbin ]]; then
  echo -n "Creating ${userbin}... ";
  ERROR=$(mkdir $userbin 2>&1 >/dev/null);
  result_msg "$ERROR";
  
  if [[ -d $srcbin && -d $userbin ]]; then

    for file in `ls -1 $srcbin`; do
      srcfile=${srcbin}/${file};
      dstfile=${userbin}/${file};
      echo -en "\tMoving $srcfile to ${dstfile}... ";
      ERROR=$(cp -p $srcfile $dstfile 2>&1 >/dev/null);
      result_msg "$ERROR";
      if [[ ! -x $dstfile ]]; then
        chmod +x ${dstfile};
      fi
    done
    unset srcfile dstfile;

      #if [[ -f .cmp.php ]]; then
      #  echo -en "\tMoving .cmp.php to ${userbin}/cmp.php... ";  
      #  ERROR=$(cp -p .cmp.php ${userbin}/cmp.php 2>&1 >/dev/null);
      #  result_msg "$ERROR";
      #  if [[ ! -x ${userbin}/cmp.php ]]; then
      #    chmod +x ${userbin}/cmp.php;
      #  fi
      #fi

      #if [[ -f .copy.sh ]]; then
      #  echo -en "\tMoving .copy.sh to ${userbin}/.copy.sh... ";
      #  ERROR=$(cp -p .copy.sh ${userbin}/copy.sh 2>&1 >/dev/null);
      #  result_msg "$ERROR";
      #  if [[ ! -x ${userbin}/copy.sh ]]; then
      #    chmod +x ${userbin}/copy.sh;
      #  fi
      #fi

      #if [[ -f .install-db.sh ]]; then
      #  echo -en "\tMoving .install-db.sh to ${userbin}/.install-db.sh... ";
      #  ERROR=$(cp -p .install-db.sh to ${userbin}/install-db.sh 2>&1 >/dev/null);
      #  result_msg "$ERROR";
      #  if [[ ! -x ${userbin}/install-db.sh]]; then
      #    chmod +x ${userbin}/install-db.sh;
      #  fi
      #fi
  fi
fi
unset userbin srcbin;

if [[ -f /usr/bin/git ]]; then
  username=jasonLwwe;
  usermail=jason.lyerly@wwecorp.com;

  echo -n "Setting git config user.name to ${username}... ";
  ERROR=$(git config --global user.name ${username} 2>&1 >/dev/null);
  result_msg "$ERROR";

  echo -n "Setting git config user.email to ${usermail}... ";
  ERROR=$(git config --global user.email ${usermail} 2>&1 >/dev/null);
  result_msg "$ERROR";

  pushDefault=current;
  if [[ "$prefix" == "Jenkins/" ]] || [[  "$prefix" == "Intl/" ]]; then
    pushDefault=simple;
  fi
  echo -n "Setting git config push.default to ${pushDefault}... ";
  ERROR=$(git config --global push.default ${pushDefault} 2>&1 >/dev/null);
  result_msg "$ERROR";
fi
unset username usermail pushDefault

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
      ERR0R=$(mv $dstfile ${backup} 2>&1 >/dev/null);
      result_msg "$ERROR";
    else
      docopy=no;
      echo $dstfile and $srcfile are the same... skip
    fi
  else
    echo "$dstfile doestn't exist";
  fi

  if [ "$docopy" = "yes" ]; then
    echo -en "\tCopying ${srcfile} to ${dstfile}... ";
    ERROR=$(cp ${srcfile} ${dstfile} 2>&1 >/dev/null);
    result_msg "$ERROR";
  fi

  unset dstfile srcfile docopy separator_length diffstat;
done

if [[ -f ~/.bash_profile ]] ; then
  . ~/.bash_profile;
fi

unset -f result_msg
unset ERROR
unset prefix
unset btime
