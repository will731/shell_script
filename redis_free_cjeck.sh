#! /bin/bash

SERVERIP="192.168.90.1"
#SERVERIP="127.0.0.1"

REDISPORT="16379 26379 36379 46379"

mem_target=0.5

for i in $SERVERIP

        do

        maxmemory=$(/Data/redis-3.0.7-01/src/redis-cli -h 127.0.0.1 -p 16379 config get maxmemory | awk 'NR==2 {print $1}')
        #maxmemory=$(/Data/local/redis-3.0.5/src/redis-cli -h 16379 -p 16379 config get maxmemory | awk 'NR==2 {print $1}')

        used_memory=$(/Data/redis-3.0.7-01/src/redis-cli  -h 127.0.0.1 -p 16379 info memory | grep used_memory: | awk -F : '{print $2}' | sed 's/\r//g')

        mem_ratio=$(awk 'BEGIN {printf("%.2f",'$used_memory'/'$maxmemory')}')

        /Data/redis-3.0.7-01/src/redis-cli  -h 127.0.0.1 -p 16379 info > /tmp/redis.info

        used_memory_cat=$(/Data/redis-3.0.7-01/src/redis-cli  -h 127.0.0.1 -p 16379 info memory)

        if [ $(echo "$mem_ratio>$mem_target" | bc) -eq 1 ] ; then
                echo "1"
           #python /home/sa/scripts/send.py -d ****@126.com -s "Redis服务器16379内存使用过量警告" -t "Hi:\nRedis服务器16379预设内存阀值溢出;\n当前Reids服务器最大可用内存为:$maxmemory;\n当前Reids服务器预设报警阀值为:$mem_target;\n当前Reids服务器已用内存占预设最大内存的:$mem_ratio;\n当前Reids服务器已使用内存情况如下:\n $used_memory_cat\n更多使用详情见附件！" -f "/tmp/redis.info"

           else
                echo "0"
           #python /home/sa/scripts/send.py -d *****@126.com -s "Redis服务器16379内存使用状况报告" -t "Hi:\nRedis服务器16379内存使用状况分析:\n当前Reids服务器最大可用内存为:$maxmemory;\n当前Reids服务器预设报警阀值为:$mem_target;\n当前Reids服务器已用内存占预设最大内存的:$mem_ratio;\n已使用内存情况如下\n $used_memory_cat\n更多使用详情见附件!" -f "/tmp/redis.info"

        fi

done
