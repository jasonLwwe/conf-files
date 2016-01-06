#! /bin/bash

if [[ $# -ne 3 ]] ; then
  echo Usage: requires 3 args: sourcedir targetdir username
  exit 1;
fi

sourcedir=$1
targetdir=$2
newuser=$3

reddump=wwe_migrated_db.sql.gz
glbdump=wweglobal.sql.gz

sleeptime=10 # how long to sleep before looking for file again
timeLimit=30 # how many minutes to spend looking
reps=$(( 60 / $sleeptime * $timeLimit )) # the number of repititions required to look based on sleeptime and timeLimit
missing=1
while [[ $missing -gt 0  && $missing -le $reps ]] ; do

  if [[ -f $sourcedir/$reddump && -f $sourcedir/$glbdump ]]; then
    echo "$( date +'%H:%M:%S' ) Copying global dump to wwe-716.jenkins.wwe.com... "    
    sudo -u ec2-user scp $sourcedir/$glbdump ec2-user@wwe-716.jenkins.wwe.com:/home/ec2-user ;

    echo $( date +'%H:%M:%S' ) Found files, moving them.
    mv $sourcedir/$reddump $targetdir;
    sudo chown "$newuser": $targetdir/$reddump;

    mv $sourcedir/$glbdump $targetdir;
    sudo chown "$newuser": $targetdir/$glbdump;

    missing=0;
  else
    echo $( date +'%H:%M:%S' ) The files are missing, sleeping...;
    missing=$(( $missing + 1 ));
    sleep $sleeptime;
  fi

done

if [[ $missing -gt 0 ]]; then
  echo "$( date +'%H:%M:%S' ) File not found after $(( $reps * $sleeptime / 60 )) minutes, quitting.";
fi

