/* Does a FILE * read against a ByteArray */
static int readByteArray(void *cookie, char *dst, int size)
{
	return AS3_ByteArray_readBytes(dst, (AS3_Val)cookie, size);
}
 
/* Does a FILE * write against a ByteArray */
static int writeByteArray(void *cookie, const char *src, int size)
{
	return AS3_ByteArray_writeBytes((AS3_Val)cookie, (char *)src, size);
}
 
/* Does a FILE * lseek against a ByteArray */
static fpos_t seekByteArray(void *cookie, fpos_t offs, int whence)
{
	return AS3_ByteArray_seek((AS3_Val)cookie, offs, whence);
}
 
/* Does a FILE * close against a ByteArray */
static int closeByteArray(void * cookie)
{
	AS3_Val zero = AS3_Int(0);
 
	/* just reset the position */
	AS3_SetS((AS3_Val)cookie, "position", zero);
	AS3_Release(zero);
	return 0;
}

//读取游戏数据
short LoadData_Flash( char * path)
{
        AS3_CallTS("SupplyData", AS_Main, "StrType", path);

	FILE *fp;
	//打开文件
	fp = fopen(path,"rb");
	if(fp == NULL)
	{
        printf("load failed!\n");
		return 1;
	}

	//读取玩家数据
	fread(&Aqing.X, sizeof(int),1,fp);
	fread(&Aqing.Y, sizeof(int),1,fp);
	fread(&Aqing.Dir, sizeof(int),1,fp);
	fread(&Aqing.Step, sizeof(int),1,fp);
	fread(&Aqing.MapID, sizeof(int),1,fp);
	fread(&fAqing.HP, sizeof(short), 1, fp);
	fread(&fAqing.cHP, sizeof(short), 1, fp);
	fread(&fAqing.Attack, sizeof(short), 1,fp);
	fread(&fAqing.Defend, sizeof(short), 1, fp);

	//读取其它NPC数据
	fread(&Puren.X, sizeof(int), 1, fp);
	fread(&Puren.Y, sizeof(int), 1, fp);
	fread(&Jianke.X, sizeof(int), 1, fp);
	fread(&Jianke.Y, sizeof(int), 1, fp);
	fread(&Yehaizi.X, sizeof(int), 1, fp);
	fread(&Yehaizi.Y, sizeof(int), 1, fp);
	fread(&box_fanli.Step, sizeof(int), 1, fp);
	fread(&box_jianke.Step, sizeof(int), 1, fp);
	fread(&box_caoyuan.Step, sizeof(int), 1, fp);

	//读取地图陷阱数据
	int i,j;
	for(i = 0; i< 10; i++)
	{
		for(j =0; j< 15; j++)
		{
			fread(&Map_shaoxing.Trap[i][j], sizeof(short), 1, fp);
			fread(&Map_outside.Trap[i][j], sizeof(short), 1, fp);
			fread(&Map_Wuguo.Trap[i][j], sizeof(short), 1, fp);
			fread(&Map_Gongdian.Trap[i][j], sizeof(short), 1, fp);
			fread(&Map_caoyuan.Trap[i][j], sizeof(short), 1, fp);
		}
	}

	//读取地图NPC数据
	for(i =0; i< 15; i++)
	{
		fread(&Map_aqing.Npcs[i], sizeof(int), 1, fp);		//1
		fread(&Map_shaoxing.Npcs[i], sizeof(int), 1, fp);	//2
		fread(&Map_citydoor.Npcs[i], sizeof(int), 1, fp);	//3
		fread(&Map_fanli.Npcs[i], sizeof(int), 1, fp);		//4
		fread(&Map_outside.Npcs[i], sizeof(int), 1, fp);	//5
		fread(&Map_caoyuan.Npcs[i], sizeof(int), 1, fp);	//6
		fread(&Map_Wuguo.Npcs[i], sizeof(int), 1, fp);		//7
		fread(&Map_Gongdian.Npcs[i], sizeof(int), 1, fp);	//8
		fread(&Map_Xiangfang.Npcs[i], sizeof(int), 1, fp);	//9
	}

	//读取剧情标志数据
	fread(&asked_by_fanli, sizeof(short), 1, fp);	//1
	fread(&asked_to_house, sizeof(short), 1, fp);	//2
	fread(&see_jianke, sizeof(short), 1, fp);	//3
	fread(&get_key, sizeof(short), 1, fp);		//4
	fread(&defeat_feitu, sizeof(short), 1, fp);	//5
	fread(&defeat_shangping, sizeof(short), 1, fp);	//6
	fread(&ask_to_caoyuan, sizeof(short), 1, fp);	//7
	fread(&see_yehaizi, sizeof(short), 1, fp);		//8
	fread(&defeat_yehaizi, sizeof(short), 1, fp);	//9
	fread(&defeat_jianke, sizeof(short), 1, fp);		//10
	fread(&ask_where_fanli, sizeof(short), 1, fp);		//11
	fread(&really_defeat_jianke, sizeof(short), 1, fp);	//12
	fread(&defeat_shiwei, sizeof(short), 1, fp);	//13

	fclose(fp);
	return 0;
	
}

