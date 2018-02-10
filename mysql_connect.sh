#!/bin/sh
# mysql_connect.sh
# 
# mysql connect manage
#
# @link https://github.com/cj58/MysqlConnectManage
# @author cj
# @copyright 2018 cj
#

SRC_ROOT=$(cd `dirname $0`; pwd);
#include base_core_func
source ${SRC_ROOT}/base_core_func.sh
#include mysql_connect_core_func
source ${SRC_ROOT}/mysql_connect_core_func.sh

##! @TODO: do run
##! @OUT: 0 => success; 1 => failure 
function run()
{
    #print help doc
    printHelp
    #choiceConnect
    local configFile=${SRC_ROOT}/mysql_connect_config.cnf
    choiceConnect ${configFile} $1
    return 0;
}
run $1
