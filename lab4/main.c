#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <dirent.h>
void print_file(const int fd, int count);
void print_err_info(int err, const char * str);
int main(int argc, char * argv[])
{
int i, n, fd, mark =0;
FILE * f ;
DIR * dir;
char * arg = argv[1];
char * header="\n ==>  ";
char * footer =" <== \n\n";
//key check
if(arg[0]=='-'){
n=-atoi(argv[1]);
i=2;
if((!n)&&(!strcmp(arg,"-n"))){
n=atoi(argv[2]);
i=3;
}
if(!n){ printf("Illegal option: %s", argv[1]);
return 1;
}
}else{
n=10;
i=1;
}
// loop for files
for (;i<argc;i++){
errno=0;
mark=0;
arg=argv[i];
if(!strcmp(argv[i],"-")){
fd=0;
mark=1;
}else{
dir=opendir(argv[i]);
f=fopen(argv[i],"r");
if (f){fd=fileno(f);
}

}
 if ((errno==20)||(mark)){

 write(1,header,strlen(header));
  write(1,argv[i],strlen(argv[i]));
   write(1,footer,strlen(footer));

 print_file(fd, n);
 if(f){
fclose(f);}
 }else{
 print_err_info(errno, arg);
 }
}
    return 0;
}

void print_file(const int fd, const int count){
int j=0;
int m=0;
char * buf= (char*) malloc(sizeof(char));
printf("%d", count);
while (j<count){
m=read(fd, buf, 1 );

if (*buf=='\n'){j++;}
write(1, buf, 1);
if(!m)break;
}

}
 //errno
void print_err_info(int err, const char * str){
char * direct = " : is a directory";
char * nofile = " : No such file";
char * pd = " : Permission denied";
char * tlg  = " : Name is too long";
write(1, str, strlen(str));
switch(err){
case 0: write (1,direct,strlen(direct)); break;
case 2: write (1,nofile,strlen(nofile)); break;
case 13: write (1,pd,strlen(pd)); break;
case 36: write (1,tlg,strlen(tlg)); break;
}

}
