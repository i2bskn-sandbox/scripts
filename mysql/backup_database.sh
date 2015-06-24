#!/bin/bash

# Backup database
export PATH=/usr/local/mysql/bin:$PATH
host=localhost
user=root
passwd=secret
db_array=(database_name)
bk_dir=/usr/local/backup

for db in ${db_array[@]}; do
  mysqldump --extended-insert --disable-keys --single-transaction --flush-logs -u${user} -h${host} -p${passwd} ${db} | gzip > ${bk_dir}/${db}_`date +%Y%m%d%H%M%S`.gz
done

find ${bk_dir} -mtime +30 -type f -name '*.gz' | xargs rm -f
