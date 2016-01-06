#! /bin/bash

# :args:
#   -t,--test 
#       Use the test-recipient.sh file instead of the full recipient list.
#   -d,--dir  
#       Specify the location of the dump file [DEFAULT: /home/ec2-user] 


# get the recipient list script
dumpdir=/home/ec2-user
script=recipients.sh
while [[ $# > 0 ]]; do
  key="$1";
  case $key in
    -t|--test)
      script=test-${script};
      ;;
    -d|--dir)
      dumpdir=$2;
      shift ;
      ;;
    *)
      ;;
    esac

  shift
done


to="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"/${script}
msg="This morning's migration FAILED."
state=""
subject="CLOUDY"
retval=1

# create a temp file w/mod time of 12am today
# then see if dump file exists and is
# newer than the temp file
touch -t $( date +'%m%d0000' ) /tmp/$$
if [[ -f ${dumpdir}/wwe_migrated_db.sql.gz ]]; then
  state="The latest dump is from "$( ls -l ${dumpdir}/wwe_migrated_db.sql.gz | tr -s " " | cut -d" " -f 6-8 )".";
  
  if [[ $(find ${dumpdir} -name wwe_migrated_db.sql.gz -newer /tmp/$$) ]]; then
    subject="SUNNY"
    msg="This morning's migration was successful, the QA servers can be updated."; 
    retval=0
  fi

else
  state="The dump file could not be found."
fi

# send the email message
msg=$msg"  "$state
~/bin/mailer/do-mail.sh "$to" "$subject" "$msg"

rm -f /tmp/$$
unset msg
unset subject
unset state

exit $retval

