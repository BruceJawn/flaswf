$?EXTRACFLAGS=
OPT_CFLAGS:=-O4

T:
	@echo "-------- nobgcall test --------"
	$(AS3COMPILERARGS) -AS3 \
		-import $(call nativepath,$(FLASCC)/usr/lib/builtin.abc) \
		-import $(call nativepath,$(FLASCC)/usr/lib/ISpecialFile.abc) \
		-import $(call nativepath,$(FLASCC)/usr/lib/CModule.abc) \
		-import $(call nativepath,$(FLASCC)/usr/lib/playerglobal.abc) \
		Console.as -outdir . -out Console

	"$(FLASCC)/usr/bin/g++" $(BASE_CFLAGS) nobgcalltest.cpp -symbol-abc=Console.abc -jvmopt=-Xmx1G -lFlash++ -lAS3++ -O4 -flto-api=exports.txt  -emit-swf -swf-version=21 -no-swf-preloader -swf-size=800x600 -o nobgcalltest.swf

TDebug: check
	make T04 OPT_CFLAGS="-O0 -g"

include Makefile.common


clean:
	rm -f *.swf *.bc *.abc
