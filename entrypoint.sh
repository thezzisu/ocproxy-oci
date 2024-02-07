#!/bin/bash

# # 定义信号处理函数
function terminate_openconnect {
  echo "Terminating openconnect..."
  killall openconnect
  exit 0
}

# # 捕捉SIGTERM信号
trap 'terminate_openconnect' SIGTERM

expect /connect.sh &

# if [ $? -ne 0 ]; then
#   echo "Failed to connect"
#   killall openconnect
#   exit 1
# fi

while true; do
  wait $!
done
