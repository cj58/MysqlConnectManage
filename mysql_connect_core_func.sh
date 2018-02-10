#!/bin/sh
# mysql_connect_core_func.sh
# 
# mysql connect core func
#
# @link https://github.com/cj58/MysqlConnectManage
# @author cj
# @copyright 2018 cj
#

##! @TODO: Help document
##! @OUT: 0 => success; 1 => failure 
function printHelp()
{
    echoYellow '===============================================================================';
    echoYellow '# Help Document:https://github.com/cj58/MysqlConnectManage #';
    echoYellow '===============================================================================';
    echoYellow '';
}

##! @TODO: doMysqlConnect
##! @IN: $1 => connectStr
##! @OUT: 0 => success; 1 => failure 
function doMysqlConnect()
{
    local connectStr=$1
    if [ -z "${connectStr}" ];then
        echoRed '[ERROR],connectStr config can not be empty! in doMysqlConnect()'
        return 1;
    fi 

    echoGreen "[INFO] ${connectStr} connecting..."
    ${connectStr}
    return 0;
}

##! @TODO: choiceConnect
##! @IN: $1 => configFile
##! @IN: $2 => choiceNum 
##! @OUT: 0 => success; 1 => failure 
function choiceConnect()
{
    local configFile=$1
    if [ -z ${configFile} ];then
        echoRed '[ERROR],configFile config can not be empty! in addNewConnect()'
        return 1;
    fi 

    #config file not exits
    if [ ! -f ${configFile} ];then
        addNewConnect "${configFile}" 
        return 0;
    fi

    echo "Select the database you want to connect to:"
    local tmpNum=1;
    local choiceConnectHash;
    choiceConnectHash[0]='Add a new database connection'
    echo "0 Add a new database connection"
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
        read -p "Please enter the number corresponding to the connection mode(example:1):" choiceNum
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
        echoRed "[ERROR],choice ${choiceNum} not exist,try again"
        exit;
    fi

    doMysqlConnect "${connectStr}"
}


##! @TODO: add New Connect
##! @IN: $1 => configFile
##! @OUT: 0 => success; 1 => failure 
function addNewConnect()
{
    local configFile=$1
    if [ -z ${configFile} ];then
        echoRed '[ERROR],configFile  can not be empty! in addNewConnect()'
        return 1;
    fi 

    local host='';
    local port='';
    local user='';
    local password='';

    echo 'add New Connect:';
    read -p "  database Host or IP(example:weihu1-db.bj1.xxx.net):" host
    read -p "  port(example:3306):" port
    read -p "  user(example:root):" user
    read -p "  password(example:123456):" password
    host=$(trimStr "${host}")
    port=$(trimStr "${port}")
    user=$(trimStr "${user}")
    password=$(trimStr "${password}")
    if [[ -z ${host} || -z ${port} || -z ${user} || -z ${password} ]];then
        echoRed "[ERROR],All input cannot be empty!";
        exit;
    fi

    local connectStr='mysql -h '${host}' -P '${port}' -u'${user}' -p'${password}

    echo ${connectStr} >> ${configFile} 
    echoGreen "[INFO] add ${connectStr} complete"

    doMysqlConnect "${connectStr}"
    return 0;
}
