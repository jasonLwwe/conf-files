#!/bin/bash

# $1 path to script that outputs the recipient list
# $2 status message for the subject lin
# $3 message body

to="$($1)"

cat <<EOL | msmtp -t
To: $to
From: wwe-jason.jenkins@wwe.com
Subject: Morning migration status report: $2

Hello,

$3

Regards, 

$(hostname)

EOL
