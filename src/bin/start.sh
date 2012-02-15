#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

for source in $(find $ROOT/etc -type f) 
do
  target="${ROOT}/${source//"${ROOT}/etc"}"
  if [[ $target =~ \.m4$ ]] 
  then
    extension="m4"
    target=${target//.m4}
  else
    extension=""
  fi
  case $extension in
    m4 )
      m4 "-DGXY_DEPLOY_ROOT=$ROOT" "$source" > "$target"
      ;;
    * )
      cp "$source" "$target"
  esac
done

$ROOT/httpd/bin/apachectl start