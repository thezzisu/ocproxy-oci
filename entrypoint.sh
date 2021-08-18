#!/bin/bash

if [ $USER ] && [ $PASS ]; then
  echo "Welcome $USER"
else
  echo "Must provide USER and PASS env"
  exit 1
fi

if [ $URL ]; then
  echo "Connecting to $URL"
else
  echo "Must provide URL env"
  exit 1
fi

PROXY_ARGS=${PROXY_ARGS:="-D 1080 -g"}
echo "ocproxy args: $PROXY_ARGS"

if [ $OC_ARGS ]; then
  echo "openconnect args: $OC_ARGS"
  ARGS=($OC_ARGS)
  echo $PASS | openconnect "${ARGS[@]}" --script-tun --script "ocproxy $PROXY_ARGS" --user $USER --passwd-on-stdin $URL
else
  echo $PASS | openconnect --script-tun --script "ocproxy $PROXY_ARGS" --user $USER --passwd-on-stdin $URL
fi