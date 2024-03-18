#!/bin/bash

# Script for merging .env (if present) with configuration from
# environment variables, and writing it to env-config.js

declare -A CONFIG

DEFAULT_PATH="/usr/share/nginx/html/"
DIR="${1}"
DIR="${DIR:=$DEFAULT_PATH}"

echo "Configuring environment variables"

if [ -f "${DIR}.env" ]; then
  echo -e "\t.env file present"
  while IFS= read -r line; do
  if printf '%s\n' "$line" | grep -q -e '='; then
    k=$(printf '%s\n' "$line" | xargs | sed -e 's/=.*//')
    v=$(printf '%s\n' "$line" | xargs | sed -e 's/^[^=]*=//')
    CONFIG["${k}"]="${v}"
  fi
  done <<< "$(cat ${DIR}.env | sed 's/#.*//g')"
else
  echo -e "\t.env file not present"
fi

any_from_env=false
while IFS='=' read -r -d '' k v; do
  k=$(printf "$k" | tr '[:lower:]' '[:upper:]')
  case $k in REACT_APP_*) ;; *) false;; esac || continue
  any_from_env=true
  CONFIG["${k}"]="${v}"
done < <(env -0)

if [ $any_from_env ]; then
  echo -e "\tConfiguration found in environment. Applying it."
else
  echo -e "\tNo configuration found in environment"
fi

echo "Done:"
echo "window.env = {" > $DIR/env-config.js
for k in "${!CONFIG[@]}"; do
  v="${CONFIG[$k]}"
  printf "\t%s: \"%s\",\n" $k $v
  printf "\t%s: \"%s\",\n" $k $v >> $DIR/env-config.js
done

echo "}" >> $DIR/env-config.js
