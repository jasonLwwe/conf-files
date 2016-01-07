#! /bin/bash

db=$1

trap "exit 1" TERM
export TOP_PID=$$

logdir=~/dbupdates
if [[ ! -d $logdir ]] ; then 
	mkdir -p $logdir;
fi

log=$logdir/$(date +%Y%m%d_%H%M)_update.log
touch $log

drupalRoot=/u01/www/wwe3redesign/html

function log_time() {
  echo [$(date +"%a %b %d %H:%M:%S %Y")];
}
export -f log_time

function result_msg() {
  if [[ $1 -eq 0 ]]; then 
    echo "Success!" >> $log; 
  else 
    echo "Fail... terminating" >> $log;
    kill -s TERM $TOP_PID;
  fi
}
export -f result_msg

function script_dir() {
  local __result=$1
	local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	if [[ ! -z "$__result" ]]; then
		eval $__result="'$dir'";
	else
		echo "$dir";
	fi
}
export -f script_dir

cd ~
touch -t $( date +'%m%d0000' ) /tmp/$$
if [[ -f wwe_migrated_db.sql.gz && -f wweglobal.sql.gz ]]; then
  
  dumpDir=~/node_dumps/$( date +'%Y%m%d_%H%M%S' );
  echo -n "$(log_time) Exporting nodes to $dumpDir... " >> $log;
  #/home/dynamic/bin/redesign_update/node_export.sh \
	"$( script_dir )"/node_export.sh \
    "export" \
    $dumpDir \
    $drupalRoot \
    $db ;
  result_msg "$?";

  #if [[ -e wweglobal.sql ]]; then
  #  rm -f wweglobal.sql;
  #  echo "$(log_time) Removed old wweglobal.sql" >> $log;
  #fi
  #
  #if [[ -e wwe_migrated_db.sql ]]; then
  #  rm -f wwe_migrated_db.sql;
  #  echo "$(log_time) Removed old wwe_migrated_db.sql" >> $log;
  #fi
  #
  #echo -n "$(log_time) Unzipping wwe_migrated_db.sql.gz... " >> $log;
  #gunzip wwe_migrated_db.sql.gz;
  #result_msg "$?";
  #
  #echo -n "$(log_time) Unzipping wweglobal.sql.gz... " >> $log;
  #gunzip wweglobal.sql.gz;
  #result_msg "$?";   
  
  echo -n "$(log_time) Testing if wweglobal DB has updates... " >> $log ;
  if [[ $( find . -name wweglobal.sql.gz -a -newer /tmp/$$ ) ]]; then 
    echo yes >> $log ;

    echo -n "$(log_time) Dropping wweglobal DB... " >> $log;
    mysql -e "DROP DATABASE IF EXISTS wweglobal;";
    result_msg "$?";

    echo -n "$(log_time) Creating wweglobal DB... " >> $log;
    mysql -e "CREATE DATABASE wweglobal;";
    result_msg "$?";
 
    echo -n "$(log_time) Importing new wweglobal DB... " >> $log;
    zcat wweglobal.sql.gz | mysql -h localhost wweglobal;
    result_msg "$?";
  else
    echo no >> $log ;
  fi 
  echo -n "$(log_time) Dropping \"$db\" DB... " >> $log;
  mysql -e "DROP DATABASE IF EXISTS ${db} ;";
  result_msg "$?";

  echo -n "$(log_time) Creating \"$db\" DB... " >> $log;
  mysql -e "CREATE DATABASE ${db};";
  result_msg "$?";

  echo -n "$(log_time) Importing new \"$db\" DB... " >> $log;
  zcat wwe_migrated_db.sql.gz | mysql -h localhost ${db}
  result_msg "$?";

  echo -n "$(log_time) Clearing memcache... " >> $log;
  echo "flush_all" | nc localhost 11211
  result_msg "$?"

  echo -n "$(log_time) Updating ${db}.language domain for English... " >> $log;
  mysql -e "UPDATE ${db}.languages SET domain='wwe-jason.jenkins.wwe.com' WHERE language='en';" ;
  result_msg "$?";

  echo -n "$(log_time) Updating ${db}.language domain for German... " >> $log;
  mysql -e "UPDATE ${db}.languages SET domain='de.wwe-jason.jenkins.wwe.com' WHERE language='de';" ;
  result_msg "$?";

  echo -n "$(log_time) Updating ${db}.language domain for Spanish... " >> $log;
  mysql -e "UPDATE ${db}.languages SET domain='es.wwe-jason.jenkins.wwe.com' WHERE language='es';" ;
  result_msg "$?";

  echo "$(log_time) Updating code... " >> $log;
  "$( script_dir )"/wwe-git-pull-redesign.sh $log $db ;
  echo "$(log_time) ...code update complete!" >> $log;
  
  echo -n "$(log_time) Importing nodes from $dumpDir... " >> $log;
  "$( script_dir )"/node_export.sh \
    "import" \
    $dumpDir \
    $drupalRoot \
    $db ;
  result_msg "$?";

  echo -n "$(log_time) Clearing memcache... " >> $log;
  echo "flush_all" | nc localhost 11211 ;
  result_msg "$?"
  echo "$(log_time) Updates complete!" >> $log;

else
  echo "$(log_time) There are no new DB updates available." >> $log;
fi

unset result_msg
unset log_time
unset script_dir

