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
				if(i==0)	
				{
					((*w2).tili)++;
					lastrecovercnt+=21;
				}
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
				printf("是否发动【八卦阵】防具效果？\n0        否\n1        是\n请输入选项之前的编号，以回车结束！\n");
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
	int x;                                                                                              
	printf("距离：%d\n",(*w1).juli[0]);
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
					printf("是否发动【麒麟弓】武器效果？\n0        否\n1        是\n");
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
			//
			lasthurtcnt+=12;
			//
			printf("玩家对电脑造成1点伤害！\n");
			i=Binsi(w1,w2,qipaidui,qipaishu);
			return i;
		}
		else if(x==0&&((*w1).zhuangbei[0].leixing==306))
		{
			for(;;)
			{
				printf("是否发动【贯石斧】武器效果？\n0        否\n1        是\n");
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
								printf("请选择区域：\n0        手牌\n1        装备\n");
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
					//
					lasthurtcnt+=12;
					//
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
				printf("是否发动【青龙偃月刀】武器效果？\n0        否\n1        是\n");
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
	else if ((*w1).juese)
	//
	lastrecovercnt+=21;
	//
}