/*
Author: Anonymous
License: Public Domain?
[Dear author, please kindly contact play@flaswf.tk for your credit here.]
*/
#include<iostream>
#include<time.h>
#include<cstdlib>
#include<stdio.h>
using namespace std;
struct pai
{
	int paifu;
	int huase;
	int yanse;
	int dianshu;
	int leixing;
	int changdu;
	void Kanpai()
	{
		if(paifu==0||paifu==1);
		else
			printf("牌副参数错误！\n");
		switch(huase)
		{
		case 0:cout<<"黑桃";break;
		case 1:cout<<"红桃";break;
		case 2:cout<<"草花";break;
		case 3:cout<<"方片";break;
		case -1:cout<<"无色";break;
		default:printf("花色错误！\n");break;
		}  
		switch(dianshu) 
		{  
		case 0:cout<<"A  ";break; 
		case 1:cout<<"2  ";break; 
		case 2:cout<<"3  ";break; 
		case 3:cout<<"4  ";break; 
		case 4:cout<<"5  ";break; 
		case 5:cout<<"6  ";break; 
		case 6:cout<<"7  ";break; 
		case 7:cout<<"8  ";break;   
		case 8:cout<<"9  ";break; 
		case 9:cout<<"10 ";break; 
		case 10:cout<<"J  ";break; 
		case 11:cout<<"Q  ";break; 
		case 12:cout<<"K  ";break;
		case -1:cout<<"无点数";break;
		default:printf("点数错误！\n");break; 
		}
		switch(leixing)
		{
		case 101:cout<<"【杀】"<<endl;break;
		case 102:cout<<"【闪】"<<endl;break;
		case 103:cout<<"【桃】"<<endl;break;
		case 201:cout<<"【过河拆桥】"<<endl;break;
		case 202:cout<<"【顺手牵羊】"<<endl;break;
		case 203:cout<<"【无中生有】"<<endl;break;
		case 204:cout<<"【决斗】"<<endl;break;
		case 205:cout<<"【借刀杀人】"<<endl;break;
		case 206:cout<<"【桃园结义】"<<endl;break;
		case 207:cout<<"【五谷丰登】"<<endl;break;
		case 208:cout<<"【南蛮入侵】"<<endl;break;
		case 209:cout<<"【万箭齐发】"<<endl;break;
		case 210:cout<<"【无懈可击】"<<endl;break;
		case 251:cout<<"【乐不思蜀】"<<endl;break;
		case 252:cout<<"【闪电】"<<endl;break;
		case 301:cout<<"【诸葛连弩(1)】"<<endl;break;
		case 302:cout<<"【雌雄双股剑(2)】"<<endl;break;
		case 303:cout<<"【青釭剑(2)】"<<endl;break;
		case 304:cout<<"【青龙偃月刀(3)】"<<endl;break;
		case 305:cout<<"【丈八蛇矛(3)】"<<endl;break;
		case 306:cout<<"【贯石斧(3)】"<<endl;break;
		case 307:cout<<"【方天画戟(4)】"<<endl;break;
		case 308:cout<<"【麒麟弓(5)】"<<endl;break;
		case 331:cout<<"【八卦阵】"<<endl;break;
		case 361:cout<<"【赤兔(-1)】"<<endl;break;
		case 362:cout<<"【大宛(-1)】"<<endl;break;
		case 363:cout<<"【紫辛(-1)】"<<endl;break;
		case 381:cout<<"【爪黄飞电(+1)】"<<endl;break;
		case 382:cout<<"【的卢(+1)】"<<endl;break;
		case 383:cout<<"【绝影(+1)】"<<endl;break;
		default:printf("类型参数错误！");break;
		}
	}
};
int S()
{
	char a[100];
	for(;;)
	{
		for(int i=0;i<=99;i++)a[i]=NULL;
		cin>>a;
		if((a[0]>='0')&&(a[0]<='9')&&(a[1]==NULL))return (a[0]-48);
		else if((a[0]>='0')&&(a[0]<='9')&&(a[1]>='0')&&(a[1]<='9'))return (10*(a[0]-48)+a[1]-48);
		else return -1;
	}
}
void Qishixipai(pai A[2][4][13],pai paidui[104])
{
	int i,m,x,y,z,a[104]={0};
	srand((unsigned)time(NULL));
	for(i=1;i<=104;i++)
	{  
		while(a[m=rand()%104]);
		a[m]=i;
	}
	for(i=0;i<=103;i++)
	{
		x=(a[i]-1)/52;
		y=((a[i]-1)-52*x)/13;
		z=(a[i]-1)%13;
		paidui[i]=A[x][y][z];
	}
}
void Xipai(pai paidui[104],int*paiduishu,pai qipaidui[104],int*qipaishu)
{
	int i,m,a[104]={0};
	srand((unsigned)time(NULL));
	for(i=1;i<=(*qipaishu);i++)
	{
		while(a[m=rand()%(*qipaishu)]);
		a[m]=i;
	}
	for(i=0;(*qipaishu)>0;i++)
	{
		paidui[i]=qipaidui[a[i]];
		qipaidui[a[i]].leixing=-1;
		(*paiduishu)++;
		(*qipaishu)--;
	}
	for(i=(*paiduishu);i<=103;i++)paidui[i].leixing=-1;
}
pai Mo1pai(pai A[104],int *x,pai B[104],int*y,int *b)
{
	pai p;
	if((*x)==0)Xipai(A,x,B,y);
	else if((*x)<0)printf("摸牌参数错误！");
	else;
	p=A[104-(*x)];
	(*x)--; 
	(*b)++;
	return(p);
}
struct wujiang
{
	char name;
	int tili;
	int tilishangxian;
	int shoupaishangxian;
	int huihekaishi;
	int panding;
	int mopai;
	int chupai;
	int qipai;
	int huihejieshu;
	int juese;
	pai shoupai[20];
	int shoupaishu;
	pai zhuangbei[4];
	int zhuangbeishu;
	pai pandingpai[3];
	int pandingshu;
	int juli[1];
	void Kanshoupai()
	{
		printf("玩家当前手牌：\n");
		if(shoupaishu)
		{
			int m;
			for(m=0;m<=(shoupaishu-1);m++)
			{
				printf("%d        ",m);
				(shoupai[m]).Kanpai();
			}
		}
		else printf("空城！\n");
		printf("\n");
	}
	void Kanzhuangbei()
	{
		if(juese)printf("玩家");
		else printf("电脑");
		printf("当前装备：\n");
		printf("0 武器：     ");
		if((zhuangbei[0]).leixing==-1)printf("空\n");
		else (zhuangbei[0]).Kanpai();
		printf("1 防具：     ");
		if((zhuangbei[1]).leixing==-1)printf("空\n");
		else (zhuangbei[1]).Kanpai();
		printf("2 进攻马：   ");
		if((zhuangbei[2]).leixing==-1)printf("空\n");
		else (zhuangbei[2]).Kanpai();
		printf("3 防御马：   ");
		if((zhuangbei[3]).leixing==-1)printf("空\n");
		else (zhuangbei[3]).Kanpai();
		printf("\n");
	}
	void Kanpandingpai()
	{
		if(juese)printf("玩家");
		else printf("电脑");
		printf("当前判定区：\n");
		if((pandingpai[0]).leixing==-1)printf("空\n");
		else
		{
			printf("0        ");
			(pandingpai[0]).Kanpai();
			if((pandingpai[1]).leixing==-1);
			else
			{
				printf("1        ");
				(pandingpai[1]).Kanpai();
				if((pandingpai[2]).leixing==-1);
				else
				{
					printf("2        ");
					(pandingpai[2]).Kanpai();
				}
			}
		}
	}
};
void Mopai(int*shoupaishu,pai shoupai[20],pai A[104],int *x,pai B[104],int*y,int juese)
{
	if(juese)printf("玩家从牌堆摸2张牌\n");
	else printf("电脑从牌堆摸2张牌\n");
	pai p;
	p=Mo1pai(A,x,B,y,shoupaishu);
	shoupai[*shoupaishu-1]=p;
	pai q;
	q=Mo1pai(A,x,B,y,shoupaishu);
	shoupai[*shoupaishu-1]=q;
	int m;
	if(juese)
	{
		printf("玩家当前手牌：\n");
		for(m=0;m<=(*shoupaishu-1);m++)
		{
			printf("%d        ",m);
			(shoupai[m]).Kanpai();
		}
	}
	printf("牌堆还剩%d张牌！\n\n",*x);
}
void Qishishoupai(wujiang *w,pai A[104],int *x,pai B[104],int*y)
{
	pai a;
	a=Mo1pai(A,x,B,y,&((*w).shoupaishu));
	(*w).shoupai[(*w).shoupaishu-1]=a;
	pai b;
	b=Mo1pai(A,x,B,y,&((*w).shoupaishu));
	(*w).shoupai[(*w).shoupaishu-1]=b;
	pai c;
	c=Mo1pai(A,x,B,y,&((*w).shoupaishu));
	(*w).shoupai[(*w).shoupaishu-1]=c;
	pai d;
	d=Mo1pai(A,x,B,y,&((*w).shoupaishu));
	(*w).shoupai[(*w).shoupaishu-1]=d;
	int m;
	if((*w).juese)printf("玩家从牌堆摸4张牌\n");
	else printf("电脑从牌堆摸4张牌\n");
	if((*w).juese)
	{
		printf("玩家当前手牌：\n");
		for(m=0;m<=((*w).shoupaishu-1);m++)
		{
			printf("%d        ",m);
			((*w).shoupai[m]).Kanpai();
		}
	}
	printf("牌堆还剩%d张牌！\n\n",*x);
}
void Panding(pai paidui[104],int*paiduishu,pai qipaidui[104],int*qipaishu)
{
	paidui[*paiduishu].Kanpai();
	qipaidui[*qipaishu]=paidui[*paiduishu];
	(*paiduishu)--;
	(*qipaishu)++;
}
pai Zhangba(wujiang*w,pai qipaidui[104],int*qipaishu)
{
	int x,y;
	pai p;
	for(;;)
	{
		int i,j;
		printf("请输入任意两张手牌之前的编号，以空格隔开，以回车结束！\n");
		x=S();
		y=S();
		if((x>=0)&&(x<(*w).shoupaishu)&&(y>=0)&&(y<(*w).shoupaishu-1))
		{
			switch((((*w).shoupai[x].huase)%2)+(((*w).shoupai[y].huase)%2))
			{
			case 0:p.yanse=0;break;
			case 2:p.yanse=1;break;
			case 1:p.yanse=2;break;
			default:printf("【丈八蛇矛】函数参数错误！\n");
			}
			qipaidui[*qipaishu]=(*w).shoupai[x];
			(*w).shoupai[x].leixing=-1;
			((*w).shoupaishu)--;
			(*qipaishu)++;
			qipaidui[*qipaishu]=(*w).shoupai[y];
			(*w).shoupai[y].leixing=-1;
			((*w).shoupaishu)--;
			(*qipaishu)++;
			for(i=0;i<=(((*w).shoupaishu)+1);i++)
			{
				if((*w).shoupai[i].leixing==-1)
				{
					for(j=i+1;j<=(((*w).shoupaishu)+2);j++)
						(*w).shoupai[j-1]=(*w).shoupai[j];
					i--;
				}
			}
			printf("玩家把：\n");
			qipaidui[(*qipaishu)-2].Kanpai();
			qipaidui[(*qipaishu)-1].Kanpai();
			printf("当作一张");
			switch(p.yanse)
			{
			case 0:printf("黑色");break;
			case 2:printf("红色");break;
			case 1:printf("无色");break;
			default:printf("绿色");break;
			}
			printf("无点数的【杀】");
			p.dianshu=-1;
			p.leixing=101;
			return p;
			break;
		}
		printf("你将两张空气当作一张空气属性的【杀】使用或打出！\n");
	}
}
int Xuanpai(wujiang*w,int t)
{
	int x;
	if((*w).juese)
	{
		for(;;)
		{
			printf("出牌请输入手牌之前的编号，以回车结束！\n如果你想结束出牌阶段，请输入任意非数字字符，以回车结束！\n");
			x=S();
			if((x>=-1&&x<((*w).shoupaishu))||((x==100)&&((*w).zhuangbei[0].leixing==305)))
			{
				return x;
				break;
			}
			printf("你打出了一张空气！\n");
		}
	}
	else return t;
}
pai Panpai(wujiang*w1,int*sha,int y,pai qipaidui[104],int*qipaishu)
{
	pai p,q;
	p.leixing=0;
	q.leixing=-1;
	if(y==-1)return q;
	else
	{
		if(y==100)
		{
			if((*sha)>0)
			{
				q=Zhangba(w1,qipaidui,qipaishu);
				printf("使用！\n");
				return q;
			}
			else
			{
				printf("当前回合使用【杀】的次数已用尽，你也不能使用【丈八蛇矛】效果！\n");
				return p;
			}
		}
		switch((*w1).shoupai[y].leixing)
		{
		case 101:
			if(((*sha)>0)||((*w1).zhuangbei[0].leixing==301))
			{
				if(((*w1).zhuangbei[0].leixing==301))printf("武器【诸葛连弩】效果被触发！\n");
				return (*w1).shoupai[y];
				break;
			}
			else
			{
				if((*w1).juese)printf("当前回合使用【杀】的次数已用尽，你不能使用【杀】！\n");
				return p;break;
			}
		case 102:
			if((*w1).juese)
				printf("当前不需要响应任何操作，你不能主动打出【闪】！\n");
			return p;break;
		case 103:
			if(((*w1).tili)<((*w1).tilishangxian))
			{
				return (*w1).shoupai[y];
				break;
			}
			else
			{
				if((*w1).juese)
					printf("你并未受伤，不能对自己使用【桃】！\n");
			}
			return p;break;
		case 210:
			if((*w1).juese)
				printf("当前不需要响应任何锦囊，你不能主动打出【无懈可击】！\n");
			return p;break;
		case 201:
		case 202:
		case 203:
		case 204:
		case 205:
		case 206:
		case 207:
		case 208:
		case 209:
		case 251:
		case 252:
		case 301:
		case 302:
		case 303:
		case 304:
		case 305:
		case 306:
		case 307:
		case 308:
		case 331:
		case 361:
		case 362:
		case 363:
		case 381:
		case 382:
		case 383:return (*w1).shoupai[y];break;
		default:printf("手牌类型参数错误！\n");return p;break;
		}
	}
}
int Mubiao(pai p,wujiang *w1,wujiang *w2,int*sha)
{
	int x;
	switch(p.leixing)
	{
	case 101:
		if((*w1).juese)
		{
			printf("请选择【杀】的目标！\n输入目标前的编号，以回车结束！\n0       电脑1\n");
			x=S();
			if(x==0)
			{
				if((*w1).zhuangbei[0].changdu>=(*w1).juli[0])
				{
					(*sha)--;
					return((*w2).juese);
				}
				else
				{
					printf("武器长度不够！\n");
					return -2;
				}
			}
			else 
			{
				printf("目标错误！\n");
				return -2;
			}
		}
		else
		{
			if((*w1).zhuangbei[0].changdu>=(*w1).juli[0])
			{
				(*sha)--;
				return((*w2).juese);
			}
			else return -2;
		}
		break;
	case 103:return((*w1).juese);break;
	case 201:
		if((*w1).juese)
		{
			printf("请选择【过河拆桥】的目标！\n输入目标前的编号，以回车结束！\n0       电脑1\n");
			x=S();
			if(x==0)
			{
				if((*w2).shoupaishu||(*w2).zhuangbeishu||(*w2).pandingshu)return((*w2).juese);
				else
				{
					printf("目标没有牌！\n");
					return -2;
				}
			}
			else
			{
				printf("目标错误！\n");
				return -2;
			}
		}
		else return((*w2).juese);
		break;
	case 202:
		if((*w1).juese)
		{
			printf("请选择【顺手牵羊】的目标！\n输入目标前的编号，以回车结束！\n0       电脑1\n");
			x=S();
			if(x==0)
			{
				if(((*w2).shoupaishu||(*w2).zhuangbeishu||(*w2).pandingshu)&&((*w1).juli[0]<=1))return((*w2).juese);
				else
				{
					printf("目标错误！\n");
					return -2;
				}
			}
			else
			{
				printf("目标错误！\n");
				return -2;
			}
		}
		else
		{
			if((*w1).juli[0]<=1)return((*w2).juese);
			else return -2;
		}
		break;
	case 203:
		return((*w1).juese);break;
	case 204:
		if((*w1).juese)
		{
			printf("请选择【决斗】的目标！\n输入目标前的编号，以回车结束！\n0       电脑1\n");
			x=S();
			if(x==0)return((*w2).juese);
			else
			{
				printf("目标错误！\n");
				return -2;
			}
		}
		else return((*w2).juese);
		break;
	case 205:
		int y;
		if((*w1).juese)
		{
			printf("请选择【借刀杀人】的目标！\n输入目标前的编号，以回车结束！\n0       电脑1\n");
			x=S();
			if(x!=0)
			{
				printf("目标错误！\n");
				return -2;
			}
			else
			{
				if(((*w2).zhuangbei[0]).leixing<=300||((*w2).zhuangbei[0]).leixing>=331)
				{
					printf("目标装备区里没有武器！\n");
					return -2;
				}
				else
				{
					printf("请选择【杀】的目标！\n提示：【杀】的目标必须在【借刀杀人】的目标的攻击范围之内！\n输入目标前的编号， 以回车结束！\n0       玩家\n");
					y=S();
					if(y!=0)
					{
						printf("目标错误！\n");
						return -2;
					}
					else
					{
						if(((*w2).zhuangbei[0].changdu)<(*w2).juli[0])
						{
							printf("武器距离不够！\n");
							return -2;
						}
						else
							return((*w2).juese);
					}
				}
			}
		}
		else
		{
			if(((*w2).zhuangbei[0]).leixing<=300||((*w2).zhuangbei[0]).leixing>=331)return -2;
			else
			{
				if(((*w2).zhuangbei[0].changdu)<(*w2).juli[0])return -2;
				else return((*w2).juese);
			}
		}
		break;
	case 206:
	case 207:return 99;break;
	case 208:
	case 209:return 100;break;
	case 251:
		if((*w1).juese)
		{
			printf("请选择【乐不思蜀】的目标！\n输入目标前的编号，以回车结束！\n0       电脑1\n");
			x=S();
			if(x==0)
			{
				int i;
				for(i=0;i<=2;i++)
				{
					if((*w2).pandingpai[i].leixing==251)
						i=-1;
					break;
				}
				if(i==-1)
				{
					printf("目标判定区里不能同时存在两张相同的延时类锦囊！\n");
					return -2;
				}
				else return((*w2).juese);
			}
			else
			{
				printf("目标错误！\n");
				return -2;
			}
		}
		else
		{
			int i;
			for(i=0;i<=2;i++)
			{
				if((*w2).pandingpai[i].leixing==251)
					i=-1;
				break;
			}
			if(i==-1)return -2;
			else return((*w2).juese);
		}
		break;
	case 252:
		int i;
		for(i=0;i<=2;i++)
		{
			if((*w1).pandingpai[i].leixing==252)
				i=-1;
			break;
		}
		if(i==-1)
		{
			if((*w1).juese)printf("目标判定区里不能同时存在两张相同的延时类锦囊！\n");
			return -2;
		}
		else return ((*w1).juese);
		break;
	case 301:
	case 302:
	case 303:
	case 304:
	case 305:
	case 306:
	case 307:
	case 308:
	case 331:
	case 361:
	case 362:
	case 363:
	case 381:
	case 382:
	case 383:return((*w1).juese);break;
	default:return -2;break;
	}
}
void Da1pai(wujiang *w1,wujiang*w2,pai qipaidui[104],int *qipaishu,int x)
{
	int i;
	if((x<0||x>=((*w1).shoupaishu))&&x!=100)
		printf("你的牌呢？！\n");
	else
	{ 
		switch(((*w1).shoupai)[x].leixing)
		{
		case 101:
		case 102:
		case 103:
		case 201:
		case 202:
		case 203:
		case 204:
		case 205:
		case 206:
		case 207:
		case 208:
		case 209:
		case 210:
			qipaidui[*qipaishu]=((*w1).shoupai)[x];
			for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
			((*w1).shoupaishu)--;
			(*qipaishu)++;
			break;
		case 251:
			for(i=1;i>=0;i--)(*w2).pandingpai[i+1]=(*w2).pandingpai[i];
			(*w2).pandingpai[0]=(*w1).shoupai[x];
			for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
			((*w1).shoupaishu)--;
			((*w2).pandingshu)++;
			break;
		case 252:
			for(i=1;i>=0;i--)(*w1).pandingpai[i+1]=(*w1).pandingpai[i];
			(*w1).pandingpai[0]=(*w1).shoupai[x];
			for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
			((*w1).shoupaishu)--;
			((*w1).pandingshu)++;
			break;
		case 301:
		case 302:
		case 303:
		case 304:
		case 305:
		case 306:
		case 307:
		case 308:
			if((*w1).zhuangbei[0].leixing==-1)((*w1).zhuangbeishu)++;
			else
			{
				qipaidui[*qipaishu]=((*w1).zhuangbei)[0];
				(*qipaishu)++;
			}
			(*w1).zhuangbei[0]=(*w1).shoupai[x];
			for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
			((*w1).shoupaishu)--;
			break;
		case 331:
			if((*w1).zhuangbei[1].leixing==-1)((*w1).zhuangbeishu)++;
			else
			{
				qipaidui[*qipaishu]=((*w1).zhuangbei)[1];
				(*qipaishu)++;
			}
			(*w1).zhuangbei[1]=(*w1).shoupai[x];
			for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
			((*w1).shoupaishu)--;
			break;
		case 361:
		case 362:
		case 363:
			if((*w1).zhuangbei[2].leixing==-1)((*w1).zhuangbeishu)++;
			else
			{
				qipaidui[*qipaishu]=((*w1).zhuangbei)[2];
				((*w1).juli[0])++;
				(*qipaishu)++;
			}
			(*w1).zhuangbei[2]=(*w1).shoupai[x];
			for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
			((*w1).shoupaishu)--;
			break;
		case 381:
		case 382:
		case 383:
			if((*w1).zhuangbei[3].leixing==-1)((*w1).zhuangbeishu)++;
			else
			{
				qipaidui[*qipaishu]=((*w1).zhuangbei)[3];
				((*w1).juli[0])--;
				(*qipaishu)++;
			}
			(*w1).zhuangbei[3]=(*w1).shoupai[x];
			for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
			((*w1).shoupaishu)--;
			break;
		default:break;
		}
	}
}
void Miaoshu(pai p,int juese,int duixiang)
{
	if(juese==0)printf("电脑");
	else if(juese==1)printf("玩家");
	else printf("角色参数错误！\n");
	if(p.leixing<=300&&p.leixing>100)
	{
		switch(duixiang)
		{
		case -1:printf("打出");break;
		case 0:printf("对电脑使用");break;
		case 1:printf("对玩家使用");break;
		case 99:printf("使用");break;
		case 100:printf("对所有人使用");break;
		default:printf("对象参数错误\n");break;
		}
	}
	else if(p.leixing>=301&&p.leixing<=400)
		printf("装备");
	else printf("你出的是什么东西？\n");
	p.Kanpai();
	if(!juese&& (p.leixing==101||p.leixing==204||p.leixing==205||p.leixing==207||p.leixing==208||p.leixing==209))printf(" 请响应！\n");
}
int Wuxie(pai *p,wujiang*w1,wujiang*w2,pai qipaidui[104],int*qipaishu,int a)
{
	int x;
	if((*w1).juese)
	{
		printf("是否使用【无懈可击】响应？\n\n");
		for(;;)
		{
			(*w1).Kanshoupai();
			printf("如果要使用【无懈可击】请输入手牌之前编号，不需要请输入任意非数字字符，以回车结束！\n");
			x=S();
			if(x==-1)
			{
				for(x=0;x<((*w2).shoupaishu);x++)
				{
					if((*w2).shoupai[x].leixing==210)
					{
						printf("电脑使用");
						((*w2).shoupai)[x].Kanpai();
						printf("对象是");
						(*p).Kanpai();
						(*p)=((*w2).shoupai)[x];
						qipaidui[*qipaishu]=((*w2).shoupai)[x];
						for(int i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
						((*w2).shoupaishu)--;
						(*qipaishu)++;
						a++;
						break;
					}
				}
				break;
			}
			else if((*w1).shoupai[x].leixing==210)
			{
				printf("玩家使用");
				((*w1).shoupai)[x].Kanpai();
				printf("对象是");
				(*p).Kanpai();
				(*p)=((*w1).shoupai)[x];
				qipaidui[*qipaishu]=((*w1).shoupai)[x];
				for(int i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
				((*w1).shoupaishu)--;
				(*qipaishu)++;
				(*w1).Kanshoupai();
				a++;
				break;
			}
			else printf("你确定你使用的是【无懈可击】？\n");
		}
	}
	else
	{
		printf("是否使用【无懈可击】响应？\n");
		for(;;)
		{
			(*w2).Kanshoupai();
			printf("如果要使用【无懈可击】请输入手牌之前编号，不需要请输入任意非数字字符，以回车结束！\n");
			x=S();
			if(x==-1)break;
			else if((*w2).shoupai[x].leixing==210)
			{
				printf("玩家使用");
				((*w2).shoupai)[x].Kanpai();
				printf("对象是");
				(*p).Kanpai();
				(*p)=((*w2).shoupai)[x];
				qipaidui[*qipaishu]=((*w2).shoupai)[x];
				for(int i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
				((*w2).shoupaishu)--;
				(*qipaishu)++;
				(*w2).Kanshoupai();
				a++;
				break;
			}
			else printf("你确定你使用的是【无懈可击】？\n");
		}
	}
	return a;
}
int Qiutao(wujiang*w,pai qipaidui[104],int*qipaishu)
{
	int x;
	if((*w).juese)
	{
		for(;;)
		{
			printf("如果要使用【桃】请输入手牌之前的编号，不需要请输入任意非数字字符，以回车结束！\n");
			x=S();
			if(x==-1)
			{
				return -1;
				break;
			}
			else if((*w).shoupai[x].leixing==103)
			{
				qipaidui[*qipaishu]=((*w).shoupai)[x];
				for(int i=x+1;i<=((*w).shoupaishu);i++)((*w).shoupai)[i-1]=((*w).shoupai)[i];
				((*w).shoupaishu)--;
				(*qipaishu)++;
				return 0;
				break;
			}
			else printf("你确定你使用的是【桃】？\n");
		}
	}
	else
	{
		for(x=0;x<((*w).shoupaishu);x++)
		{
			if((*w).shoupai[x].leixing==103)
			{
				qipaidui[*qipaishu]=((*w).shoupai)[x];
				for(int i=x+1;i<=((*w).shoupaishu);i++)((*w).shoupai)[i-1]=((*w).shoupai)[i];
				((*w).shoupaishu)--;
				(*qipaishu)++;
				return 0;
				break;
			}
		}
		return -1;
	}
}
int Binsi(wujiang*w1,wujiang*w2,pai qipaidui[104],int*qipaishu)
{
	if(((*w2).tili)>0)return 0;
	else
	{
		int i;
		if((*w1).juese)
		{
			for(;;)
			{
				printf("电脑濒死，是否使用【桃】？\n");
				i=Qiutao(w1,qipaidui,qipaishu);
				if(i==0)((*w2).tili)++;
				if((i==-1)||((*w2).tili>0))break;
			}
			if((*w2).tili>0)return 0;
			else
			{
				for(;;)
				{
					i=Qiutao(w2,qipaidui,qipaishu);
					if(i==0)((*w2).tili)++;
					if((i==-1)||((*w2).tili>0))break;
				}
				if((*w2).tili>0)return 0;
				else return -1;
			}
		}
		else
		{
			for(;;)
			{
				printf("玩家濒死，是否使用【桃】？\n");
				i=Qiutao(w2,qipaidui,qipaishu);
				if(i==0)((*w2).tili)++;
				if((i==-1)||((*w2).tili>0))break;
			}
			if((*w2).tili>0)return 0;
			else return -1;
		}
	}
}
int Shan(wujiang*w1,wujiang*w2,pai paidui[104],int*paiduishu,pai qipaidui[104],int*qipaishu)
{
	int x;
	if((*w2).juese)
	{
		if(((*w2).zhuangbei[1].leixing==331)&&((*w1).zhuangbei[0].leixing!=303))
		{
			for(;;)
			{
				int m;
				printf(" 是否发动【八卦阵】防具效果？\n0        否\n1        是\n请输入选项之前的编号，以回车结束！\n");
				m=S();
				if(m==1)
				{
					Panding(paidui,paiduishu,qipaidui,qipaishu);
					if(qipaidui[(*qipaishu)-1].huase%2)
					{
						printf("【八卦阵】判定成功！\n");
						return 0;
					}
					else
					{
						printf("【八卦阵】判定失败！\n");
						break;
					}
				}
				else if(m==0)break;
				else printf("你确定你输入的是“0”或“1”？\n");
			}
		}
		else if(((*w2).zhuangbei[1].leixing==331)&&((*w1).zhuangbei[0].leixing==303))printf("【青釭剑】锁定技被触发！\n");
		for(;;)
		{
			printf("请输入手牌之前的编号，或者输入任意非数字字符放弃打出【闪】，以回车结束！\n");
			x=S();
			if(x==-1)
			{
				return -1;
				break;
			}
			else if((*w2).shoupai[x].leixing==102)
			{
				printf("玩家打出");
				((*w2).shoupai)[x].Kanpai();
				qipaidui[*qipaishu]=((*w2).shoupai)[x];
				for(int i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
				((*w2).shoupaishu)--;
				(*qipaishu)++;
				return 0;
				break;
			}
			else printf("你确定你打出的是【闪】？\n");
		}
	}
	else
	{
		if(((*w2).zhuangbei[1].leixing==331)&&((*w1).zhuangbei[0].leixing!=303))
		{
			Panding(paidui,paiduishu,qipaidui,qipaishu);
			if(qipaidui[(*qipaishu)-1].huase%2)
			{
				printf("【八卦阵】判定成功！\n");
				return 0;
			}
			else printf("【八卦阵】判定失败！\n");
		}
		else if(((*w2).zhuangbei[1].leixing==331)&&((*w1).zhuangbei[0].leixing==303))printf("【青釭剑】锁定技被触发！\n");
		int i;
		for(x=0;x<((*w2).shoupaishu);x++)
		{
			if((*w2).shoupai[x].leixing==102)
			{
				printf("电脑打出");
				((*w2).shoupai)[x].Kanpai();
				qipaidui[*qipaishu]=((*w2).shoupai)[x];
				for(i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
				((*w2).shoupaishu)--;
				(*qipaishu)++;
				return 0;
				break;
			}
		}
		return -1;
	}
}
int Sha(wujiang *w1,wujiang*w2,pai paidui[104],int*paiduishu,pai qipaidui[104],int*qipaishu)
{
	int x;                                                                                              printf("距离：%d\n",(*w1).juli[0]);
	if((*w2).juese)
	{
		printf("请打出【闪】响应【杀】！否则你将受到1点伤害！\n");
		x=Shan(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
		if(x==-1)
		{
			int i;
			((*w2).tili)--;
			printf("电脑对玩家造成1点伤害！\n");
			i=Binsi(w1,w2,qipaidui,qipaishu);
			return i;
		}
		else if(x==0&&((*w1).zhuangbei[0].leixing==306))
		{
			int i;
			if(((*w1).shoupaishu)>=2)
			{
				printf("电脑弃掉：\n");
				((*w1).shoupai)[0].Kanpai();
				qipaidui[*qipaishu]=((*w1).shoupai)[0];
				for(i=1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
				((*w1).shoupaishu)--;
				(*qipaishu)++;
				((*w1).shoupai)[0].Kanpai();
				qipaidui[*qipaishu]=((*w1).shoupai)[0];
				for(i=1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
				((*w1).shoupaishu)--;
				(*qipaishu)++;
				printf("发动【贯石斧】武器效果使【杀】造成伤害！\n");
				((*w2).tili)--;
				i=Binsi(w1,w2,qipaidui,qipaishu);
				return i;
			}
			else return 0;
		}
		else if(x==0&&((*w1).zhuangbei[0].leixing==304))
		{
			int i;
			for(x=0;x<((*w1).shoupaishu);x++)
			{
				if((*w1).shoupai[x].leixing==101)
				{
					printf("电脑发动【青龙偃月刀】效果对玩家使用");
					((*w1).shoupai)[x].Kanpai();
					qipaidui[*qipaishu]=((*w1).shoupai)[x];
					for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
					((*w1).shoupaishu)--;
					(*qipaishu)++;
					i=Sha(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
					return i;
					break;
				}
			}
			return 0;
		}
	}
	else
	{
		x=Shan(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
		if(x==-1)
		{
			if((*w1).zhuangbei[0].leixing==308)
			{
				for(;;)
				{
					printf(" 是否发动【麒麟弓】武器效果？\n0        否\n1        是\n");
					x=S();
					if(x==1)
					{
						if(((*w2).zhuangbei[2].leixing==-1)&&((*w2).zhuangbei[3].leixing==-1))
						{
							printf("电脑根本没有马，射你妹的马啊！\n");
							break;
						}
						else
						{
							for(;;)
							{
								printf("0        ");
								((*w2).zhuangbei[2]).Kanpai();
								printf("1        ");
								((*w2).zhuangbei[3]).Kanpai();
								printf("请选择要弃掉的马，输入之前的编号，以回车结束！\n");
								x=S();
								if((x==0)&&((*w2).zhuangbei[2].leixing!=-1))
								{
									printf("你弃掉了电脑的");
									((*w2).zhuangbei)[2].Kanpai();
									qipaidui[*qipaishu]=((*w2).zhuangbei)[2];
									((*w2).zhuangbeishu)--;
									(*qipaishu)++;
									((*w2).zhuangbei)[2].leixing=-1;
									((*w2).juli[0])++;
									break;
								}
								else if((x==1)&&((*w2).zhuangbei[3].leixing!=-1))
								{
									printf("你弃掉了电脑的");
									((*w2).zhuangbei)[3].Kanpai();
									qipaidui[*qipaishu]=((*w2).zhuangbei)[3];
									((*w2).zhuangbeishu)--;
									(*qipaishu)++;
									((*w2).zhuangbei)[3].leixing=-1;
									((*w1).juli[0])--;
									break;
								}
								else printf("射你妹的马！");
							}
							break;
						}
					}
					else if(x==0)break;
					else printf("键盘上的“0”和“1”被你吃了吗？\n");
				}
			}
			int i;
			((*w2).tili)--;
			printf("玩家对电脑造成1点伤害！\n");
			i=Binsi(w1,w2,qipaidui,qipaishu);
			return i;
		}
		else if(x==0&&((*w1).zhuangbei[0].leixing==306))
		{
			for(;;)
			{
				printf(" 是否发动【贯石斧】武器效果？\n0        否\n1        是\n");
				x=S();
				if(x==1)
				{
					int i;
					if((*w1).shoupaishu+(*w1).zhuangbeishu<=2)
					{
						printf("你除了【贯石斧】以外连2张牌都没有，发动你妹的效果！\n");
						break;
					}
					else
					{
						printf("请分别弃掉两张牌！\n");
						for(i=0;i<=2;i++)
						{
							for(;;)
							{
								printf(" 请选择区域：\n0        手牌\n1        装备\n");
								x=S();
								if(x==0&&((*w1).shoupaishu==0))printf("你根本没有手牌，弃你妹啊！\n");
								else if(x==1&&((*w1).zhuangbeishu==1))printf("你根本没有别的装备，弃你妹啊！\n");
								else if(x>=0&&x<=1)break;
								else printf("键盘上的“0”和“1”被你吃了吗？\n");
							}
							if(x==0)
							{
								for(;;)
								{
									(*w1).Kanshoupai();
									printf("弃牌请输入手牌之前的编号，以回车结束！\n");
									x=S();
									if(x>=0&&x<((*w1).shoupaishu))break;
									else printf("弃你妹的手牌！\n");
								}
								printf("你弃掉了");
								((*w1).shoupai)[x].Kanpai();
								qipaidui[*qipaishu]=((*w1).shoupai)[x];
								for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
								((*w1).shoupaishu)--;
								(*qipaishu)++;
							}
							else
							{
								for(;;)
								{
									(*w1).Kanzhuangbei();
									printf("请输入装备之前的编号，以回车键结束！\n");
									x=S();
									if((((*w1).zhuangbei[x]).leixing!=-1)&&(x>=0)&&(x<=3))
									{
										printf("你弃掉了");
										((*w1).zhuangbei)[x].Kanpai();
										qipaidui[*qipaishu]=((*w1).zhuangbei)[x];
										((*w1).zhuangbeishu)--;
										(*qipaishu)++;
										((*w1).zhuangbei)[x].leixing=-1;
										break;
									}
									else printf("弃你妹的装备！\n");
								}
							}
						}
					}
					printf("玩家发动【贯石斧】武器效果使【杀】造成伤害！\n");
					((*w2).tili)--;
					i=Binsi(w1,w2,qipaidui,qipaishu);
					return i;
					break;
				}
				else if(x==0)break;
				else printf("键盘上的“0”和“1”被你吃了吗？\n");
			}
		}
		else if(x==0&&((*w1).zhuangbei[0].leixing==304))
		{
			for(;;)
			{
				printf(" 是否发动【青龙偃月刀】武器效果？\n0        否\n1        是\n");
				x=S();
				if(x==1)
				{
					for(;;)
					{
						printf("请对电脑使用一张【杀】！\n请输入手牌之前的编号，或者输入“-1”放弃出【杀】，以回车结束！\n");
						(*w1).Kanshoupai();
						x=S();
						if(x==-1)
						{
							return 0;
							break;
						}
						else if((*w1).shoupai[x].leixing==101)
						{
							int i;
							printf("玩家对电脑使用");
							((*w1).shoupai)[x].Kanpai();
							qipaidui[*qipaishu]=((*w1).shoupai)[x];
							for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
							((*w1).shoupaishu)--;
							(*qipaishu)++;
							i=Sha(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
							return i;
							break;
						}
						else printf("你确定你打出的是【杀】？\n");
					}
				}
				else if(x==0)
				{
					return 0;
					break;
				}
				else printf("你确定你输入的是“0”或“1”？\n");
			}
		}
		else return 0;
	} 
	return 0;
}
void Tao(wujiang*w1)
{
	((*w1).tili)++;
	if((*w1).juese)printf("玩家");
	else printf("电脑");
	printf("恢复了1点体力！\n");
	if(((*w1).tili)>((*w1).tilishangxian))printf("你被撑死了！\n");
}
void Chai(wujiang*w1,wujiang*w2,pai qipaidui[104],int*qipaishu)
{
	int i,x,y;
	if((*w1).juese)
	{
		for(;;)
		{
			if((*w2).shoupaishu+(*w2).zhuangbeishu+(*w2).pandingshu==0)
			{
				printf("对方空城，拆你妹啊！\n");
				break;
			}
			else
			{
				printf(" 请选择想拆的区域，输入选项之前的编号，以回车结束！\n0        手牌\n1        装备区\n2        判定区\n");
				x=S();
				if(x==0&&((*w2).shoupaishu==0))printf("你拆掉了一张空气！\n");
				else if(x==1&&((*w2).zhuangbeishu==0))printf("你拆掉了一张空气！\n");
				else if(x==2&&((*w2).pandingshu==0))printf("你拆掉了一张空气！\n");
				else if(x>=0&&x<=2)break;
				else printf("你拆掉了太空区里的一张牌！\n");
			}
		}
		switch(x)
		{
		case 0:
			srand((unsigned)time(NULL));
			y=rand()%((*w2).shoupaishu);
			printf("你弃掉了电脑的");
			((*w2).shoupai)[y].Kanpai();
			qipaidui[*qipaishu]=((*w2).shoupai)[y];
			for(i=y+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
			((*w2).shoupaishu)--;
			(*qipaishu)++;
			break;
		case 1:
			for(;;)
			{
				(*w2).Kanzhuangbei();
				printf("请输入装备之前的编号，以回车键结束！\n");
				y=S();
				if((((*w2).zhuangbei[y]).leixing!=-1)&&(y>=0)&&(y<=3))
				{
					printf("你弃掉了电脑的");
					((*w2).zhuangbei)[y].Kanpai();
					qipaidui[*qipaishu]=((*w2).zhuangbei)[y];
					((*w2).zhuangbeishu)--;
					(*qipaishu)++;
					((*w2).zhuangbei)[y].leixing=-1;
					if(!y)((*w2).zhuangbei)[y].changdu=1;
					else if(y==2)((*w2).juli[0])++;
					else if(y==3)((*w1).juli[0])--;
					break;
				}
				else printf("你弃掉了一张空气！\n");
			}
			break;
		case 2:
			for(;;)
			{
				(*w2).Kanpandingpai();
				printf("请输入判定牌之前的编号，以回车键结束！\n");
				y=S();
				if((*w2).pandingpai[y].leixing!=-1)
				{
					printf("你弃掉了电脑的");
					((*w2).pandingpai)[y].Kanpai();
					qipaidui[*qipaishu]=((*w2).pandingpai)[y];
					((*w2).pandingshu)--;
					(*qipaishu)++;
					((*w2).pandingpai)[y].leixing=-1;
					break;
				}
				else printf("你弃掉了一张空气！\n");
			}
			break;
		default:break;
		}
	}
	else
	{
		if((*w2).zhuangbeishu)
		{
			if((*w2).zhuangbei[1].leixing!=-1)
			{
				printf("电脑弃掉了玩家的");
				((*w2).zhuangbei)[1].Kanpai();
				qipaidui[*qipaishu]=((*w2).zhuangbei)[1];
				((*w2).zhuangbeishu)--;
				(*qipaishu)++;
				((*w2).zhuangbei)[1].leixing=-1;
			}
			else if((*w2).zhuangbei[3].leixing!=-1)
			{
				printf("电脑弃掉了玩家的");
				((*w2).zhuangbei)[3].Kanpai();
				qipaidui[*qipaishu]=((*w2).zhuangbei)[3];
				((*w2).zhuangbeishu)--;
				(*qipaishu)++;
				((*w2).zhuangbei)[3].leixing=-1;
				((*w1).juli[0])--;
			}
			else if((*w2).zhuangbei[0].leixing!=-1)
			{
				printf("电脑弃掉了玩家的");
				((*w2).zhuangbei)[0].Kanpai();
				qipaidui[*qipaishu]=((*w2).zhuangbei)[0];
				((*w2).zhuangbeishu)--;
				(*qipaishu)++;
				((*w2).zhuangbei)[0].leixing=-1;
				((*w2).zhuangbei)[0].changdu=1;
			}
			else
			{
				printf("电脑弃掉了玩家的");
				((*w2).zhuangbei)[2].Kanpai();
				qipaidui[*qipaishu]=((*w2).zhuangbei)[2];
				((*w2).zhuangbeishu)--;
				(*qipaishu)++;
				((*w2).zhuangbei)[2].leixing=-1;
				((*w2).juli[0])++;
			}
		}
		else if((*w2).shoupaishu)
		{
			srand((unsigned)time(NULL));
			y=rand()%((*w2).shoupaishu);
			printf("电脑弃掉了玩家的手牌");
			((*w2).shoupai)[y].Kanpai();
			qipaidui[*qipaishu]=((*w2).shoupai)[y];
			for(i=y+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
			((*w2).shoupaishu)--;
			(*qipaishu)++;
		}
		else;
	}
}
void Qian(wujiang *w1,wujiang *w2)
{
	int i,x,y;
	if((*w1).juese)
	{
		for(;;)
		{
			if((*w2).shoupaishu+(*w2).zhuangbeishu+(*w2).pandingshu==0)
			{
				printf("对方空城啦！你牵走了一张寂寞！\n");
				break;
			}
			else
			{
				printf(" 请选择想牵的区域，输入选项之前的编号，以回车结束！\n0        手牌\n1        装备区\n2        判定区\n");
				x=S();
				if(x==0&&((*w2).shoupaishu==0))printf("你牵走了一张空气！\n");
				else if(x==1&&((*w2).zhuangbeishu==0))printf("你牵走了一张空气！\n");
				else if(x==2&&((*w2).pandingshu==0))printf("你牵走了一张空气！\n");
				else if(x>=0&&x<=2)break;
				else printf("你牵走了太空区里的一张牌！\n");
			}
		}
		switch(x)
		{
		case 0:
			srand((unsigned)time(NULL));
			y=rand()%((*w2).shoupaishu);
			printf("你牵走了电脑的");
			((*w2).shoupai)[y].Kanpai();
			(*w1).shoupai[(*w1).shoupaishu]=((*w2).shoupai)[y];
			for(i=y+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
			((*w2).shoupaishu)--;
			((*w1).shoupaishu)++;
			break;
		case 1:
			for(;;)
			{
				(*w2).Kanzhuangbei();
				printf("请输入装备之前的编号，以回车键结束！\n");
				y=S();
				if((((*w2).zhuangbei[y]).leixing!=-1)&&(y>=0)&&(y<=3))
				{
					printf("你牵走了电脑的");
					((*w2).zhuangbei)[y].Kanpai();
					(*w1).shoupai[(*w1).shoupaishu]=((*w2).zhuangbei)[y];
					((*w2).zhuangbeishu)--;
					((*w1).shoupaishu)++;
					((*w2).zhuangbei)[y].leixing=-1;
					if(!y)((*w2).zhuangbei[y]).changdu=1;
					else if(y==2)((*w2).juli[0])++;
					else if(y==3)((*w1).juli[0])--;
					break;
				}
				else printf("你弃掉了一张空气！\n");
			}
			break;
		case 2:
			for(;;)
			{
				(*w2).Kanpandingpai();
				printf("请输入判定牌之前的编号，以回车键结束！\n");
				y=S();
				if((*w2).pandingpai[y].leixing!=-1)
				{
					printf("你牵走了电脑的");
					((*w2).pandingpai)[y].Kanpai();
					(*w1).shoupai[(*w1).shoupaishu]=((*w2).pandingpai)[y];
					((*w2).pandingshu)--;
					((*w1).shoupaishu)++;
					((*w2).pandingpai)[y].leixing=-1;
					break;
				}
				else printf("你牵走了一张空气！\n");
			}
			break;
		default:break;
		}
	}
	else
	{
		if((*w2).zhuangbeishu)
		{
			if((*w2).zhuangbei[1].leixing!=-1)
			{
				printf("电脑牵走了玩家的");
				((*w2).zhuangbei)[1].Kanpai();
				(*w1).shoupai[(*w1).shoupaishu]=((*w2).zhuangbei)[1];
				((*w2).zhuangbeishu)--;
				((*w1).shoupaishu)++;
				((*w2).zhuangbei)[1].leixing=-1;
			}
			else if((*w2).zhuangbei[3].leixing!=-1)
			{
				printf("电脑牵走了玩家的");
				((*w2).zhuangbei)[3].Kanpai();
				(*w1).shoupai[(*w1).shoupaishu]=((*w2).zhuangbei)[3];
				((*w2).zhuangbeishu)--;
				((*w1).shoupaishu)++;
				((*w2).zhuangbei)[3].leixing=-1;
				((*w1).juli[0])--;
			}
			else if((*w2).zhuangbei[0].leixing!=-1)
			{
				printf("电脑牵走了玩家的");
				((*w2).zhuangbei)[0].Kanpai();
				(*w1).shoupai[(*w1).shoupaishu]=((*w2).zhuangbei)[0];
				((*w2).zhuangbeishu)--;
				((*w1).shoupaishu)++;
				((*w2).zhuangbei)[0].leixing=-1;
				((*w2).zhuangbei)[0].changdu=1;
			}
			else
			{
				printf("电脑牵走了玩家的");
				((*w2).zhuangbei)[2].Kanpai();
				(*w1).shoupai[(*w1).shoupaishu]=((*w2).zhuangbei)[2];
				((*w2).zhuangbeishu)--;
				((*w1).shoupaishu)++;
				((*w2).zhuangbei)[2].leixing=-1;
				((*w2).juli[0])--;
			}
		}
		else if((*w2).shoupaishu)
		{
			srand((unsigned)time(NULL));
			y=rand()%((*w2).shoupaishu);
			printf("电脑牵走了玩家的手牌");
			((*w2).shoupai)[y].Kanpai();
			(*w1).shoupai[(*w1).shoupaishu]=((*w2).shoupai)[y];
			for(i=y+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
			((*w2).shoupaishu)--;
			((*w1).shoupaishu)++;
		}
		else;
	}
}
void Wuzhong(wujiang*w1,pai A[104],int *x,pai B[104],int*y)
{
	Mopai(&((*w1).shoupaishu),(*w1).shoupai,A,x,B,y,(*w1).juese);
}
int Juedou(wujiang*w1,wujiang*w2,pai qipaidui[104],int*qipaishu)
{
	int i,j,x;
	if((*w1).juese)
	{
		for(;;)
		{
			j=0;
			for(x=0;x<((*w2).shoupaishu);x++)
			{
				if((*w2).shoupai[x].leixing==101)
				{
					printf("电脑打出");
					((*w2).shoupai)[x].Kanpai();
					qipaidui[*qipaishu]=((*w2).shoupai)[x];
					for(int i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
					((*w2).shoupaishu)--;
					(*qipaishu)++;
					j=1;
					break;
				}
			}
			if(!j)
			{
				printf("玩家对电脑造成1点伤害！\n");
				((*w2).tili)--;
				i=Binsi(w1,w2,qipaidui,qipaishu);
				return i;
				break;
			}
			j=0;
			for(;;)
			{
				printf("请打出一张【杀】响应【决斗】，否则你将受到1点伤害！\n请输入手牌之前的编号，或者输入非数字字符放弃打出【杀】，以回车结束！\n");
				if(((*w1).zhuangbei[0].leixing==305))printf("如果想发动【丈八蛇矛】效果，请输入“100”，以回车结束！\n");
				(*w1).Kanshoupai();
				x=S();
				if(x==-1)
				{
					int i;
					((*w1).tili)--;
					printf("电脑对玩家造成1点伤害！\n");
					i=Binsi(w2,w1,qipaidui,qipaishu);
					return i;
					break;
				}
				else if(((*w1).zhuangbei[0].leixing==305)&&x==100)
				{
					pai p=Zhangba(w1,qipaidui,qipaishu);
					p.paifu=-1;
					printf("打出！\n");
					j=1;
					break;
				}
				else if((*w1).shoupai[x].leixing==101)
				{
					printf("玩家打出");
					((*w1).shoupai)[x].Kanpai();
					qipaidui[*qipaishu]=((*w1).shoupai)[x];
					for(i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
					((*w1).shoupaishu)--;
					(*qipaishu)++;
					j=1;
					break;
				}
				else printf("你确定你打出的是【杀】？\n");
			}
		}
	}
	else
	{
		for(;;)
		{
			j=0;
			for(;;)
			{
				printf("请打出一张【杀】响应【决斗】，否则你将受到1点伤害！\n请输入手牌之前的编号，或者输入任意非数字字符放弃打出【杀】，以回车结束！\n");
				if(((*w1).zhuangbei[0].leixing==305))printf("如果想发动【丈八蛇矛】效果，请输入“100”，以回车结束！\n");
				(*w2).Kanshoupai();
				x=S();
				if(x==-1)
				{
					int i;
					((*w2).tili)--;
					printf("电脑对玩家造成1点伤害！\n");
					i=Binsi(w1,w2,qipaidui,qipaishu);
					return i;
					break;
				}
				else if(((*w2).zhuangbei[0].leixing==305)&&x==100)
				{
					pai p=Zhangba(w2,qipaidui,qipaishu);
					p.paifu=-1;
					printf("打出！\n");
					j=1;
					break;
				}
				else if((*w2).shoupai[x].leixing==101)
				{
					printf("玩家打出");
					((*w2).shoupai)[x].Kanpai();
					qipaidui[*qipaishu]=((*w2).shoupai)[x];
					for(i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
					((*w2).shoupaishu)--;
					(*qipaishu)++;
					j=1;
					break;
				}
				else printf("你确定你打出的是【杀】？\n");
			}
			j=0;
			for(x=0;x<((*w1).shoupaishu);x++)
			{
				if((*w1).shoupai[x].leixing==101)
				{
					printf("电脑打出");
					((*w1).shoupai)[x].Kanpai();
					qipaidui[*qipaishu]=((*w1).shoupai)[x];
					for(int i=x+1;i<=((*w1).shoupaishu);i++)((*w1).shoupai)[i-1]=((*w1).shoupai)[i];
					((*w1).shoupaishu)--;
					(*qipaishu)++;
					j=1;
					break;
				}
			}
			if(!j)
			{
				printf("玩家对电脑造成1点伤害！\n");
				((*w2).tili)--;
				i=Binsi(w2,w1,qipaidui,qipaishu);
				return i;
				break;
			}
		}
	}
}
int Jiedao(wujiang*w1,wujiang*w2,pai paidui[104],int*paiduishu,pai qipaidui[104],int*qipaishu)
{
	int i,j=0,x;
	if((*w1).juese)
	{
		for(x=0;x<((*w2).shoupaishu);x++)
		{
			if((*w2).shoupai[x].leixing==101)    
			{
				printf("电脑对玩家使用");
				((*w2).shoupai)[x].Kanpai();
				qipaidui[*qipaishu]=((*w2).shoupai)[x];
				for(int i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
				((*w2).shoupaishu)--;
				(*qipaishu)++;
				j=1;
				break;
			}
		}
		if(j)
		{
			i=Sha(w2,w1,paidui,paiduishu,qipaidui,qipaishu);
			return i;
			printf("玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w1).tili,(*w1).tilishangxian,(*w2).tili,(*w2).tilishangxian);
		}
		else
		{
			printf("电脑放弃使用【杀】，玩家获得电脑的武器");
			(*w2).zhuangbei[0].Kanpai();
			(*w1).shoupai[(*w1).shoupaishu]=((*w2).zhuangbei)[0];
			((*w2).zhuangbeishu)--;
			((*w1).shoupaishu)++;
			((*w2).zhuangbei)[0].leixing=-1;
			((*w2).zhuangbei)[0].changdu=1;
			(*w1).Kanshoupai();
			return 0;
		}
	}
	else
	{
		for(;;)
		{
			printf("请对电脑使用一张【杀】，否则电脑将获得你的武器！\n请输入手牌之前的编号，或者输入任意非数字字符放弃使用【杀】，以回车结束！\n");
			if(((*w2).zhuangbei[0].leixing==305))printf("如果想发动【丈八蛇矛】效果，请输入“100”，以回车结束！\n");
			(*w2).Kanshoupai();
			x=S();
			if(x==-1)break;
			else if(((*w2).zhuangbei[0].leixing==305)&&x==100)
			{
				pai p=Zhangba(w2,qipaidui,qipaishu);
				p.paifu=-1;
				printf("使用！\n");
				j=1;
				break;
			}
			else if((*w2).shoupai[x].leixing==101)
			{
				printf("玩家对电脑使用");
				((*w2).shoupai)[x].Kanpai();
				qipaidui[*qipaishu]=((*w2).shoupai)[x];
				for(i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
				((*w2).shoupaishu)--;
				(*qipaishu)++;
				j=1;
				break;
			}
			else printf("你确定你使用的是【杀】？\n");
		}
		if(j)
		{
			i=Sha(w2,w1,paidui,paiduishu,qipaidui,qipaishu);
			return i;
			printf("玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w2).tili,(*w2).tilishangxian,(*w1).tili,(*w1).tilishangxian);
		}
		else
		{
			printf("玩家放弃使用【杀】，电脑获得玩家的武器");
			((*w2).zhuangbei)[0].Kanpai();
			(*w1).shoupai[(*w1).shoupaishu]=((*w2).zhuangbei)[0];
			((*w2).zhuangbeishu)--;
			((*w1).shoupaishu)++;
			((*w2).zhuangbei)[0].leixing=-1;
			((*w2).zhuangbei)[0].changdu=1;
			return 0;
		}
	}
}
void Taoyuan(wujiang*w)
{
	if((*w).tili<(*w).tilishangxian)
	{
		((*w).tili)++;
		if((*w).juese)printf("玩家");
		else printf("电脑");
		printf("恢复1点体力！\n");
	}
}
void Kaipai(pai paidui[104],int* paiduishu,int renshu,pai wugu[10])
{
	int i;
	printf("五谷丰登开牌：\n");
	for(i=1;i<=renshu;i++)
	{
		wugu[i-1]=paidui[104-(*paiduishu)];
		(*paiduishu)--;
		printf("%d        ",i-1);
		wugu[i-1].Kanpai();
	}
}
void Qupai(pai wugu[10],wujiang*w)
{
	int i,x;
	printf("五谷丰登开牌：\n");
	for(i=0;(wugu[i].leixing)!=-1;i++)
	{
		printf("%d        ",i);
		wugu[i].Kanpai();
	}
	if((*w).juese)
	{
		for(;;)
		{
			printf("请选择你想要的卡牌，输入卡牌之前的编号，以回车结束！\n");
			x=S();
			if((x>=0)&&(wugu[x].leixing!=-1)&&(x<=9))
			{
				printf("玩家选择");
				wugu[x].Kanpai();
				(*w).shoupai[(*w).shoupaishu]=wugu[x];
				((*w).shoupaishu)++;
				for(i=x+1;i<=9;i++)wugu[i-1]=wugu[i];
				wugu[9].leixing=-1;
				break;
			}
			printf("你选择了一张空气加入手牌！");
		}
	}
	else
	{
		printf("电脑选择");
		wugu[0].Kanpai();
		(*w).shoupai[(*w).shoupaishu]=wugu[0];
		((*w).shoupaishu)++;
		for(i=1;i<=9;i++)wugu[i-1]=wugu[i];
		wugu[9].leixing=-1;
	}
}
void Rengpai(pai wugu[10],pai qipaidui[104],int*qipaishu)
{
	int i;
	for(i=0;wugu[i].leixing!=-1;i++)
	{
		qipaidui[*qipaishu]=wugu[i];
		(*qipaishu)++;
		wugu[i].leixing=-1;
	}
}
int Nanman(wujiang*w1,wujiang*w2,pai qipaidui[104],int*qipaishu)
{
	int i,x;
	if((*w1).juese)
	{
		for(x=0;x<((*w2).shoupaishu);x++)
		{
			if((*w2).shoupai[x].leixing==101)
			{
				printf("电脑打出");
				((*w2).shoupai)[x].Kanpai();
				qipaidui[*qipaishu]=((*w2).shoupai)[x];
				for(int i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
				((*w2).shoupaishu)--;
				(*qipaishu)++;
				return 0;
				break;
			}
		}
		printf("玩家对电脑造成1点伤害！\n");
		((*w2).tili)--;
		i=Binsi(w1,w2,qipaidui,qipaishu);
		return i;
	}
	else
	{
		for(;;)
		{
			printf("请打出一张【杀】响应【南蛮入侵】，否则你将受到1点伤害！\n请输入手牌之前的编号，或者输入任意非数字字符放弃出【杀】，以回车结束！\n");
			if(((*w2).zhuangbei[0].leixing==305))printf("如果想发动【丈八蛇矛】效果，请输入“100”，以回车结束！\n");
			(*w2).Kanshoupai();
			x=S();
			if(x==-1)
			{
				int i;
				((*w2).tili)--;
				printf("电脑对玩家造成1点伤害！\n");
				i=Binsi(w1,w2,qipaidui,qipaishu);
				return i;
				break;
			}
			else if(((*w2).zhuangbei[0].leixing==305)&&x==100)
			{
				pai p=Zhangba(w2,qipaidui,qipaishu);
				p.paifu=-1;
				printf("使用！\n");
				return 0;
				break;
			}
			else if((*w2).shoupai[x].leixing==101)
			{
				printf("玩家打出");
				((*w2).shoupai)[x].Kanpai();
				qipaidui[*qipaishu]=((*w2).shoupai)[x];
				for(i=x+1;i<=((*w2).shoupaishu);i++)((*w2).shoupai)[i-1]=((*w2).shoupai)[i];
				((*w2).shoupaishu)--;
				(*qipaishu)++;
				return 0;
				break;
			}
			else printf("你确定你打出的是【杀】？\n");
		}
	}
}
int Wanjian(wujiang*w1,wujiang*w2,pai paidui[104],int*paiduishu,pai qipaidui[104],int*qipaishu)
{
	int i;
	i=Shan(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
	if(i==-1)
	{
		((*w2).tili)--;
		printf("玩家对电脑造成1点伤害！\n");
		i=Binsi(w1,w2,qipaidui,qipaishu);
		return i;
	}
	else return 0;
}
int Chupai(pai paidui[104],pai qipaidui[104],int *paiduishu,int*qipaishu,wujiang*w1,wujiang*w2,pai yuanshipaidui[2][4][13])
{
	pai p1;
	int sha=1;int y=-1,i,t=((*w1).shoupaishu)-1;
	for(;;t--)
	{

		if((*w1).juese)
		{
			printf("\n 电脑当前手牌数：%d\n", ((*w2).shoupaishu));                  
			(*w2).Kanzhuangbei();
			(*w1).Kanshoupai();
			(*w1).Kanzhuangbei();
		}
		int j=0;
		if((*w1).juese&&((*w1).zhuangbei[0].leixing==305))printf("如果想发动【丈八蛇矛】效果，请输入“100”，以回车结束！\n");
		y=Xuanpai(w1,t);
		p1=Panpai(w1,&sha,y,qipaidui,qipaishu);
		if((p1).leixing==-1)break;
		else if((p1).leixing==0)continue;
		else
		{
			int duixiang;
			duixiang=Mubiao(p1,w1,w2,&sha);
			if(duixiang==-2)continue;
			else
			{
				Da1pai(w1,w2,qipaidui,qipaishu,y);
				Miaoshu(p1,((*w1).juese),duixiang);                                                                        
				if(!((*w1).juese))
				{
					printf("\n 电脑当前手牌数：%d\n", ((*w1).shoupaishu));                   
					(*w1).Kanzhuangbei();
					(*w2).Kanshoupai();
					(*w2).Kanzhuangbei();
				}
				switch(p1.leixing)
				{
				case 101:
					i=Sha(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
					if(i==-1){return -1;break;}
					if((*w1).juese)printf(" 玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w1).tili,(*w1).tilishangxian, (*w2).tili,(*w2).tilishangxian);
					else printf("玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w2).tili,(*w2).tilishangxian, (*w1).tili,(*w1).tilishangxian);
					break;
				case 103:
					Tao(w1);
					break;
				case 201:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))Chai(w1,w2,qipaidui,qipaishu);
					else;
					if((*w1).juese)(*w1).Kanshoupai();
					break;
				case 202:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))Qian(w1,w2);
					else;
					if((*w1).juese)(*w1).Kanshoupai();
					break;
				case 203:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))Wuzhong(w1,paidui,paiduishu,qipaidui,qipaishu);
					else;
					break;
				case 204:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))
					{
						i=Juedou(w1,w2,qipaidui,qipaishu);
						if(i==-1)return -1;
						if((*w1).juese)printf(" 玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w1).tili,(*w1).tilishangxian, (*w2).tili,(*w2).tilishangxian);
						else printf("玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w2).tili,(*w2).tilishangxian, (*w1).tili,(*w1).tilishangxian);
					}
					break;
				case 205:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))
					{
						i=Jiedao(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
						if(i==-1)return -1;
						if((*w1).juese)printf(" 玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w1).tili,(*w1).tilishangxian, (*w2).tili,(*w2).tilishangxian);
						else printf("玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w2).tili,(*w2).tilishangxian, (*w1).tili,(*w1).tilishangxian);
					}
					break;
				case 206:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))Taoyuan(w1);
					j=0;
					for(;;)
					{
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))Taoyuan(w2);
					break;
				case 207:
					pai wugu[10];
					for(i=1;i<=10;i++)wugu[i-1].leixing=-1;
					Kaipai(paidui,paiduishu,2,wugu);
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))Qupai(wugu,w1);
					for(;;)
					{
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))Qupai(wugu,w2);
					Rengpai(wugu,qipaidui,qipaishu);
					break;
				case 208:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))
					{
						i=Nanman(w1,w2,qipaidui,qipaishu);
						if(i==-1)return -1;
						if((*w1).juese)printf(" 玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w1).tili,(*w1).tilishangxian, (*w2).tili,(*w2).tilishangxian);
						else printf("玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w2).tili,(*w2).tilishangxian, (*w1).tili,(*w1).tilishangxian);
					}
					break;
				case 209:
					for(;;)
					{
						i=Wuxie(&p1,w1,w2,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
						i=Wuxie(&p1,w2,w1,qipaidui,qipaishu,0);
						if(!i)break;
						j++;
					}
					if(!(j%2))
					{
						i=Wanjian(w1,w2,paidui,paiduishu,qipaidui,qipaishu);
						if(i==-1)return -1;
						if((*w1).juese)printf(" 玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w1).tili,(*w1).tilishangxian, (*w2).tili,(*w2).tilishangxian);
						else printf("玩家当前体力值：%d/%d\n电脑当前体力值：%d/%d\n",(*w2).tili,(*w2).tilishangxian, (*w1).tili,(*w1).tilishangxian);
					}
					break;
				case 361:
				case 362:
				case 363:
					((*w1).juli[0])--;break;
				case 381:
				case 382:
				case 383:
					((*w2).juli[0])++;break;
				default:break;
				}
				printf("\n");
			}
		}
	}
	return 0;
}
void Qipai(pai shoupai[20],int *shoupaishu,pai qipaidui[104],int *qipaishu,int juese,int *shoupaishangxian)
{ 
	int x;
	if((*shoupaishu)>(*shoupaishangxian))
	{
		if(juese!=1&&juese!=0)printf("身份参数错误！");
		int q=(*shoupaishu)-(*shoupaishangxian);
		int i,j;
		for(j=1;j<=q;j++)
		{
			for(;;)
			{
				if(juese)
				{
					printf("弃牌请输入手牌之前的编号，以回车结束！\n注：一次只能弃一张牌\n");
					printf("手牌数：%d\n",*shoupaishu);
					x=S();
					if(x>=0&&x<(*shoupaishu))break;
					else printf("你弃掉了一张空气！\n");
				}
				else
				{
					srand((unsigned)time(NULL));
					x=rand()%(*shoupaishu);
					break;
				}
			}
			qipaidui[*qipaishu]=shoupai[x];
			for(i=x+1;i<=(*shoupaishu);i++)shoupai[i-1]=shoupai[i];
			(*shoupaishu)--;
			if(juese)printf("弃牌阶段玩家弃置");
			else printf("弃牌阶段电脑弃置");
			qipaidui[*qipaishu].Kanpai();
			(*qipaishu)++;
			int m;
			if(juese)
			{
				printf("玩家当前手牌：\n");
				for(m=0;m<=(*shoupaishu-1);m++)
				{
					printf("%d        ",m);
					(shoupai[m]).Kanpai();
				}
			}
		}
	}
}
int Huihe(pai A[104],pai B[104],int *x,int *y,pai yuanshipaidui[2][4][13],wujiang *w1,wujiang *w2)
{
	printf("\n回合开始阶段……\n");
	switch((*w1).huihekaishi)
	{
	case 0:break;
	default:printf("回合开始阶段参数错误！\n");break;
	}
	printf("判定阶段……\n");
	int K=0;
	if((*w1).pandingshu>0)
	{
		int i,j;
		for(;(*w1).pandingshu;)
		{
			switch((*w1).pandingpai[0].leixing)
			{
			case 251:printf("【乐不思蜀】开始判定……\n"); break;
			case 252:printf("【闪电】开始判定……\n");break;
			default:printf("【？？】开始判定……\n");break;
			}
			j=0;
			pai p=((*w1).pandingpai[0]);
			for(;;)
			{
				i=Wuxie(&p,w2,w1,B,y,0);
				if(!i)break;
				j++;
				i=Wuxie(&p,w1,w2,B,y,0);
				if(!i)break;
				j++;
			}
			switch((*w1).pandingpai[0].leixing)
			{
			case 251:
				if(!(j%2))
				{
					printf("【乐不思蜀】的判定牌是：");
					Panding(A,x,B,y);
					if((B[(*y)-1].huase)!=1)
					{
						printf("【乐不思蜀】判定成功！\n");
						if((*w1).juese)printf("玩家");
						else printf("电脑");
						printf("跳过出牌阶段！\n");
						K=-1;
					}
					else printf("【乐不思蜀】判定失败！\n");
				}
				B[*y]=(*w1).pandingpai[0];
				((*w1).pandingshu)--;
				(*w1).pandingpai[0]=(*w1).pandingpai[1];
				(*w1).pandingpai[1]=(*w1).pandingpai[2];
				(*w1).pandingpai[2].leixing=-1;
				(*y)++;
				break;
			case 252:
				if(!(j%2))
				{
					printf("【闪电】的判定牌是：");
					Panding(A,x,B,y);
					if((B[(*y)-1].huase==0)&&(B[(*y)-1].dianshu>=1)&&(B[(*y)-1].dianshu<=8))
					{
						printf("【闪电】判定成功！\n");
						if((*w1).juese)printf("玩家");
						else printf("电脑");
						printf("受到3点雷电伤害！");
						((*w1).tili)=((*w1).tili)-3;
						i=Binsi(w2,w1,B,y);
						B[*y]=(*w1).pandingpai[0];
						((*w1).pandingshu)--;
						(*w1).pandingpai[0]=(*w1).pandingpai[1];
						(*w1).pandingpai[1]=(*w1).pandingpai[2];
						(*w1).pandingpai[2].leixing=-1;
						(*y)++; 
						if(i==-1)return -1;
					}
					else
					{
						printf("【闪电】判定失败！\n");
						(*w2).pandingpai[2]=(*w2).pandingpai[1];
						(*w2).pandingpai[1]=(*w2).pandingpai[0];
						(*w2).pandingpai[0]=(*w1).pandingpai[0];
						(*w1).pandingpai[0]=(*w1).pandingpai[1];
						(*w1).pandingpai[1]=(*w1).pandingpai[2];
						(*w1).pandingpai[2].leixing=-1;
						((*w1).pandingshu)--;
						((*w2).pandingshu)++;
					}
					break;
				}
			default:printf("判定牌错误！");
			}
		} 
	}
	else if(!((*w1).pandingshu));
	else printf("判定阶段参数错误！\n");
	printf("摸牌阶段……\n");
	switch((*w1).mopai)
	{
	case 0:Mopai(&((*w1).shoupaishu),(*w1).shoupai,A,x,B,y,(*w1).juese);break;
	case -1:break;
	default:printf("摸牌阶段参数错误！\n");break;
	}
	if(K==-1)goto M;
	printf("出牌阶段……\n");
	switch((*w1).chupai)
	{
	case 0:
		{
			int i;
			i=Chupai(A,B,x,y,w1,w2,yuanshipaidui);
			if(i==-1)
			{
				return -1;
				break;
			}
			else
				break;
		}
	case -1:break;
	default:printf("出牌阶段参数错误！\n");break;
	}
M:
	printf("弃牌阶段……\n");
	switch((*w1).qipai)
	{
	case 0:
		Qipai((*w1).shoupai,&((*w1).shoupaishu),B,y,(*w1).juese,&((*w1).tili));break;
	default:printf("弃牌阶段参数错误！\n");break;
	}
	printf("回合结束阶段……\n");
	switch((*w1).huihejieshu)
	{
	case 0:break;
	default:printf("回合结束阶段参数错误！\n");break;
	}
	return 0;
}
int main()
{
	void Kanshoupai(pai p);
	pai yuanshipaidui[2][4][13],qipaidui[104],paidui[104];
	wujiang wanjia,com;
	com.tili=wanjia.tili=5;
	com.tilishangxian=wanjia.tilishangxian=5;
	com.huihekaishi=wanjia.huihekaishi=0;
	com.panding=wanjia.panding=0;
	com.mopai=wanjia.mopai=0;
	com.chupai=wanjia.chupai=0;
	com.qipai=wanjia.qipai=0;
	com.huihejieshu=wanjia.huihejieshu=0;
	com.shoupaishu=wanjia.shoupaishu=0;
	com.pandingshu=wanjia.pandingshu=0;
	com.zhuangbeishu=wanjia.zhuangbeishu=0;
	com.juese=0;wanjia.juese=1;
	pai p;
	p.leixing=-1;
	com.zhuangbei[0]=com.zhuangbei[1]=com.zhuangbei[2]=com.zhuangbei[3]=wanjia.zhuangbei[0]=wanjia.zhuangbei[1]=wanjia.zhuangbei[2]=wanjia.zhuangbei[3]=p;
	com.zhuangbei[0].changdu=wanjia.zhuangbei[0].changdu=1;
	com.pandingpai[0]=com.pandingpai[1]=com.pandingpai[2]=wanjia.pandingpai[0]=wanjia.pandingpai[1]=wanjia.pandingpai[2]=p;
	com.juli[0]=wanjia.juli[0]=1;
	int a,b,c;
	for(a=0;a<=1;a++)
	{
		for(b=0;b<=3;b++)
		{
			for(c=0;c<=12;c++)
			{
				yuanshipaidui[a][b][c].paifu=a;
				yuanshipaidui[a][b][c].huase=b;
				yuanshipaidui[a][b][c].dianshu=c;
			}
		}
	}
	yuanshipaidui[0][0][0].leixing=204;
	yuanshipaidui[0][0][1].leixing=331;
	yuanshipaidui[0][0][2].leixing=201;
	yuanshipaidui[0][0][3].leixing=201;
	yuanshipaidui[0][0][4].leixing=304;yuanshipaidui[0][0][4].changdu=3;
	yuanshipaidui[0][0][5].leixing=251;
	yuanshipaidui[0][0][6].leixing=101;
	yuanshipaidui[0][0][7].leixing=101;
	yuanshipaidui[0][0][8].leixing=101;
	yuanshipaidui[0][0][9].leixing=101;
	yuanshipaidui[0][0][10].leixing=202;
	yuanshipaidui[0][0][11].leixing=201;
	yuanshipaidui[0][0][12].leixing=208;
	yuanshipaidui[0][1][0].leixing=209;
	yuanshipaidui[0][1][1].leixing=102;
	yuanshipaidui[0][1][2].leixing=103;
	yuanshipaidui[0][1][3].leixing=103;
	yuanshipaidui[0][1][4].leixing=308;yuanshipaidui[0][1][4].changdu=5;
	yuanshipaidui[0][1][5].leixing=103;
	yuanshipaidui[0][1][6].leixing=103;
	yuanshipaidui[0][1][7].leixing=103;
	yuanshipaidui[0][1][8].leixing=103;
	yuanshipaidui[0][1][9].leixing=101;
	yuanshipaidui[0][1][10].leixing=101;
	yuanshipaidui[0][1][11].leixing=103;
	yuanshipaidui[0][1][12].leixing=102;
	yuanshipaidui[0][2][0].leixing=204;
	yuanshipaidui[0][2][1].leixing=101;
	yuanshipaidui[0][2][2].leixing=101;
	yuanshipaidui[0][2][3].leixing=101;
	yuanshipaidui[0][2][4].leixing=101;
	yuanshipaidui[0][2][5].leixing=101;
	yuanshipaidui[0][2][6].leixing=101;
	yuanshipaidui[0][2][7].leixing=101;
	yuanshipaidui[0][2][8].leixing=101;
	yuanshipaidui[0][2][9].leixing=101;
	yuanshipaidui[0][2][10].leixing=101;
	yuanshipaidui[0][2][11].leixing=205;
	yuanshipaidui[0][2][12].leixing=205;
	yuanshipaidui[0][3][0].leixing=204;
	yuanshipaidui[0][3][1].leixing=102;
	yuanshipaidui[0][3][2].leixing=102;
	yuanshipaidui[0][3][3].leixing=102;
	yuanshipaidui[0][3][4].leixing=102;
	yuanshipaidui[0][3][5].leixing=101;
	yuanshipaidui[0][3][6].leixing=101;
	yuanshipaidui[0][3][7].leixing=101;
	yuanshipaidui[0][3][8].leixing=101;
	yuanshipaidui[0][3][9].leixing=101;
	yuanshipaidui[0][3][10].leixing=102;
	yuanshipaidui[0][3][11].leixing=103;
	yuanshipaidui[0][3][12].leixing=101;
	yuanshipaidui[1][0][0].leixing=252;
	yuanshipaidui[1][0][1].leixing=302;yuanshipaidui[1][0][1].changdu=2;
	yuanshipaidui[1][0][2].leixing=202;
	yuanshipaidui[1][0][3].leixing=202;
	yuanshipaidui[1][0][4].leixing=383;
	yuanshipaidui[1][0][5].leixing=303;yuanshipaidui[1][0][5].changdu=2;
	yuanshipaidui[1][0][6].leixing=208;
	yuanshipaidui[1][0][7].leixing=101;
	yuanshipaidui[1][0][8].leixing=101;
	yuanshipaidui[1][0][9].leixing=101;
	yuanshipaidui[1][0][10].leixing=210;
	yuanshipaidui[1][0][11].leixing=305;yuanshipaidui[1][0][11].changdu=3;
	yuanshipaidui[1][0][12].leixing=362;
	yuanshipaidui[1][1][0].leixing=206;
	yuanshipaidui[1][1][1].leixing=102;
	yuanshipaidui[1][1][2].leixing=207;
	yuanshipaidui[1][1][3].leixing=207;
	yuanshipaidui[1][1][4].leixing=361;
	yuanshipaidui[1][1][5].leixing=251;
	yuanshipaidui[1][1][6].leixing=203;
	yuanshipaidui[1][1][7].leixing=203;
	yuanshipaidui[1][1][8].leixing=203;
	yuanshipaidui[1][1][9].leixing=101;
	yuanshipaidui[1][1][10].leixing=203;
	yuanshipaidui[1][1][11].leixing=201;
	yuanshipaidui[1][1][12].leixing=381;
	yuanshipaidui[1][2][0].leixing=301;yuanshipaidui[1][2][0].changdu=1;
	yuanshipaidui[1][2][1].leixing=331;
	yuanshipaidui[1][2][2].leixing=201;
	yuanshipaidui[1][2][3].leixing=201;
	yuanshipaidui[1][2][4].leixing=382;
	yuanshipaidui[1][2][5].leixing=251;
	yuanshipaidui[1][2][6].leixing=208;
	yuanshipaidui[1][2][7].leixing=101;
	yuanshipaidui[1][2][8].leixing=101;
	yuanshipaidui[1][2][9].leixing=101;
	yuanshipaidui[1][2][10].leixing=101;
	yuanshipaidui[1][2][11].leixing=210;
	yuanshipaidui[1][2][12].leixing=210;
	yuanshipaidui[1][3][0].leixing=301;yuanshipaidui[1][3][0].changdu=1;
	yuanshipaidui[1][3][1].leixing=102;
	yuanshipaidui[1][3][2].leixing=202;
	yuanshipaidui[1][3][3].leixing=202;
	yuanshipaidui[1][3][4].leixing=306;yuanshipaidui[1][3][4].changdu=3;
	yuanshipaidui[1][3][5].leixing=102;
	yuanshipaidui[1][3][6].leixing=102;
	yuanshipaidui[1][3][7].leixing=102;
	yuanshipaidui[1][3][8].leixing=102;
	yuanshipaidui[1][3][9].leixing=102;
	yuanshipaidui[1][3][10].leixing=102;
	yuanshipaidui[1][3][11].leixing=307;yuanshipaidui[1][3][11].changdu=4;
	yuanshipaidui[1][3][12].leixing=363;
	int paiduishu=104;
	int qipaishu=0;
	printf("游戏开始！\n");
	Qishixipai(yuanshipaidui,paidui);
	Qishishoupai(&wanjia,paidui,&(paiduishu),qipaidui,&(qipaishu));
	Qishishoupai(&com,paidui,&(paiduishu),qipaidui,&(qipaishu));
	int i;
	for(;;)
	{
		i=Huihe(paidui,qipaidui,&paiduishu,&qipaishu,yuanshipaidui,&wanjia,&com);
		if(i==-1)break;
		i=Huihe(paidui,qipaidui,&paiduishu,&qipaishu,yuanshipaidui,&com,&wanjia);
		if(i==-1)break;
	}
	if(com.tili<=0)printf("YOU WIN!");
	else printf("YOU LOSE!");
	return 0;
}