//����������ڴ�, ȫ��Ϊ�ṹ������
//local vars �ֲ����� delete!
//��������int, float, string
//����ͨ��������ʵ��: ������+index
//�Ĵ���int����ʱ����3��, ���ڴ����м����, ��������, �������η�ֵ��  
int loc_int[3];
//�Ĵ���float����ʱ����3��, ���ڴ����м����, ��������, �������η�ֵ��  
float loc_flt[3];
//unsigned char loc_uchar[3];//�þ���unsigned char* loc_uchar[3];����û̫����
//�Ĵ���char����ʱ����3��, ���ڴ����м����, ��������, �������η�ֵ�� 
unsigned char* loc_str[3];
//�Ĵ���char����ʱ��������
int loc_str_l[3];
//label�ṹ��
struct Label 
{
  unsigned char* name;//label����, ���ڱ��label��������ת
  int length;//label����
  unsigned char* CodeBuffer;//label����
  //unsigned char CodeBuffer[];
};
struct Label **labels= NULL;//labels: �ڴ�����, ���������е�label
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
int labels_num=0;//���е�label����=lengthof(labels)

//Int�ṹ��
struct Int
{
  unsigned char* name;//��������, ���ڱ�������
  int name_length;//for what? for swap!(when swap, you need to copy name, must know length)
  int value;//������ֵ
};
struct Int **ints= NULL;//ints: �ڴ�����, ���������е�int�ͱ���
int ints_num=0;//���е�int��������=lengthof(ints)

//Float�ṹ��
struct Float
{
  unsigned char* name;//��������, ���ڱ�������
  int name_length;
  float value;//������ֵ
};
struct Float **floats= NULL;//floats: �ڴ�����, ���������е�int�ͱ���
int floats_num=0;//���е�floats��������=lengthof(floats)

//Char�ṹ��, ����һ���ַ���
struct Char
{
  unsigned char* name;//��������, ���ڱ�������
  int name_length;
  int length;//�ַ����ĳ���
  char* value;//�ַ�����ֵ
};
struct Char **chars= NULL;//chars: �ڴ�����, ���������е�char�ͱ���
int chars_num=0;//���е�char��������=lengthof(chars)
