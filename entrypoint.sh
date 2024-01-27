#!/bin/bash

# 定义信号处理函数
function terminate_openconnect {
  echo "Terminating openconnect..."
  killall openconnect
  exit 0
}

# 捕捉SIGTERM信号
trap 'terminate_openconnect' SIGTERM

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

# Start ocproxy
ocproxy &

if [ $OC_ARGS ]; then
  echo "openconnect args: $OC_ARGS"
  ARGS=($OC_ARGS)
  echo $PASS | openconnect "${ARGS[@]}" --script-tun --script "ocproxy $PROXY_ARGS" --user $USER --passwd-on-stdin $URL &
else
  echo $PASS | openconnect --script-tun --script "ocproxy $PROXY_ARGS" --user $USER --passwd-on-stdin $URL &
fi

# 以下是一个无限循环，让脚本保持运行状态
while true; do
  wait $!
done