//存储游戏数据
short StoreData_Flash(char * path)
{
	FILE *fp;

	//打开文件
	//fp = fopen(path,"wb");
        AS3_Val flash_utils_namespace = AS3_String("flash.utils");
        AS3_Val ByteArray_class = AS3_NSGetS(flash_utils_namespace, "ByteArray");
        AS3_Val byteArray = AS3_New(ByteArray_class, AS3_Array(""));

	fp = funopen((void *)byteArray, readByteArray, writeByteArray, seekByteArray, closeByteArray);
	if(fp == NULL)
	{
        printf("store failed!\n");
		return 1;
	}

	//存储玩家数据
	fwrite(&Aqing.X, sizeof(int), 1, fp);
	fwrite(&Aqing.Y, sizeof(int), 1, fp);
	fwrite(&Aqing.Dir, sizeof(int), 1, fp);
	fwrite(&Aqing.Step, sizeof(int), 1, fp);
	fwrite(&Aqing.MapID, sizeof(int), 1, fp);
	fwrite(&fAqing.HP, sizeof(short), 1, fp);
	fwrite(&fAqing.cHP, sizeof(short), 1, fp);
	fwrite(&fAqing.Attack, sizeof(short), 1,fp);
	fwrite(&fAqing.Defend, sizeof(short), 1, fp);

	//存储其它NPC数据
	fwrite(&Puren.X, sizeof(int), 1, fp);
	fwrite(&Puren.Y, sizeof(int), 1, fp);
	fwrite(&Jianke.X, sizeof(int), 1, fp);
	fwrite(&Jianke.Y, sizeof(int), 1, fp);
	fwrite(&Yehaizi.X, sizeof(int), 1, fp);
	fwrite(&Yehaizi.Y, sizeof(int), 1, fp);
	fwrite(&box_fanli.Step, sizeof(int), 1, fp);
	fwrite(&box_jianke.Step, sizeof(int), 1, fp);
	fwrite(&box_caoyuan.Step, sizeof(int), 1, fp);

	//存储地图陷阱数据
	int i,j;
	for(i = 0; i< 10; i++)
	{
		for(j =0; j< 15; j++)
		{
			fwrite(&Map_shaoxing.Trap[i][j], sizeof(short), 1, fp);
			fwrite(&Map_outside.Trap[i][j], sizeof(short), 1, fp);
			fwrite(&Map_Wuguo.Trap[i][j], sizeof(short), 1, fp);
			fwrite(&Map_Gongdian.Trap[i][j], sizeof(short), 1, fp);
			fwrite(&Map_caoyuan.Trap[i][j], sizeof(short), 1, fp);
		}
	}

	//存储地图NPC数据
	for(i =0; i< 15; i++)
	{
		fwrite(&Map_aqing.Npcs[i], sizeof(int), 1, fp);		//1
		fwrite(&Map_shaoxing.Npcs[i], sizeof(int), 1, fp);	//2
		fwrite(&Map_citydoor.Npcs[i], sizeof(int), 1, fp);	//3
		fwrite(&Map_fanli.Npcs[i], sizeof(int), 1, fp);		//4
		fwrite(&Map_outside.Npcs[i], sizeof(int), 1, fp);	//5
		fwrite(&Map_caoyuan.Npcs[i], sizeof(int), 1, fp);	//6
		fwrite(&Map_Wuguo.Npcs[i], sizeof(int), 1, fp);		//7
		fwrite(&Map_Gongdian.Npcs[i], sizeof(int), 1, fp);	//8
		fwrite(&Map_Xiangfang.Npcs[i], sizeof(int), 1, fp);	//9
	}

	//存储剧情标志数据
	fwrite(&asked_by_fanli, sizeof(short), 1, fp);	//1
	fwrite(&asked_to_house, sizeof(short), 1, fp);	//2
	fwrite(&see_jianke, sizeof(short), 1, fp);	//3
	fwrite(&get_key, sizeof(short), 1, fp);		//4
	fwrite(&defeat_feitu, sizeof(short), 1, fp);	//5
	fwrite(&defeat_shangping, sizeof(short), 1, fp);	//6
	fwrite(&ask_to_caoyuan, sizeof(short), 1, fp);	//7
	fwrite(&see_yehaizi, sizeof(short), 1, fp);		//8
	fwrite(&defeat_yehaizi, sizeof(short), 1, fp);	//9
	fwrite(&defeat_jianke, sizeof(short), 1, fp);		//10
	fwrite(&ask_where_fanli, sizeof(short), 1, fp);		//11
	fwrite(&really_defeat_jianke, sizeof(short), 1, fp);	//12
	fwrite(&defeat_shiwei, sizeof(short), 1, fp);	//13
		
	AS3_CallTS("SaveData", AS_Main, "AS3ValType,StrType", byteArray, path);
        //关闭文件
	fclose(fp);
	AS3_Release(flash_utils_namespace);
	AS3_Release(ByteArray_class);
	AS3_Release(byteArray);
	return 0;
}

