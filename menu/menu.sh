NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray_service == "running" ]]; then
status_xray="${GB}[ ON ]${NC}"
else
status_xray="${RB}[ OFF ]${NC}"
fi
if [[ $nginx_service == "running" ]]; then
status_nginx="${GB}[ ON ]${NC}"
else
status_nginx="${RB}[ OFF ]${NC}"
fi
dtoday="$(vnstat | grep today | awk '{print $2" "substr ($3, 1, 3)}')"
utoday="$(vnstat | grep today | awk '{print $5" "substr ($6, 1, 3)}')"
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}')"
dmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $2" "substr ($3, 1 ,3)}')"
umon="$(vnstat -m | grep `date +%G-%m` | awk '{print $5" "substr ($6, 1 ,3)}')"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}')"
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
WKT=$(cat /usr/local/etc/xray/timezone)
DATE=$(date -R | cut -d " " -f -4)
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e "               ${GB}----- [ Xray Script ] -----${NC}              "
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e " ${RB}Service Provider${NC} ${GB}: $ISP"
echo -e " ${RB}Timezone${NC}         ${GB}: $WKT${NC}"
echo -e " ${RB}City${NC}             ${GB}: $CITY${NC}"
echo -e " ${RB}Date${NC}             ${GB}: $DATE${NC}"
echo -e " ${RB}Domain${NC}           ${GB}: $domain${NC}"
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e "     ${GB}NGINX STATUS :${NC} $status_nginx    ${GB}XRAY STATUS :${NC} $status_xray   "
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e "          ${GB}----- [ Bandwidth Monitoring ] -----${NC}"
echo -e ""
echo -e "  ${GB}Today ($DATE)     Monthly ($(date +%B/%Y))${NC}      "
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e "    ${GB}↓↓ Down: $dtoday          ↓↓ Down: $dmon${NC}   "
echo -e "    ${GB}↑↑ Up  : $utoday          ↑↑ Up  : $umon${NC}   "
echo -e "    ${GB}≈ Total: $ttoday          ≈ Total: $tmon${NC}   "
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e "                ${GB}----- [ Xray Menu ] -----${NC}               "
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e " ${MB}[1]${NC} ${RB}Vmess Menu${NC}          ${MB}[5]${NC} ${RB}Shadowsocks 2022 Menu${NC}"
echo -e " ${MB}[2]${NC} ${RB}Vless Menu${NC}          ${MB}[6]${NC} ${RB}Socks5 Menu${NC}"
echo -e " ${MB}[3]${NC} ${RB}Trojan Menu${NC}         ${MB}[7]${NC} ${RB}All Xray Menu${NC}"
echo -e " ${MB}[4]${NC} ${RB}Shadowsocks Menu${NC}"
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e "                 ${GB}----- [ Utility ] -----${NC}                "
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e " ${MB}[8]${NC} ${RB}Log Create Account${NC}  ${MB}[13]${NC} ${RB}DNS Setting${NC}"
echo -e " ${MB}[9]${NC} ${RB}Speedtest${NC}           ${MB}[14]${NC} ${RB}Check DNS Status${NC}"
echo -e " ${MB}[10]${NC} ${RB}Change Domain${NC}      ${MB}[15]${NC} ${RB}Change Xray-core Mod${NC}"
echo -e " ${MB}[11]${NC} ${RB}Cert Acme.sh${NC}       ${MB}[16]${NC} ${RB}Change Xray-core Official${NC}"
echo -e " ${MB}[12]${NC} ${RB}About Script${NC}"
echo -e "${YB}————————————————————————————————————————————————————————${NC}"
echo -e ""
read -p " Select Menu :  "  opt
echo -e ""
case $opt in
1) clear ; vmess ;;
2) clear ; vless ;;
3) clear ; trojan ;;
4) clear ; shadowsocks ;;
5) clear ; shadowsocks2022 ;;
6) clear ; socks ;;
7) clear ; allxray ;;
8) clear ; log-create ;;
9) clear ; speedtest ;;
10) clear ; dns ;;
11) clear ; certxray ;;
12) clear ; about ;;
13) clear ; changer ;;
14) clear ;
resolvectl status
echo ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
echo ""
echo ""
menu ;;
15) clear ; xraymod ;;
16) clear ; xrayofficial ;;
x) exit ;;
*) echo -e "${RB}salah input${NC}" ; sleep 1 ; menu ;;
esac
