#Modified By <Bruce Jawn> [http://bruce-lab.blogspot.com]
$?PAK0FILE=/xxx
$?BUILDDIR=build
$?QUAKECFLAGS=$(BASE_CFLAGS) -D_THREAD_SAFE -DSDL -Wno-pointer-sign `"$(call unixpath,$(FLASCC)/usr/bin/sdl-config)" --cflags` $(EXTRACFLAGS)
$?DEBUG=FALSE
$?EXTRACFLAGS= 
JVMARGS:=-Xmx1G

ifeq ("$(DEBUG)","FALSE")
	$?CFLAGS=-O4 -flto-api=../exports.txt -fno-stack-protector $(EXTRACFLAGS)
else
	$?CFLAGS=-O0 -g $(EXTRACFLAGS)
endif

OBJS = sdlquake-1.0.9/cd_null.o sdlquake-1.0.9/chase.o sdlquake-1.0.9/cl_demo.o sdlquake-1.0.9/cl_input.o sdlquake-1.0.9/cl_main.o sdlquake-1.0.9/cl_parse.o sdlquake-1.0.9/cl_tent.o sdlquake-1.0.9/cmd.o sdlquake-1.0.9/common.o sdlquake-1.0.9/console.o sdlquake-1.0.9/crc.o sdlquake-1.0.9/cvar.o sdlquake-1.0.9/d_edge.o sdlquake-1.0.9/d_fill.o sdlquake-1.0.9/d_init.o sdlquake-1.0.9/d_modech.o sdlquake-1.0.9/d_part.o sdlquake-1.0.9/d_polyse.o sdlquake-1.0.9/d_scan.o sdlquake-1.0.9/d_sky.o sdlquake-1.0.9/d_sprite.o sdlquake-1.0.9/d_surf.o sdlquake-1.0.9/d_zpoint.o sdlquake-1.0.9/draw.o sdlquake-1.0.9/host.o sdlquake-1.0.9/host_cmd.o sdlquake-1.0.9/keys.o sdlquake-1.0.9/mathlib.o sdlquake-1.0.9/menu.o sdlquake-1.0.9/model.o sdlquake-1.0.9/net_main.o sdlquake-1.0.9/net_none.o sdlquake-1.0.9/net_vcr.o sdlquake-1.0.9/net_loop.o sdlquake-1.0.9/pr_cmds.o sdlquake-1.0.9/pr_edict.o sdlquake-1.0.9/pr_exec.o sdlquake-1.0.9/r_aclip.o sdlquake-1.0.9/r_alias.o sdlquake-1.0.9/r_bsp.o sdlquake-1.0.9/r_draw.o sdlquake-1.0.9/r_edge.o sdlquake-1.0.9/r_efrag.o sdlquake-1.0.9/r_light.o sdlquake-1.0.9/r_main.o sdlquake-1.0.9/r_misc.o sdlquake-1.0.9/r_part.o sdlquake-1.0.9/r_sky.o sdlquake-1.0.9/r_sprite.o sdlquake-1.0.9/r_surf.o sdlquake-1.0.9/r_vars.o sdlquake-1.0.9/sbar.o sdlquake-1.0.9/screen.o sdlquake-1.0.9/snd_dma.o sdlquake-1.0.9/snd_mem.o sdlquake-1.0.9/snd_mix.o sdlquake-1.0.9/snd_sdl.o sdlquake-1.0.9/sv_main.o sdlquake-1.0.9/sv_move.o sdlquake-1.0.9/sv_phys.o sdlquake-1.0.9/sv_user.o sdlquake-1.0.9/sys_sdl.o sdlquake-1.0.9/vid_sdl.o sdlquake-1.0.9/view.o sdlquake-1.0.9/wad.o sdlquake-1.0.9/world.o sdlquake-1.0.9/zone.o sdlquake-1.0.9/d_vars.o sdlquake-1.0.9/nonintel.o

q1: setup
	make q1build

q1build: $(OBJS)
	@echo "-------- Example: Quake 1 (SWC only) --------"
	make -j2 link

link:
	cd $(BUILDDIR) && "$(FLASCC)/usr/bin/gcc" -jvmopt=-Xmx1G $(CFLAGS) $(OBJS) -lSDL -lvgl -o ../Quake1.swc -emit-swc=CrossBridge.quake1

linkmt:
	cd $(BUILDDIR) && "$(FLASCC)/usr/bin/gcc" -jvmopt=-Xmx1G $(CFLAGS) $(OBJS) -lSDL -lvgl -o ../Quake1MT.swc -emit-swc=CrossBridge.quake1 -pthread

include ../Makefile.common

setup:	
	mkdir -p $(BUILDDIR)/sdlquake-1.0.9	
	
clean:
	rm -rf $(BUILDDIR) *.swf

.c.o:
	"$(FLASCC)/usr/bin/gcc" $(CFLAGS) $(QUAKECFLAGS) -c $< -o $(BUILDDIR)/sdlquake-1.0.9/$(@F)
