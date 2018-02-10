#!/bin/sh
# mysql_connect_core_func.sh
# 
# 连接配置核心函数
#
# @link https://github.com/cj58/MysqlConnectManage
# @author cj
# @copyright 2018 cj
#

##! @TODO: 打印帮助文档
##! @OUT: 0 => success; 1 => failure 
function printHelp()
{
    echoYellow '===============================================================================';
    echoYellow '# 帮助文档：https://github.com/cj58/MysqlConnectManage #';
    echoYellow '===============================================================================';
    echoYellow '';
}

##! @TODO: 连接数据库
##! @IN: $1 => connectStr
##! @OUT: 0 => success; 1 => failure 
function doMysqlConnect()
{
    local connectStr=$1
    if [ -z "${connectStr}" ];then
        echoRed '[ERROR],connectStr 参数不能为空! in doMysqlConnect()'
        return 1;
    fi 

    echoGreen "[INFO] ${connectStr} 连接中..."
    ${connectStr}
    return 0;
}

##! @TODO: 选择连接方式
##! @IN: $1 => configFile
##! @IN: $2 => choiceNum 传递的选择数字
##! @OUT: 0 => success; 1 => failure 
function choiceConnect()
{
    local configFile=$1
    if [ -z ${configFile} ];then
        echoRed '[ERROR],configFile 参数不能为空! in addNewConnect()'
        return 1;
    fi 

    #当配置文件不存在的时候，添加一个新的连接
    if [ ! -f ${configFile} ];then
        addNewConnect "${configFile}" 
        return 0;
    fi

    echo "请选择需要连接的数据库："
    local tmpNum=1;
    local choiceConnectHash;
    choiceConnectHash[0]='手动添加新的数据库连接'
    echo "0 手动添加新的数据库连接"
    local line='';

    while read line
    do
        echo "${tmpNum} ${line}" 
        choiceConnectHash[${tmpNum}]=$line;
        let tmpNum+=1;
    done < ${configFile}

    local choiceNum=0
    echo '';
    if [ ! $2 ];then
        read -p "请输入连接方式对应的数字(例如：1)：" choiceNum
    else
        choiceNum=$2;
    fi
    choiceNum=$(trimStr "${choiceNum}")
    if [ ${choiceNum} = 0 ];then
        addNewConnect "${configFile}" 
        return 0;
    fi

    local connectStr='';
    local found=0;
    for tmpNum in "${!choiceConnectHash[@]}";   
    do   
        if [ $tmpNum = $choiceNum ];then
            found=1;
            connectStr=${choiceConnectHash[$tmpNum]}
        fi
    done

    if [ ${found} -eq 0 ];then
        echoRed "[ERROR],选择的 ${choiceNum} 连接方式不存在,请重新选择"
        exit;
    fi

    doMysqlConnect "${connectStr}"
}


##! @TODO: 添加一个新的连接
##! @IN: $1 => configFile
##! @OUT: 0 => success; 1 => failure 
function addNewConnect()
{
    local configFile=$1
    if [ -z ${configFile} ];then
        echoRed '[ERROR],configFile 参数不能为空! in addNewConnect()'
        return 1;
    fi 

    local host='';
    local port='';
    local user='';
    local password='';

    echo '';
    read -p "  请输入主机名或IP地址（例如：weihu1-db.bj1.xxx.net）：" host
    read -p "  请输入端口(例如：3306)：" port
    read -p "  请输入用户名(例如：root)：" user
    read -p "  请输入密码(例如：123456)：" password
    host=$(trimStr "${host}")
    port=$(trimStr "${port}")
    user=$(trimStr "${user}")
    password=$(trimStr "${password}")
    if [[ -z ${host} || -z ${port} || -z ${user} || -z ${password} ]];then
        echoRed "[ERROR],全部输入都不能为空！";
        exit;
    fi

    local connectStr='mysql -h '${host}' -P '${port}' -u'${user}' -p'${password}

    echo ${connectStr} >> ${configFile} 
    echoGreen "[INFO] 添加 ${connectStr} 完成"

    doMysqlConnect "${connectStr}"
    return 0;
}
