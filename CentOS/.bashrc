# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

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

  if [ $# -gt 1 ]; then
    echo "Usage: d7 relative/path/to/dest-dir";
    return 2;
  fi

  cd /u01/www/wwecom7/html/$1;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo dir changed to `pwd`;
  fi

  return $retval;
}

function d7m () {

  if [ $# -gt 1 ]; then
    echo "Usage:  d7m relative/path/to/dest-dir";
    return 2;
  fi
	
  cd /u01/www/wwecom7/html/sites/all/modules/wwe/$1;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo dir changed to `pwd`;
  fi

  return $retval;
}

function aroot () {

  if [ $# -gt 1 ]; then
    echo "Usage: aroot relative/path/to/dest-dir";
    return 2;
  fi

  cd /u01/www/$1;
  retval=$?;
  if [[ $retval -eq 0 ]]; then
    echo dir changed to `pwd`;
  fi
  
  return $retval;
}
