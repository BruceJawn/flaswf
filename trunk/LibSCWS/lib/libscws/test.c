#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main()
{
/*char s1[10] = "abcd";
char s2[10] = "ABCDEF";
printf("s1 = %s\ns2 = %s\n",s1,s2);
strncpy(s1,s2,3);
printf("s1 = %s\ns2 = %s\n",s1,s2);
*/
char result[300]={0};
char text[1000]="哈苏打撒旦as\0";
char temp[100];
strncpy(temp, text, 4);
strcat(result,temp);
//strcat(result, ' ');
strncpy(temp, text+6, 4);
strcat(result,temp);
printf(" %s",result);
printf(" %s",text);

char *temp1="哈苏旦";
char *temp2="打撒";
char *str;

str = (char*) malloc(strlen(temp1)+1);
snprintf(str, strlen(temp1), temp1);
str = (char*) realloc(str, strlen(str)+strlen(temp2)+1);
snprintf(str+strlen(temp2), strlen(temp2), temp2);
printf("%s", str);

return 0;
}