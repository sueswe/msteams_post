#!/bin/bash

# Thanks to https://gist.github.com/chusiang/895f6406fbf9285c58ad0a3ace13d025

me=$(basename $0)
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: ${me} \"<webhook_url>\" \"<title>\" \"<color>\" \"<message>\" "
  exit 1
fi

WEBHOOK_URL=$1
if [[ "${WEBHOOK_URL}" == "" ]]; then
  echo "No webhook_url specified."
  exit 1
fi
TITLE=$2
if [[ "${TITLE}" == "" ]]; then
  echo "No title specified."
  exit 1
fi
COLOR=$3
if [[ "${COLOR}" == "" ]]; then
  echo "No color specified...setting a default."
  echo COLOR="ff0000"
fi
TEXT=$*
if [[ "${TEXT}" == "" ]]; then
  echo "No text specified."
  exit 1
fi

MESSAGE=$( echo ${TEXT} | sed 's/"/\"/g' | sed "s/'/\'/g" )
JSON="{\"title\": \"${TITLE}\", \"themeColor\": \"${COLOR}\", \"text\": \"${MESSAGE}\" }"
echo "Posting to Microsoft Teams ..."
curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK_URL}"
exit $?
