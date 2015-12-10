#! /bin/bash

# REQUIRED:
#   -s string to search for in file_managed.uri
# optional:
#   -m option displays only those items that ls fails to list

MISSING=""
QUERY_ONLY=0
while [[ $# > 0 ]] ; do
  key="$1"
  case $key in
    -q|--only-query)
      QUERY_ONLY=1
      ;;
    -m|--missing)
      MISSING=" | grep -E \"^ls:\" | tr -s \" \" | cut -d \" \" -f 4 | cut -d \":\" -f1 | xargs -I{} echo File missing: {} " ;
      ;;
    -s|--search)
      SEARCH="$2";
      shift
      ;;
    *)
      ;;
  esac

  shift
done

if [[ -z "$SEARCH" ]]; then
  echo $0: Missing search string arg, use "-s" to specify;
  exit 1;
fi

if [[ $QUERY_ONLY -eq 1 ]]; then
  cmd="mysql -u root -p -e \"select fid, filename, uri, status from wwe.file_managed where uri like \\\"%$SEARCH%\\\";\"";
else
  query="mysql -u root -p -e \"select uri from wwe.file_managed where uri like \\\"%$SEARCH%\\\";\"";
  cmd="$query"" | grep -E \"$SEARCH\" | cut -d\"/\" -f2- | grep -Ev \"'\" | xargs -I{} ls \"f{}\" 2>&1 | sort ""$MISSING"
fi

eval $cmd 

