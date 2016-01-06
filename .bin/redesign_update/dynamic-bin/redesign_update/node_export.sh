#! /bin/bash

mode=$1
exportDir=$2
drupalDir=$3
db=$4
oldpwd=$(pwd)

cd $drupalDir
if [ "$mode" == "export" ]; then 
  if [ ! -d $exportDir ]; then
    mkdir -p $exportDir ;
  fi

  mysql -e "select nid from $db.node where nid>=40000000 or (\
    changed >= unix_timestamp('2016-05-01 00:00:00') \
    and (nid<35000000 or 35005000<nid) );" | \
    grep -E "^[[:digit:]]" > $exportDir/nids.txt;

	#mysql -e "select nid from $db.node where type='video' order by nid desc limit 20" | \
	#	grep -E "^[[:digit:]]" > $exportDir/video-nids.txt;

  while read nid; do
    drush node-export-export $nid >> $exportDir/${nid}.node.out ;
  done < $exportDir/nids.txt

	#while read nid; do
	#	drush node-export-export $nid >> $exportDir/video-${nid}.node.out ;
	#done < $exportDir/video-nids.txt

else
  
  for nodeFile in `ls $exportDir/*.node.out`; do
    drush node-export-import --file=$nodeFile >> $exportDir/import.log;
  done

fi

cd $oldpwd
