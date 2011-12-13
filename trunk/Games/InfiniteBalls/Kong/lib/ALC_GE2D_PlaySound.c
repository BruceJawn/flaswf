void PlaySound_Flash(const char* name, int times)
{
  AS3_CallTS("PlaySound", AS_Main, "StrType,IntType", name, times);
}//end of initialize

