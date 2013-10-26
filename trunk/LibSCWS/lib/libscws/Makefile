T:
	@echo "-------- Make SWC --------"

	@echo && echo "Now compile a SWC"
	"$(FLASCC)/usr/bin/gcc" $(BASE_CFLAGS) -jvmopt=-Xmx1G -O4 charset.c crc32.c darray.c lock.c pool.c rule.c scws.c xdb.c xdict.c xtree.c as3api.c main.c VFS.abc -emit-swc=CrossBridge.libscws -o libscws.swc

clean:
	rm -f *.swf *.swc *.bc *.exe
