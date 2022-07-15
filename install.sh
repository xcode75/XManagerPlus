#!/bin/bash

rm -rf $0

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)
 
# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
  arch="64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
  arch="arm64-v8a"
else
  arch="64"
  echo -e "${red}检测架构失败，使用默认架构: ${arch}${plain}"
fi

echo "架构: ${arch}"

if [ "$(getconf WORD_BIT)" != '32' ] && [ "$(getconf LONG_BIT)" != '64' ] ; then
    echo "本软件不支持 32 位系统(x86)，请使用 64 位系统(x86_64)，如果检测有误，请联系作者"
    exit 2
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        echo -e "${red}请使用 CentOS 7 或更高版本的系统！${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        echo -e "${red}请使用 Ubuntu 16 或更高版本的系统！${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        echo -e "${red}请使用 Debian 8 或更高版本的系统！${plain}\n" && exit 1
    fi
fi

install_base() {
    if [[ x"${release}" == x"centos" ]]; then
        yum install epel-release -y
        yum install wget curl unzip tar crontabs socat -y
    else
        apt update -y
        apt install wget curl unzip tar cron socat -y
    fi
}

# 0: running, 1: not running, 2: not installed
check_status() {
    if [[ ! -f /etc/systemd/system/XMPlus.service ]]; then
        return 2
    fi
    temp=$(systemctl status XMPlus | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ x"${temp}" == x"running" ]]; then
        return 0
    else
        return 1
    fi
}

install_acme() {
    curl https://get.acme.sh | sh
}

install_XMPlus() {
    if [[ -e /usr/local/XMPlus/ ]]; then
        rm /usr/local/XMPlus/ -rf
    fi

    mkdir /usr/local/XMPlus/ -p
	cd /usr/local/XMPlus/

    if  [ $# == 0 ] ;then
        last_version=$(curl -Ls "https://api.github.com/repos/xcode75/XMPlus/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
        if [[ ! -n "$last_version" ]]; then
            echo -e "${red}检测 XMPlus 版本失败，可能是超出 Github API 限制，请稍后再试，或手动指定 XMPlus 版本安装${plain}"
            exit 1
        fi
        echo -e "检测到 XMPlus 最新版本：${last_version}，开始安装"
        wget -N --no-check-certificate -O /usr/local/XMPlus/XMPlus-linux.zip https://github.com/xcode75/XMPlus/releases/download/${last_version}/XMPlus-linux-${arch}.zip
        if [[ $? -ne 0 ]]; then
            echo -e "${red}下载 XMPlus 失败，请确保你的服务器能够下载 Github 的文件${plain}"
            exit 1
        fi
    else
        last_version=$1
        url="https://github.com/xcode75/XMPlus/releases/download/${last_version}/XMPlus-linux-${arch}.zip"
        echo -e "开始安装 XMPlus v$1"
        wget -N --no-check-certificate -O /usr/local/XMPlus/XMPlus-linux.zip ${url}
        if [[ $? -ne 0 ]]; then
            echo -e "${red}下载 XMPlus v$1 失败，请确保此版本存在${plain}"
            exit 1
        fi
    fi

    unzip XMPlus-linux.zip
    rm XMPlus-linux.zip -f
    chmod +x XMPlus
    mkdir /etc/XMPlus/ -p
    rm /etc/systemd/system/XMPlus.service -f
    file="https://github.com/xcode75/XMPlus/raw/master/XMPlus.service"
    wget -N --no-check-certificate -O /etc/systemd/system/XMPlus.service ${file}
    #cp -f XMPlus.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl stop XMPlus
    systemctl enable XMPlus
    echo -e "${green}XMPlus ${last_version}${plain} 安装完成，已设置开机自启"
    cp geoip.dat /etc/XMPlus/
    cp geosite.dat /etc/XMPlus/ 
    cp dns.json /etc/XMPlus/
	cp route.json /etc/XMPlus/
	cp outbound.json /etc/XMPlus/
    cp rulelist /etc/XMPlus/

    if [[ ! -f /etc/XMPlus/config.yml ]]; then
        cp config.yml /etc/XMPlus/
        echo -e ""
        echo -e "全新安装，请先参看教程：https://github.com/xcode75/XMPlus，配置必要的内容"
    else
        systemctl start XMPlus
        sleep 2
        check_status
        echo -e ""
        if [[ $? == 0 ]]; then
            echo -e "${green}XMPlus 重启成功${plain}"
        else
            echo -e "${red}XMPlus 可能启动失败，请稍后使用 XMPlus log 查看日志信息，若无法启动，则可能更改了配置格式，请前往 wiki 查看：https://github.com/xcode75/XMPlus${plain}"
        fi
    fi

    if [[ ! -f /etc/XMPlus/dns.json ]]; then
        cp dns.json /etc/XMPlus/
    fi
    
    curl -o /usr/bin/XMPlus -Ls https://raw.githubusercontent.com/xcode75/XMPlus/master/XMPlus.sh
    chmod +x /usr/bin/XMPlus
    ln -s /usr/bin/XMPlus /usr/bin/xray 
    chmod +x /usr/bin/xray

    echo -e ""
    echo "XMPlus 管理脚本使用方法 (兼容使用xray执行，大小写不敏感): "
    echo "------------------------------------------"
    echo "XMPlus                    - 显示管理菜单 (功能更多)"
    echo "XMPlus start              - 启动 XMPlus"
    echo "XMPlus stop               - 停止 XMPlus"
    echo "XMPlus restart            - 重启 XMPlus"
    echo "XMPlus status             - 查看 XMPlus 状态"
    echo "XMPlus enable             - 设置 XMPlus 开机自启"
    echo "XMPlus disable            - 取消 XMPlus 开机自启"
    echo "XMPlus log                - 查看 XMPlus 日志"
    echo "XMPlus update             - 更新 XMPlus"
    echo "XMPlus update vx.x.x      - 更新 XMPlus 指定版本"
    echo "XMPlus config             - 显示配置文件内容"
    echo "XMPlus install            - 安装 XMPlus"
    echo "XMPlus uninstall          - 卸载 XMPlus"
    echo "XMPlus version            - 查看 XMPlus 版本"
    echo "------------------------------------------"
}

echo -e "${green}开始安装${plain}"
install_base
install_acme
install_XMPlus $1
