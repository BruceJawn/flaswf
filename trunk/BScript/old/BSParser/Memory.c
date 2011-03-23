//虚拟机虚拟内存, 全部为结构体数组
//local vars 局部变量 delete!
//变量类型int, float, string
//数组通过变量名实现: 变量名+index
//寄存器int型临时变量3个, 用于储存中间变量, 变量交换, 函数传参返值等  
int loc_int[3];
//寄存器float型临时变量3个, 用于储存中间变量, 变量交换, 函数传参返值等  
float loc_flt[3];
//unsigned char loc_uchar[3];//用就用unsigned char* loc_uchar[3];好像没太有用
//寄存器char型临时变量3个, 用于储存中间变量, 变量交换, 函数传参返值等 
unsigned char* loc_str[3];
//寄存器char型临时变量长度
int loc_str_l[3];
//label结构体
struct Label 
{
  unsigned char* name;//label名称, 用于标记label以用于跳转
  int length;//label长度
  unsigned char* CodeBuffer;//label代码
  //unsigned char CodeBuffer[];
};
struct Label **labels= NULL;//labels: 内存数组, 保存了所有的label
//struct Label labels[10];
//struct Label* labels;

/*
  typedef struct 
  {
  char name[8];
  int length;
  unsigned char CodeBuffer[];
  }Label,*PLabel,**PPLabel;
  PLabel labels;
*/
int labels_num=0;//所有的label个数=lengthof(labels)

//Int结构体
struct Int
{
  unsigned char* name;//变量名称, 用于变量引用
  int name_length;//for what? for swap!(when swap, you need to copy name, must know length)
  int value;//变量的值
};
struct Int **ints= NULL;//ints: 内存数组, 保存了所有的int型变量
int ints_num=0;//所有的int变量个数=lengthof(ints)

//Float结构体
struct Float
{
  unsigned char* name;//变量名称, 用于变量引用
  int name_length;
  float value;//变量的值
};
struct Float **floats= NULL;//floats: 内存数组, 保存了所有的int型变量
int floats_num=0;//所有的floats变量个数=lengthof(floats)

//Char结构体, 代表一个字符串
struct Char
{
  unsigned char* name;//变量名称, 用于变量引用
  int name_length;
  int length;//字符串的长度
  char* value;//字符串的值
};
struct Char **chars= NULL;//chars: 内存数组, 保存了所有的char型变量
int chars_num=0;//所有的char变量个数=lengthof(chars)
