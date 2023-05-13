#!/bin/bash

sourceUrl='http://build.openanolis.cn/kojifiles/upstream-source'

while read line
do
  pkg=`echo $line|awk '{print $2}'`
  pkgchecksum=`echo $line|awk '{print $1}'`
  wget -O ${pkg} ${sourceUrl}/${pkg}.${pkgchecksum}
done < download
