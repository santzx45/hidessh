#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

MYIP=$(curl -sS ipv4.icanhazip.com)
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

source /usr/sbin/potatonc/ipaddr.conf
if [[ "$IP_ADDR" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP_ADDR
fi

tls="443"
none="80"
until [[ $user =~ ^[a-z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do

                read -rp "User: " -e user
                CLIENT_EXISTS=$(grep -w $user /etc/default/syncron/paradis/paradis.json | wc -l)

                if [[ ${CLIENT_EXISTS} -gt "0" ]]; then
clear
                        echo ""
                        echo "A client with the specified name was already created, please choose another name."
                        echo ""

                        exit 0;
                fi
        done

uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=999999
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/default/syncron/paradis/paradis.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/default/syncron/paradis/paradis.json
sed -i '/#grpcvmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/default/syncron/drill/drill.json
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${user}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${user}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${user}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "     Xray/V2Ray/Vmess Account      " | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "Remarks : ${user}" | tee -a /etc/log-create-user.log
echo -e "Domain : ${domain}" | tee -a /etc/log-create-user.log
echo -e "Port TLS : ${tls}" | tee -a /etc/log-create-user.log
echo -e "Port none TLS : ${none}" | tee -a /etc/log-create-user.log
echo -e "Port  GRPC : ${tls}" | tee -a /etc/log-create-user.log
echo -e "id : ${user}" | tee -a /etc/log-create-user.log
echo -e "alterId : 0" | tee -a /etc/log-create-user.log
echo -e "Security : auto" | tee -a /etc/log-create-user.log
echo -e "Network : ws" | tee -a /etc/log-create-user.log
echo -e "Path : /vmess" | tee -a /etc/log-create-user.log
echo -e "ServiceName : vmess" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "Link TLS : ${vmesslink1}" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "Link non-TLS : ${vmesslink2}" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "Link GRPC : ${vmesslink3}" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
rm /etc/xray/$user-tls.json > /dev/null 2>&1
rm /etc/xray/$user-none.json > /dev/null 2>&1
