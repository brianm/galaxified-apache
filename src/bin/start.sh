#!/bin/bash

PORT="8000"
echo $(which bash)
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo "ROOT   $ROOT"

for source in $(find $ROOT/etc -type f) 
do
  target="${ROOT}/${source#"$ROOT/etc/"}"
  if [[ $target =~ \.m4$ ]] 
  then
    extension="m4"
    target=${target%".m4"}
  else
    extension=""
  fi
  case $extension in
    m4 )
      #echo "m4 processing $source"
      m4 "-DGXY_PORT=$PORT" "-DGXY_DEPLOY_ROOT=$ROOT" "$source" > "$target"
      ;;
    * )
      cp "$source" "$target"
  esac
done

$ROOT/httpd/bin/apachectl start

