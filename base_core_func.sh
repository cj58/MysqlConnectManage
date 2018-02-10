#!/bin/sh
# base_core_func.sh
# 
# 基础核心函数
#
# @link https://github.com/cj58/MysqlConnectManage
# @author cj
# @copyright 2018 cj
#

##! @TODO: 去掉字符串前后空格
##! @IN: $1 => str
##! @OUT: val string 
function trimStr()
{
    local str=$1;
    local val='';
    if [[ -z ${str} ]];then
        echo $val;
        return 0;
    fi
    val=$(echo "${str}" | sed  's/^[ \t]*//g' | sed 's/[ \t]*$//g') 
    echo $val;
    return 0;
}

##! @TODO: 设置配置文件key=val
##! @IN: $1 => configFile
##! @IN: $2 => key
##! @IN: $3 => val
##! @OUT: 0 => success; 1 => failure 
function setConfig()
{
    local configFile=$1;
    local key=$2;
    local val=$3;
    if [[ -z ${configFile} || -z ${key} || -z ${val} ]];then
        echo '[ERROR],参数不能为空 in setConfig()' 
        return 1;
    fi

    local newLine="$key=${val}"
    #文件不存在
    if [ ! -f ${configFile} ];then
        echo $newLine >> $configFile;
        return 0;
    fi

    local tmpNum=$(sed -n "/$key\=/=" $configFile | head -n 1)
    if [[ $tmpNum -gt 0 ]];then
        #替换这一行
        sed -i "${tmpNum}s/.*/${newLine}/" $configFile 
    else
        echo $newLine >> $configFile;
    fi
}

##! @TODO: 读取配置文件key
##! @IN: $1 => configFile
##! @IN: $2 => key
##! @OUT: val string 
function getConfig()
{
    local configFile=$1;
    local key=$2;
    local val='';
    if [[ -z ${configFile} || -z ${key} ]];then
        echo '[ERROR],参数不能为空 in getConfig()' 
        return 1;
    fi
    #文件不存在
    if [ ! -f ${configFile} ];then
        echo $val;
        return 0;
    fi

    local tmpNum=$(sed -n "/$key\=/=" $configFile | head -n 1)
    if [[ $tmpNum -gt 0 ]];then
        val=$(sed -n "${tmpNum}p" ${configFile} | awk -F"=" '{print $2}')
    fi
    echo $val;
    return 0;
}


##! @TODO: 打印绿色
##! @IN: $* => string
##! @OUT: void
function echoGreen() 
{
    echo -e "\\033[0;32m $* \\033[0;39m"
}

##! @TODO: 打印红色
##! @IN: $* => string
##! @OUT: void
function echoRed() 
{
    echo -e "\033[31m $* \033[0m"
}

##! @TODO: 打印黄色
##! @IN: $* => string
##! @OUT: void
function echoYellow() 
{
    echo -e "\033[33m $* \033[0m"
}

##! @TODO: 打印错误并且退出
##! @IN: $* => string
##! @OUT: void
function errorMsg() 
{
    echoRed "$1"
    exit 1
}
