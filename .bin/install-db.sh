#! /bin/bash

trap "exit 1" TERM
export TOP_PID=$$

log=/home/jlyerly/dbupdates/$(date +%Y%m%d_%H%M)_update.log
sudo -u jlyerly -g dynamic touch $log

function log_time() {
  echo [$(date +"%a %b %d %H:%M:%S %Y")];
}

function result_msg() {
  if [[ $? -eq 0 ]]; then 
    echo "Success!" >> $log; 
  else 
    echo "Fail... terminating" >> $log;
    kill -s TERM $TOP_PID;
  fi
}

cd /home/ec2-user
if [[ -e wwe_migrated_db.sql.gz && -e wweglobal.sql.gz ]]; then
  
   if [[ -e wweglobal.sql ]]; then
    rm -r wweglobal.sql;
    echo "$(log_time) Removed old wweglobal.sql" >> $log;
  fi
  
  if [[ -e wwe_migrated_db.sql ]]; then
    rm -r wwe_migrated_db.sql;
    echo "$(log_time) Removed old wwe_migrated_db.sql" >> $log;
  fi
  
  echo -n "$(log_time) Unzipping wwe_migrated_db.sql.gz... " >> $log;
  ret=$(gunzip wwe_migrated_db.sql.gz);
  result_msg "$ret";
  
  echo -n "$(log_time) Unzipping wweglobal.sql.gz... " >> $log;
  ret=$(gunzip wweglobal.sql.gz);
  result_msg "$ret";   

  echo -n "$(log_time) Dropping wweglobal DB... " >> $log;
  ret=$(mysql -e "DROP DATABASE IF EXISTS wweglobal;");
  result_msg "$ret";

  echo -n "$(log_time) Creating wweglobal DB... " >> $log;
  ret=$(mysql -e "CREATE DATABASE wweglobal;");
  result_msg "$ret";
 
  echo -n "$(log_time) Importing new wweglobal DB... " >> $log;
  ret=$(mysql -h localhost wweglobal < wweglobal.sql);
  result_msg "$ret";
 
  echo -n "$(log_time) Dropping wwe3 DB... " >> $log;
  ret=$(mysql -e "DROP DATABASE IF EXISTS wwe3 ;");
  result_msg "$ret";

  echo -n "$(log_time) Creating wwe3 DB... " >> $log;
  ret=$(mysql -e "CREATE DATABASE wwe3;");
  result_msg "$ret";

  echo -n "$(log_time) Importing new wwe3 DB... " >> $log;
  ret=$(mysql -h localhost wwe3 < wwe_migrated_db.sql);
  result_msg "$ret";

  echo "$(log_time) DB imports complete!" >> $log

else
  echo "$(log_time) There are no new DB updates available." >> $log;
fi
