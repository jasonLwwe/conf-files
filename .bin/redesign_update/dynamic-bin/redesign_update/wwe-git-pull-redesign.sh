#! /bin/bash

#wwe-git-pull-redesign.sh
#

log=$1
if [ ! -f $log ]; then touch $log ; fi
db=$2

gitlog=$( dirname $log )/git.$(date +'%Y%m%d_%H%M').log


cd /u01/www/wwe3redesign

echo -en "$(log_time) Executing git pull... " >> $log
git pull >> $gitlog 2>&1
result_msg "$?"

cd /u01/www/wwe3redesign/html/sites
echo -en "$(log_time) Removing multisite... " >> $log
rm -rf \
all/drush \
dev \
local \
qa \
qa-test \
example.sites.php \
global.settings.php \
README.txt \
sites.php >> $gitlog 2>&1
result_msg "$?"

cd /u01/www/wwe3redesign/html

echo -en "$(log_time) Truncating semaphore, watchdog, and wwe_update_log... " >> $log
$( mysql --login-path=wwe3 -D $db -e "truncate table semaphore;" && \
mysql --login-path=wwe3 -D $db -e "truncate table watchdog"   && \
mysql --login-path=wwe3 -D $db -e "truncate table wwe_update_log" ) >> $gitlog 2>&1
result_msg "$?"

echo -en "$(log_time) Unpublishing Code & Theory test data... " >> $log
mysql --login-path=wwe3 -D $db -e "update node set status=0 where 35000000<=nid and nid<=36000000;" >> $gitlog 2>&1
mysql --login-path=wwe3 -D $db -e "update node_revision set status=0 where 35000000<=nid and nid<=36000000;" >> $gitlog 2>&1
result_msg "$?"

echo -en "$(log_time) Running drush cc drush... " >> $log
drush cc drush &> $gitlog
result_msg "$?"

echo -en "$(log_time) Running drush updatedb... " >> $log 
drush -y  updatedb >> $gitlog 2>&1
result_msg "$?"

echo -en "$(log_time) Running drush cc all... " >> $log
drush cc all >> $gitlog 2>&1
result_msg "$?"

echo -en "$(log_time) Enabling uuid module... " >> $log
if [[ $( drush pm-list --status=enabled --no-core --package="UUID" \
      --type=module --field-labels=0 | grep -E "\buuid\b" ) ]]; then
  echo -e "$(log_time) skipping, already enabled";
else
  drush en -y uuid >> $gitlog 2>&1
  result_msg "$?"
fi

echo -en "$(log_time) Enabling node_export module... " >> $log
if [[ $( drush pm-list --status=enabled --no-core --package="Node export" \
        --type=module --field-labels=0 | grep -E "\bnode_export\b" ) ]] ; then
  echo -e "$(log_time) skipping, already enabled";
else
  drush en -y node_export >> $gitlog 2>&1
  result_msg "$?"
fi

echo -en "$(log_time) Running drush cc all... " >> $log
drush cc all >> $gitlog 2>&1
result_msg "$?"

echo -en "$(log_time) Configuring site variables... " >> $log
/home/dynamic/bin/redesign_update/site_settings.php
result_msg "$?"

echo -en "$(log_time) Configuring node_export settings... " >> $log
/home/dynamic/bin/redesign_update/node_export_config.php
result_msg "$?"

echo -en "$(log_time) Running drush cc all... " >> $log
drush cc all >> $gitlog 2>&1
result_msg "$?"

