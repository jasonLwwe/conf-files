#! /bin/bash

msg="This morning's migration FAILED."
state=""
subject="CLOUDY"
retval=1

touch -t $( date +'%m%d0000' ) /tmp/$$
if [[ -f ~/wwe_migrated_db.sql.gz ]]; then
  state="The latest dump is from "$( ls -l ~/wwe_migrated_db.sql.gz | tr -s " " | cut -d" " -f 6-8 )".";
  
  if [[ $(find ~ -name wwe_migrated_db.sql.gz -newer /tmp/$$) ]]; then
    subject="SUNNY"
    msg="This morning's migration was successful, the QA servers can be updated."; 
    retval=0
  fi

else
  state="The dump file could not be found."

fi

msg=$msg"  "$state
~/bin/mailer/do-mail.sh "$subject" "$msg"

rm -f /tmp/$$
unset msg
unset state
unset subject

exit $retval

