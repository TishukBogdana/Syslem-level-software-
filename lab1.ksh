#!/usr/bin/ksh

FILE=$HOME/lab1_err
#IFS=''
change_perm() {
   chmod -- $1 "$2"  2>>$LOG_FILE || 
               echo "Cannot change permissions: $2" >&2 
}
touch $PWD/lab1_err
while true
do
 
   echo 'Menu:
1. Print name of current directory.
2. Create new file.
3. Reject access of other users to file.
4. Reject write rights for owner of file to the file.
5. Rename file.
6. Exit.'

   echo "Enter code:"; read menu || exit -1
   case $menu in
      1) pwd 2>>lab1_err || echo "Some error occured, more in lab1_err file" >&2 ;;
      2) echo 'Enter filename' ; read filename || exit -1; 
         echo 'Enter path (pathname should finish with /)' ; read pathname || exit -1
	 touch $pathname$filename 2>>lab1_err || echo "Some error occured, more in lab1_err file" >&2;;
      3) echo "Enter filename:"; read filename || exit -1
	 echo 'Enter path (pathname should finish with /)' ; read pathname || exit -1
         chmod o-rwx $pathname$filename 2>>lab1_err || 
                  echo "Some error occured, more in lab1_err file" >&2 
         ;;
      4) echo "Enter filename:"; read filename || exit -1
	 echo 'Enter path (pathname should finish with /)' ; read pathname || exit -1
         chmod u-w $pathname$filename 2>>lab1_err || 
                  echo "Some error occured, more in lab1_err file" >&2 
         ;;        
      5) echo "Enter filename:"; read filename || exit -1
	 echo 'Enter path (pathname should finish with /)' ; read pathname || exit -1
	 echo "Enter new name:"; read newname || exit -1
           mv $pathname$filename $pathname$newname 2>>lab1_err || echo "Some error occured, more in lab1_err file" >&2 ;;
      6) exit 0 ;;
      *) echo "Command $menu doesn't exist " >&2 ;;
   esac 
done

