#!bin/bash

# 修改IP地址   范围：1.1.1.1-255.255.255.255
# 修改网关地址 范围：1.1.1.1-255.255.255.255
# 修改DNS地址  范围：1.1.1.1-255.255.255.255

function change_ip()
{
	# 获取网卡信息
	ethx=`ifconfig | awk -F ' ' '{print $1}' | sed -n '{1p}'`	

       	# 获取随机数(1-255之间) 
	# ip_a.ip_b.ip_c.ip_d
	ip_a=`shuf -i 1-255 -n 1`
	ip_b=`shuf -i 1-255 -n 1`
	ip_c=`shuf -i 1-255 -n 1`
	ip_d=`shuf -i 1-255 -n 1`
	echo "${ip_a}"
	echo "${ip_b}"
	echo "${ip_c}"
	echo "${ip_d}"
	ip_all="${ip_a}\.${ip_a}\.${ip_a}\.${ip_a}"
	echo "${ip_all}"

	# 设置IP地址
	ifconfig ${ethx} ${ip_all}
} 
function change_gateway()
{

}

function change_dns()
{

}

function Main()
{
	change_ip
}
Main
