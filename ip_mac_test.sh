#!/bin/bash
# 修改IP地址   范围：1.1.1.1-255.255.255.255
# 修改网关地址 范围：1.1.1.1-255.255.255.255
# 修改DNS地址  范围：1.1.1.1-255.255.255.255
net_path="/etc/sysconfig/network-scripts/"

function change_ip()
{
    # 获取网卡信息
    ethx=`ifconfig | awk -F ' ' '{print $1}' | sed -n '{1p}'`	
    # 拼接网卡配置文件名称
    ethx_path="${net_path}ifcfg-${ethx}"
    # 获取随机数(1-255之间) 
    # ip_a.ip_b.ip_c.ip_d
    local ip_a=`shuf -i 1-255 -n 1`
    local ip_b=`shuf -i 1-255 -n 1`
    local ip_c=`shuf -i 1-255 -n 1`
    local ip_d=`shuf -i 1-255 -n 1`
    local ip_all="${ip_a}\.${ip_b}\.${ip_c}\.${ip_d}"
    \echo "${ip_all}"
    # 设置IP地址
    \sed -i "/IPADDR.*/s/=.*/=${ip_all}/g" ${ethx_path}	
    \echo "${ip_all}">> /tmp/cems/ip_mac_record.dat
} 
function change_gateway()
{
    local ip_a=`shuf -i 1-255 -n 1`
    local ip_b=`shuf -i 1-255 -n 1`
    local ip_c=`shuf -i 1-255 -n 1`
    local ip_d=`shuf -i 1-255 -n 1`
    local ip_all="${ip_a}\.${ip_b}\.${ip_c}\.${ip_d}"
    \echo "${ip_all}"
    #改变网关地址
    \sed -i "/GATEWAY.*/s/=.*/=${ip_all}/g" ${ethx_path}
    \echo "${ip_all}">> /tmp/cems/ip_mac_record.dat
}
function change_dns()
{
    local ip_a=`shuf -i 1-255 -n 1`
    local ip_b=`shuf -i 1-255 -n 1`
    local ip_c=`shuf -i 1-255 -n 1`
    local ip_d=`shuf -i 1-255 -n 1`
    local ip_all="${ip_a}\.${ip_b}\.${ip_c}\.${ip_d}"
    \echo "${ip_all}"
    #改变DNS地址
    \sed -i "/DNS.*/s/=.*/=${ip_all}/g"  ${ethx_path}
}

function Main()
{
    i=0
    while true
    do
    {
        date_now=`date +%H:%M:%S`
        echo "------${i}times-----${date_now}" >> /tmp/cems/ip_mac_record.dat
        ((i++))
        change_ip
        echo "change ip success"
        change_gateway
        echo "change gateway success"
        #change_dns
        #echo "change dns success"
        service network restart >/dev/null
        sleep 40
    }
    done
}
Main
