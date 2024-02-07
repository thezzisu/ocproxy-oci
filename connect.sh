#!/usr/bin/expect -f

# 设置超时时间
set timeout -1

# 获取环境变量
set user $env(USER)
set pass $env(PASS)
set url $env(URL)
set id_card $env(ID_CARD)
set phone_number $env(PHONE_NUMBER)
set oc_args $env(OC_ARGS)

# 检查必要的环境变量
if {$user == "" || $pass == ""} {
  puts "Must provide USER and PASS env"
  exit 1
}
if {$url == ""} {
  puts "Must provide URL env"
  exit 1
}

# 开始连接
spawn openconnect $oc_args --script-tun --script "ocproxy -D 1080 -g" --user $user $url

# 期待密码提示
expect "Password:"
# 发送密码
send "$pass\r"

# 检查北大VPN的额外凭据提示
expect {
  "Please enter your passcode:" {
    send "$pass\r"
    exp_continue
  }
  "北大VPN提示您：此登录需额外补充凭据，请在下面 <验证信息> 或 <输入响应> 框内输入本人身份证后6位" {
    send "$id_card\r"
    exp_continue
  }
  "北大VPN提示您：此登录需额外补充凭据，请在下面 <验证信息> 或 <输入响应> 框内输入4位缺位电话号码" {
    send "$phone_number\r"
    exp_continue
  }
  "Session terminated by server; exiting."{
    puts "[ERROR] Session terminated by server; exiting."
    exit 1
  }
  timeout {
    puts "[ERROR] Connection timed out"
    exit 1
  }
}

# 保持连接
set timeout -1
expect {
    timeout { exp_continue }
}
