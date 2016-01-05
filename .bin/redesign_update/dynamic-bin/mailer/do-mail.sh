#!/bin/bash
to="$( /home/dynamic/bin/mailer/recipients.sh )"
cat <<EOL | msmtp -t
To: $to
From: wwe-jason.jenkins@wwe.com
Subject: Morning migration status report: $1

Hello,

$2

Regards, 

$(whoami)@$(hostname):$0

EOL
