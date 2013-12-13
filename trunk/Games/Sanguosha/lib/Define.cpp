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
	}//end of void Kanpai()
};//end of struct pai

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
	}//end of void Kanpandingpai()
};//end of struct wujiang

//Game Variables
//
int hurtcnt=0;
int recovercnt=0;

int lasthurtcnt=0;
int lastrecovercnt=0;

int roundcnt=0;
int wincnt=0;
//