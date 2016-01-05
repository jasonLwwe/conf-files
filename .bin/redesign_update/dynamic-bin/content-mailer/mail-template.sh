#! /bin/bash

function get_mimetype() {
  file --mime-type "$1" | sed 's/.*: //'
}

from="wwe-jason.jenkins@wwe.com"
to="$( /home/dynamic/bin/content-mailer/recipients.sh )"
subject="Yesterday's content"
boundary="ZZ_/afg6432dfgkl.94531q"
body="Please find yesterday's content list, attached.  This is a list of all content created on the previous day.

Regards,

wwe-jason.jenkins.wwe.com
"
declare -a attachments
attachments=("$1")
{
printf '%s\n' i"From: $from
To: $to
From: $from
Subject: $subject
Mime-Version: 1.0
Content-type: multipart/mixed; boundary=\"$boundary\"

--${boundary}
Content-Type: text/plain; charset=\"US-ASCII\"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

$body
"

for file in "${attachments[@]}"; do

  [ ! -f "$file" ] && echo "Warning: attachment $file not found, skipping" >&2 && continue

  mimetype=$(get_mimetype "$file")
  filename="$(basename $file)"
  printf '%s\n' "--${boundary}
Content-Type: $mimetype
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=\"$filename\"
"
  base64 "$file"
  echo
done

printf '%s\n' "--${boundary}--"

} | msmtp -t
