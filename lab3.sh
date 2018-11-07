#!/usr/bin/sh
data=`ls -ld -- $1 2>>lab3_err `|| { echo "error, see lab3_err"; exit 1; }
for usr in  `getent passwd | nawk -F ':' '{print $1}'` 
do
rights=`echo $data | awk '{print $1}'`
user=`echo $data | awk '{print $3}'`
uid=`id $user| nawk -F '[=(]' '{print $2}'`
uid2=`id $usr | nawk -F '[=(]' '{print $2}'`
group=`echo $data | awk '{print $4}'`
gid=`getent group $group| nawk -F ':' '{print $3}'`
if [ "`echo $data | grep '^d'`" = "" ]
then echo not a directory; exit 1
elif [ "`echo $rights | grep '.......r.x'`" != "" -o $uid2 = 0 ]
then echo $usr
elif [ "$uid" = "$uid2" -a "`echo $rights | grep '.r.x......'`" != "" ]
then echo $usr
elif [ "`id -ap $usr | grep $gid\(`" != ""  -a "`echo $rights | grep '....r.x...'`" != "" ]
then  echo $usr 
fi
done

