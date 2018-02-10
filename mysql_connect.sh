#!/bin/sh
# mysql_connect.sh
# 
# mysql连接管理脚本脚本
#
# @link https://github.com/cj58/MysqlConnectManage
# @author cj
# @copyright 2018 cj
#

SRC_ROOT=$(cd `dirname $0`; pwd);
#加载基础核心函数
source ${SRC_ROOT}/base_core_func.sh
#功能核心函数
source ${SRC_ROOT}/mysql_connect_core_func.sh

##! @TODO: 程序运行单一入口
##! @OUT: 0 => success; 1 => failure 
function run()
{
    #打印帮助
    printHelp
    #选择连接方式
    local configFile=${SRC_ROOT}/mysql_connect_config.cnf
    choiceConnect ${configFile} $1
    return 0;
}
run $1
