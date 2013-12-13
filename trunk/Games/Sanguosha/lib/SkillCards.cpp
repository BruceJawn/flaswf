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
				printf("请选择想拆的区域，输入选项之前的编号，以回车结束！\n0        手牌\n1        装备区\n2        判定区\n");
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
				printf("请选择想牵的区域，输入选项之前的编号，以回车结束！\n0        手牌\n1        装备区\n2        判定区\n");
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
				((*w2).juli[0])++;
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
				//
				lasthurtcnt+=12;
				//
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
				((*w1).tili)--;
				//
				lasthurtcnt+=12;
				//
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
		//
		if((*w).juese) lastrecovercnt+=21;
		//
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
		//
		lasthurtcnt+=12;
		//
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
		//
		lasthurtcnt+=12;
		//
		printf("玩家对电脑造成1点伤害！\n");
		i=Binsi(w1,w2,qipaidui,qipaishu);
		return i;
	}
	else return 0;
}