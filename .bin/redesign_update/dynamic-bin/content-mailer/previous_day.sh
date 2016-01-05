#! /bin/bash

# Retrieve data from previous day...
date_string="date_format(date_sub(now(), interval 1 day), '%Y-%m-%d 00:00:00')"
# ...except for on Monday, retrieve data from Friday.
if [[ $(date +'%u') -eq 1 ]]; then 
  date_string="date_format(date_sub(now(), interval 3 day), '%Y-%m-%d 00:00:00')"; 
fi

prod="http://www.global.cloud.wwe.com/"
dev="http://www.qa-stage.cloud.wwe.com/"

sql="\
SELECT \
  n.nid as Node, ',', \
  from_unixtime(n.created) as Date, ',', \
  n.type as Type, ',', \
  concat('$prod', u.alias) as 'Global URL', ',', \
  concat('$dev', u.alias) as 'Redesign URL', ',', \
  concat('$dev', u.source, '/edit') as 'Redesign EDIT URL' \
FROM node n, url_alias u \
WHERE n.nid<35000000 AND n.created>=unix_timestamp($date_string) AND u.source=concat('node/',n.nid) \
GROUP BY n.nid \
ORDER BY n.type ASC;"

mysql wwe3 -e "$sql" | \
  sed 's/\s*,\s*/,/g' | \
  sed 's/Node\s*Date\s*Type\s*Global URL\s*Redesign URL\s*Resesign EDIT URL/Node,Date,Type,Global URL,Redesign URL,Redesign EDIT URL/' \
  > $1;

/home/dynamic/bin/content-mailer/mail-template.sh $1

