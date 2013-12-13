T:
	@echo "-------- SWC Example --------"

	@echo && echo "Now compile a SWC"
	"$(FLASCC)/usr/bin/g++" $(BASE_CFLAGS) sanguosha.cpp -jvmopt=-Xmx1G -lFlash++ -lAS3++ -pthread -O4 -flto-api=exports.txt -emit-swc=FlasCCSWC.Sanguosha -o Sanguosha.swc

clean:
	rm -f *.swf *.swc *.bc *.exe
