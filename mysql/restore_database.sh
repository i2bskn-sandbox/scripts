#!/bin/bash

export PATH=/usr/local/mysql/bin:$PATH
host=localhost
user=root
passwd=secret

function usage() {
  echo "USAGE: `basename ${0}` BACKUP_FILE DATABASE"
}

if [ -z ${1} ] || [ -z ${2} ]; then
  usage
  exit 1
fi

if [ ! -f ${1} ]; then
  echo "File not found: ${1}"
  exit 1
fi

if [ -z ${passwd} ]; then
  gzip -cd $1 | mysql -u${user} -h${host} $2
else
  gzip -cd $1 | mysql -u${user} -h${host} -p${passwd} $2
fi
