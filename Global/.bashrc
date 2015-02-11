# ~/.bashrc: executed by bash(1) for non-login shells.

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for setting history, see HISTSIZE, HISTFILESIZE, and HISTCONTROL in bash(1)
HISTSIZE=1000
HISTFILE=~/.bash_history
HISTFILESIZE=2000
HISTCONTROL=ignoredups
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|putty-256color) color_prompt=yes;;
esac
if [ "$color_prompt" = yes ]; then
    PROMPT="\[\e[0m\]\u\[\e[0m\]@\h \w\n\[\e[1;37m\]\$ \[\e[0m\]";
    function exitstatus {
        if [ $? -eq 0 ]; then
          PS1="\n\[\e[1;32m\]\! ${PROMPT}";
        else
          PS1="\n\[\e[1;31m\]\! ${PROMPT}";
        fi
    }
    PROMPT_COMMAND=exitstatus;
else
    PS1="\n\! \u@\h \w\n\$ ";
fi
unset color_prompt force_color_prompt

function backup () {
  newname=$1.`date +%Y%m%d.%H%M.bak`;

  mv $1 $newname && cp -p $newname $1;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo "Backed up $1 to $newname.";
  else
    echo "[ERROR]:  backup failed.";
  fi
  
  return $retval; 
}

function d7 () {
  
  if [[ $# -gt 1 ]]; then 
    echo "[ERROR] Usage:  d7 [relative/path/to/dest-dir]";
    return 3;
  fi

  cd /u01/www/wwecom7/html/$1;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo dir changed to `pwd`;
  fi

  return $retval;
}

function d7m () {
  
  if [[ $# -gt 1 ]]; then
    [echo "[ERROR] Usage:  d7m [relative/path/to/dest-dir]";
    return 3;
  fi

  cd /u01/www/wwecom7/html/sites/all/modules/wwe/$1 ;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo dir changed to `pwd`;
  fi

  return $retval;
}

function dglb () {

  if [[ $# -gt 1 ]]; then
    echo "[ERROR] Usage:  dglb [relative/path/to/dest-dir]";
    return 3;
  fi

  cd /u01/www/wweglobal/html/$1;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo dir changed to `pwd`;
  fi

  return $retval;
}

function drc () {

  if [[ $# -gt 1 ]]; then
    echo "[ERROR] Usage:  drc [relative/path/to/dest-dir]";
    return 3;
  fi

  cd /u01/www/wweglobal/console/$1;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo dir changed to `pwd`;
  fi

  return $retval;
}
