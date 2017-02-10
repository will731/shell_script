#!/bin/bash
search_db=`mysql -uroot -ptom123 -e "show databases;"|egrep -v "Database|_schema|mysql"`
backup_mysql(){

 for i in ${search_db}
 do
      mysqldump -uroot -ptom123 -B $i >/tmp/$i.sql
 done
}



main(){
	case $1 in
	back_db)
		backup_mysql
           ;;
	help)
	   ;;
	*)
		echo "Usage $0 back_db|help"
	   ;;
	esac
}

main $1
