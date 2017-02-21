#! /bin/bash

oldpwd=$(pwd)

cd ~

if [ -f wwe.sql.bz2 ]; then
  echo A db file already exists at $(pwd)/wwe.sql.bz2 ;
  echo Please delete it, or rename it if you wish to keep it, and try again. ;
  exit;
fi

echo -n "Downloading new stage file backup... "
wget http://stage-dbback.cloud.wwe.com/wwe.sql.bz2 &> /dev/null
echo done

echo -n "Dropping database wwe... "
mysql -e 'drop database wwe;'
echo done

echo -n "Creating new database wwe... "
mysql -e 'create database wwe;'
echo done

echo -n "Importing new database... "
lbzcat wwe.sql.bz2 | mysql -D wwe
echo done

if [ -d /u01/www/wwe/html ]
then
  echo "Moving to /u01/www/wwe/html";
  cd /u01/www/wwe/html ;
else
  echo "Moving to /u01/www/wwe3redesign";
  cd /u01/www/wwe3redesign/html ;
fi

echo "Enabling stage file proxy... "
drush en -y stage_file_proxy
echo ...done

echo  "Setting stage_file_proxy_origin"
drush vset stage_file_proxy_origin http://www.wwe.com
echo ...done

echo  "Doing drush updatedb... "
drush updatedb -y
echo ...done

echo -n "Enabling devel module... "
drush en -y devel &> /dev/null
echo done

echo -n "Clearing drupal cache... "
drush cc all &> /dev/null 
echo done

cd $oldpwd

