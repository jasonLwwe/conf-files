#! /bin/bash

oldpwd=$(pwd)

cd ~

if [ -f wwe.sql.bz2 ]; then
  echo A db file already exists at $(pwd)/wwe.sql.bz2 ;
  read -e -p "Would you like to proceed using the existing dump file (y|n)? " choice

  if [[ $choice == 'n' || $choice == 'N' ]]; then
    newname=wwe.sql.bz2.$(date +%Y%m%d@%H%M%S);
    echo -n "Renaming existing db file to $newname so that a new one can be downloaded... "
    mv $(pwd)/wwe.sql.bz2 $(pwd)/$(newname) ;
    echo done ;

    echo -n "Downloading new stage file backup... ";
    wget http://stage-dbback.cloud.wwe.com/wwe.sql.bz2 &> /dev/null
    echo done ;
  elif [[ $choice == 'y' || $choice == 'Y' ]]; then
    # If Y is chosen, do nothing, just proceed using the existing file  
   : 
  else
    echo "Unknown choice, goodbye!";
    exit;
  fi

else 
  echo -n "Downloading new stage file backup... ";
  wget http://stage-dbback.cloud.wwe.com/wwe.sql.bz2 &> /dev/null;
  echo done;
fi

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

