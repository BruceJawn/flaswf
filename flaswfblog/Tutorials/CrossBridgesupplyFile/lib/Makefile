T:
	@echo "-------- Make SWC --------"

	@echo && echo "Now compile a SWC"
	"$(FLASCC)/usr/bin/g++" $(BASE_CFLAGS) -jvmopt=-Xmx1G -O4 vfstest.cpp -emit-swc=com.adobe.flascc -o loadfile.swc

clean:
	rm -f *.swf *.swc *.bc *.exe
