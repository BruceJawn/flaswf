T:
	@echo "-------- SWC Example --------"

	@echo && echo "Now compile a SWC"
	"$(FLASCC)/usr/bin/g++" $(BASE_CFLAGS) -O4 as3api.cpp main.cpp -emit-swc=FlasCCTest.lookupeffect -o lookupeffect.swc

clean:
	rm -f *.swf *.swc *.bc *.exe
