#!/bin/bash
function check_url(){
 #curl -I -s $1|head -1 && return 0 || return 1
 a=(`curl -I -s $1|head -1`)
 for ((i=0;i<${#a[*]};i++))
 do
        if [ ${a[1]} != "200" -a ${a[2]} != "OK" ];then
            echo "url erro"
        else
           echo "SUCREE"
        fi
 done
}
check_url $1
