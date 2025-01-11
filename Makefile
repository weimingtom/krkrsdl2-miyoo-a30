#0: pc (xubuntu 20.04 64bit)
#1: miyoo a30 and rg28xx
#2: trimui smart pro
#3: trimui brick
MIYOO := 0
BUILD_SDL2 := 0
#0: utf-8
#1: shift_jis
ENCODE := 1

#src/core/sdl2/SDLApplication.cpp, 640, 480
#ScriptMgnIntf.cpp, TVPGetSystemInitializeScript2()
#TODO:SysInitScript.tjs
#TODO:LD_LIBRARY_PATH
#b ScriptMgnIntf.cpp:3155, 3110
#gedit external/krkrz/base/ScriptMgnIntf.cpp
#if (name == ttstr(TJS_W("startup.tjs"))) {
#Scripts.execStorage(System.exePath + \"system_polyfill/PolyfillInitialize.tjs\"); // code injection
#exit(0);//FIXME:miyoo a30 exit directly

ifeq ($(MIYOO),3)
CC = /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-gcc
CPP := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-g++
AR := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ar cru
RANLIB := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ranlib 
else ifeq ($(MIYOO),2)
CC = /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-gcc
CPP := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-g++
AR := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ar cru
RANLIB := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ranlib 
else ifeq ($(MIYOO),1)
CC = /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc
CPP := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++
AR := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ar cru
RANLIB := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ranlib 
else
#sudo apt install libdbus-1-dev
#	external/SDL/src/core/linux/SDL_dbus.h
#sudo apt install libxkbcommon-dev
#	external/SDL/src/video/wayland/SDL_waylanddyn.h
#sudo apt install libudev-dev
#	external/SDL/src/core/linux/SDL_udev.h
#sudo apt install libasound2-dev
#	external/SDL/src/audio/alsa/SDL_alsa_audio.h
#sudo apt install libpulse-dev
#	external/SDL/src/audio/pulseaudio/SDL_pulseaudio.c
#sudo apt install libsndio-dev
#	external/SDL/src/audio/sndio/SDL_sndioaudio.h
#sudo apt install libx11-dev libxcursor-dev libxinerama-dev libxcb-xinput-dev libxi-dev libxss-dev libxxf86vm-dev
#	external/SDL/src/video/x11/SDL_x11video.h
#sudo apt install libibus-1.0-dev
#	external/SDL/src/core/linux/SDL_ibus.h
#sudo apt install libsdl2-dev
CC  := gcc
CPP := g++
AR  := ar cru
RANLIB := ranlib
endif
RM := rm -rf

CPPFLAGS := 
CPPFLAGS += -I.   
###CPPFLAGS += -g -O2
#CPPFLAGS += -g3 -O0
CPPFLAGS += -DNDEBUG
ifeq ($(MIYOO),3)
#trimui brick
CPPFLAGS += -DUSE_INPUT_MAPPING=3
CPPFLAGS += -g0 -O3
else ifeq ($(MIYOO),2)
#trimui smart pro
CPPFLAGS += -DUSE_INPUT_MAPPING=2 
CPPFLAGS += -g0 -O3
else ifeq ($(MIYOO),1)
#miyoo a30 or rg28xx
CPPFLAGS += -DUSE_INPUT_MAPPING=1
CPPFLAGS += -g0 -O3
else
#pc
CPPFLAGS += -DUSE_INPUT_MAPPING=2 #FIXME:
CPPFLAGS += -g3 -O0
endif

ifeq ($(ENCODE),1)
#shift_jis or utf-8
CPPFLAGS += -DTVP_TEXT_READ_ANSI_MBCS=1
#gbk or shift_jis or utf-8
CPPFLAGS += -DUSE_KIRIKIROID2_TEXTSTREAM=1
#.ogg vorbis sound decoder
#external/krkrz/sound/WaveIntf.cpp
CPPFLAGS += -DUSE_KIRIKIROID2_OGGVORBIS=1
#src/core/sdl2/SDLApplication.cpp, -DMIYOO
CPPFLAGS += -DUSE_DEBUG_INPUT=1
#src/core/base/sdl2/PluginImpl.cpp
CPPFLAGS += -DUSE_SKIP_PLUGIN=1 
#external/krkrz/visual/FreeType.cpp
CPPFLAGS += -DUSE_SKIP_FONT=1
#src/core/base/sdl2/ScriptMgnImpl.cpp
CPPFLAGS += -DUSE_POLYFILL=1
#external/krkrz/visual/LayerIntf.cpp
CPPFLAGS += -DUSE_NO_TRANSITION_ERROR=1
#Debug key mapping in TRIMUI SMART PRO:
#
#cd /mnt/SDCARD/Apps/krkrsdl2
#killall -KILL MainUI runtrimui.sh
#LD_LIBRARY_PATH=/usr/trimui/lib ./krkrsdl2
#

endif

ifeq ($(BUILD_SDL2),1)
#CPPFLAGS += -I/usr/include
#CPPFLAGS += -I/usr/include/libmount 
#CPPFLAGS += -I/usr/include/blkid 
CPPFLAGS += -I/usr/include/dbus-1.0 #<dbus/dbus.h>
CPPFLAGS += -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include  #<dbus/dbus-arch-deps.h>
CPPFLAGS += -I/usr/include/ibus-1.0 #<ibusversion.h>
CPPFLAGS += -I/usr/include/glib-2.0 #<glib.h>#/usr/include/ibus-1.0/ibusshare.h
CPPFLAGS += -I/usr/lib/x86_64-linux-gnu/glib-2.0/include #<glibconfig.h>

#CPPFLAGS += -I./build/external/SDL/include 
CPPFLAGS += -I./external/SDL/include 
CPPFLAGS += -I./external/SDL 
CPPFLAGS += -I./external/SDL/wayland-generated-protocols  

#CPPFLAGS += -idirafter "./external/SDL/src/video/khronos" 
CPPFLAGS += -I./external/SDL/src/video/khronos
else

ifeq ($(MIYOO),3)
CPPFLAGS += -I/home/wmt/work_trimui/usr/include/SDL2
else ifeq ($(MIYOO),2)
CPPFLAGS += -I/home/wmt/work_trimui/usr/include/SDL2
else ifeq ($(MIYOO),1)
CPPFLAGS += -I/home/wmt/work_a30/staging_dir/target/usr/include/SDL2
else
CPPFLAGS += -I/usr/include/SDL2
endif

endif

#only for make test6 crash
#CPPFLAGS += -DUSE_NO_SSE2=1

CPPFLAGS += -DUSING_GENERATED_CONFIG_H
CPPFLAGS += -DHAVE_LINUX_VERSION_H 
CPPFLAGS += -D_REENTRANT 

ifeq ($(MIYOO),3)
#trimui brick
CPPFLAGS += -DUSE_APP_WIDTH=1024
CPPFLAGS += -DUSE_APP_HEIGHT=768
CPPFLAGS += -DUSE_FIXED_WINDOW_SIZE=1
CPPFLAGS += -DUSE_ROTATE90=0
else ifeq ($(MIYOO),2)
#trimui smart pro
CPPFLAGS += -DUSE_APP_WIDTH=1280
CPPFLAGS += -DUSE_APP_HEIGHT=720
CPPFLAGS += -DUSE_FIXED_WINDOW_SIZE=1
CPPFLAGS += -DUSE_ROTATE90=0
else ifeq ($(MIYOO),1)
#miyoo a30 and rg28xx
CPPFLAGS += -DUSE_APP_WIDTH=640
CPPFLAGS += -DUSE_APP_HEIGHT=480
CPPFLAGS += -DUSE_FIXED_WINDOW_SIZE=1
CPPFLAGS += -DUSE_ROTATE90=1
else
#pc
CPPFLAGS += -DUSE_APP_WIDTH=640
CPPFLAGS += -DUSE_APP_HEIGHT=480
CPPFLAGS += -DUSE_FIXED_WINDOW_SIZE=1
CPPFLAGS += -DUSE_ROTATE90=0
endif

ifeq ($(MIYOO),3)
else ifeq ($(MIYOO),2)
else ifeq ($(MIYOO),1)
else
CPPFLAGS += -msse3 
CPPFLAGS += -msse2 
CPPFLAGS += -msse 
CPPFLAGS += -m3dnow 
CPPFLAGS += -mmmx 
endif

CPPFLAGS += -fno-strict-aliasing 
CPPFLAGS += -fvisibility=hidden 
CPPFLAGS += -Wshadow 

#only for c
#CPPFLAGS += -Wdeclaration-after-statement 

CPPFLAGS += -Wall

CPPFLAGS += -I./src/core/base/sdl2 
CPPFLAGS += -I./src/core/environ/sdl2 
CPPFLAGS += -I./src/core/msg/sdl2 
CPPFLAGS += -I./src/core/sdl2 
CPPFLAGS += -I./src/core/sound/sdl2 
CPPFLAGS += -I./src/core/utils/sdl2 
CPPFLAGS += -I./src/core/visual/sdl2
CPPFLAGS += -I./src/config 
CPPFLAGS += -I./src/plugins
CPPFLAGS += -I./external 
CPPFLAGS += -I./external/krkrz 
CPPFLAGS += -I./external/krkrz/base 
CPPFLAGS += -I./external/krkrz/environ 
CPPFLAGS += -I./external/krkrz/extension 
CPPFLAGS += -I./external/krkrz/msg 
CPPFLAGS += -I./external/krkrz/sound 
CPPFLAGS += -I./external/krkrz/tjs2 
CPPFLAGS += -I./external/krkrz/utils 
CPPFLAGS += -I./external/krkrz/visual 
CPPFLAGS += -I./external/krkrz/visual/IA32 
CPPFLAGS += -I./external/krkrz/visual/gl 
CPPFLAGS += -I./external/krkrz/visual/opengl 
CPPFLAGS += -I./external/krkrz/external 
CPPFLAGS += -I./external/krkrz/external/freetype/include 
CPPFLAGS += -I./external/krkrz/external/freetype/src 
CPPFLAGS += -I./external/krkrz/external/libjpeg-turbo 
CPPFLAGS += -I./external/krkrz/external/libogg/include 
CPPFLAGS += -I./external/krkrz/external/lpng 
CPPFLAGS += -I./external/krkrz/external/onig/src 
CPPFLAGS += -I./external/krkrz/external/opus/celt 
CPPFLAGS += -I./external/krkrz/external/opus/include 
CPPFLAGS += -I./external/krkrz/external/opus/silk 
CPPFLAGS += -I./external/krkrz/external/opus/silk/fixed 
CPPFLAGS += -I./external/krkrz/external/opus/silk/float 
CPPFLAGS += -I./external/krkrz/external/opusfile/include 
CPPFLAGS += -I./external/krkrz/external/opusfile/src 
CPPFLAGS += -I./external/simde 
CPPFLAGS += -I./external/zlib 
CPPFLAGS += -I./external/FAudio/src 
CPPFLAGS += -I./external/FAudio/include 
#CPPFLAGS += -I./external/SDL/include 
#CPPFLAGS += -I./build/external/SDL/include  

#vorbis
CPPFLAGS += -I./external/krkrz/external/libvorbis-1.2.0/include
###CPPFLAGS += -I./external/krkrz/external/libogg-1.1.3/include
CPPFLAGS += -I./external/krkrz/external/libvorbis-1.2.0/lib

CPPFLAGS += -DTVP_COMPILING_KRKRSDL2 
CPPFLAGS += -DTVP_OPUS_DECODER_IMPLEMENT 
CPPFLAGS += -DTVP_LOG_TO_COMMANDLINE_CONSOLE 
CPPFLAGS += -DHAVE_CONFIG_H 
CPPFLAGS += -DFT2_BUILD_LIBRARY 
CPPFLAGS += -DUSE_ALLOCA 
CPPFLAGS += -DOPUS_BUILD 
CPPFLAGS += -DHAVE_LRINTF 
CPPFLAGS += -DHAVE_LRINT 
CPPFLAGS += -DFLOAT_APPROX 
CPPFLAGS += -DPNG_ARM_NEON_OPT=0 
CPPFLAGS += -DKRKRSDL2_ENABLE_ASYNC_IMAGE_LOAD 
CPPFLAGS += -DKRKRZ_CASE_INSENSITIVE 
CPPFLAGS += -DKRKRSDL2_ENABLE_PLUGINS
CPPFLAGS += -DTVP_FAUDIO_IMPLEMENT  
CPPFLAGS += -fPIE 
CPPFLAGS += -fno-delete-null-pointer-checks 
CPPFLAGS += -pthread 
CPPFLAGS += -w 

#only for c++
#CPPFLAGS += -Wno-non-virtual-dtor 

CPPFLAGS += -std=gnu++14

#CPPFLAGS += -Winvalid-pch 
#CPPFLAGS += -include /home/wmt/work_krkrsdl2/krkrsdl2/build/CMakeFiles/krkrsdl2.dir/cmake_pch.hxx
CPPFLAGS += -include ./src/core/sdl2/SDLPrecompiledHeader.h

ifeq ($(MIYOO),3)
CPPFLAGS += 
else ifeq ($(MIYOO),2)
CPPFLAGS += 
else ifeq ($(MIYOO),1)
CPPFLAGS += 
else
#xubuntu 16
CPPFLAGS += 
endif



LDFLAGS := 

#LDFLAGS += -O2 -g -DNDEBUG  
LDFLAGS += -pthread  -lpthread 

#LDFLAGS += external/SDL/libSDL2.a 
#LDFLAGS += external/FAudio/libFAudio.a 

#LDFLAGS += -lm 
#LDFLAGS += -ldl 
#LDFLAGS += -ldbus-1 
#LDFLAGS += -libus-1.0 
#-lgio-2.0 -lgobject-2.0 
#LDFLAGS += -lglib-2.0 
#LDFLAGS += -lrt 
#LDFLAGS += -Wl,--no-undefined 
#-pthread
ifeq ($(BUILD_SDL2),1)
else

ifeq ($(MIYOO),3)
#./usr/lib/libSDL2.a
#./usr/lib/libSDL2main.a
LDFLAGS += -L/home/wmt/work_trimui/usr/lib
LDFLAGS += -lSDL2
else ifeq ($(MIYOO),2)
#./usr/lib/libSDL2.a
#./usr/lib/libSDL2main.a
LDFLAGS += -L/home/wmt/work_trimui/usr/lib
LDFLAGS += -lSDL2
else ifeq ($(MIYOO),1)
#./staging_dir/target/usr/lib/libSDL2.a
#./staging_dir/target/usr/lib/libSDL2main.a
#./sdk/sdk/usr/lib/libSDL2.a
#./sdk/sdk/usr/lib/libSDL2main.la
#./sdk/sdk/usr/lib/libSDL2main.a
LDFLAGS += -L/home/wmt/work_a30/staging_dir/target/usr/lib
LDFLAGS += -lSDL2
else
LDFLAGS += -lSDL2
endif

endif

OBJS := 

ifeq ($(BUILD_SDL2),1)
#libSDL2
OBJS += external/SDL/src/SDL.o
OBJS += external/SDL/src/SDL_assert.o
OBJS += external/SDL/src/SDL_dataqueue.o
OBJS += external/SDL/src/SDL_error.o
OBJS += external/SDL/src/SDL_hints.o
OBJS += external/SDL/src/SDL_list.o
OBJS += external/SDL/src/SDL_log.o
OBJS += external/SDL/src/atomic/SDL_atomic.o
OBJS += external/SDL/src/atomic/SDL_spinlock.o
OBJS += external/SDL/src/audio/SDL_audio.o
OBJS += external/SDL/src/audio/SDL_audiocvt.o
OBJS += external/SDL/src/audio/SDL_audiodev.o
OBJS += external/SDL/src/audio/SDL_audiotypecvt.o
OBJS += external/SDL/src/audio/SDL_mixer.o
OBJS += external/SDL/src/audio/SDL_wave.o
OBJS += external/SDL/src/cpuinfo/SDL_cpuinfo.o
OBJS += external/SDL/src/dynapi/SDL_dynapi.o
OBJS += external/SDL/src/events/SDL_clipboardevents.o
OBJS += external/SDL/src/events/SDL_displayevents.o
OBJS += external/SDL/src/events/SDL_dropevents.o
OBJS += external/SDL/src/events/SDL_events.o
OBJS += external/SDL/src/events/SDL_gesture.o
OBJS += external/SDL/src/events/SDL_keyboard.o
OBJS += external/SDL/src/events/SDL_mouse.o
OBJS += external/SDL/src/events/SDL_quit.o
OBJS += external/SDL/src/events/SDL_touch.o
OBJS += external/SDL/src/events/SDL_windowevents.o
OBJS += external/SDL/src/events/imKStoUCS.o
OBJS += external/SDL/src/file/SDL_rwops.o
OBJS += external/SDL/src/haptic/SDL_haptic.o
OBJS += external/SDL/src/hidapi/SDL_hidapi.o
OBJS += external/SDL/src/joystick/SDL_gamecontroller.o
OBJS += external/SDL/src/joystick/SDL_joystick.o
OBJS += external/SDL/src/libm/e_atan2.o
OBJS += external/SDL/src/libm/e_exp.o
OBJS += external/SDL/src/libm/e_fmod.o
OBJS += external/SDL/src/libm/e_log.o
OBJS += external/SDL/src/libm/e_log10.o
OBJS += external/SDL/src/libm/e_pow.o
OBJS += external/SDL/src/libm/e_rem_pio2.o
OBJS += external/SDL/src/libm/e_sqrt.o
OBJS += external/SDL/src/libm/k_cos.o
OBJS += external/SDL/src/libm/k_rem_pio2.o
OBJS += external/SDL/src/libm/k_sin.o
OBJS += external/SDL/src/libm/k_tan.o
OBJS += external/SDL/src/libm/s_atan.o
OBJS += external/SDL/src/libm/s_copysign.o
OBJS += external/SDL/src/libm/s_cos.o
OBJS += external/SDL/src/libm/s_fabs.o
OBJS += external/SDL/src/libm/s_floor.o
OBJS += external/SDL/src/libm/s_scalbn.o
OBJS += external/SDL/src/libm/s_sin.o
OBJS += external/SDL/src/libm/s_tan.o
OBJS += external/SDL/src/locale/SDL_locale.o
OBJS += external/SDL/src/misc/SDL_url.o
OBJS += external/SDL/src/power/SDL_power.o
OBJS += external/SDL/src/render/SDL_d3dmath.o
OBJS += external/SDL/src/render/SDL_render.o
OBJS += external/SDL/src/render/SDL_yuv_sw.o
OBJS += external/SDL/src/render/direct3d/SDL_render_d3d.o
OBJS += external/SDL/src/render/direct3d/SDL_shaders_d3d.o
OBJS += external/SDL/src/render/direct3d11/SDL_render_d3d11.o
OBJS += external/SDL/src/render/direct3d11/SDL_shaders_d3d11.o
OBJS += external/SDL/src/render/opengl/SDL_render_gl.o
OBJS += external/SDL/src/render/opengl/SDL_shaders_gl.o
OBJS += external/SDL/src/render/opengles/SDL_render_gles.o
OBJS += external/SDL/src/render/opengles2/SDL_render_gles2.o
OBJS += external/SDL/src/render/opengles2/SDL_shaders_gles2.o
OBJS += external/SDL/src/render/psp/SDL_render_psp.o
OBJS += external/SDL/src/render/software/SDL_blendfillrect.o
OBJS += external/SDL/src/render/software/SDL_blendline.o
OBJS += external/SDL/src/render/software/SDL_blendpoint.o
OBJS += external/SDL/src/render/software/SDL_drawline.o
OBJS += external/SDL/src/render/software/SDL_drawpoint.o
OBJS += external/SDL/src/render/software/SDL_render_sw.o
OBJS += external/SDL/src/render/software/SDL_rotate.o
OBJS += external/SDL/src/render/software/SDL_triangle.o
OBJS += external/SDL/src/render/vitagxm/SDL_render_vita_gxm.o
OBJS += external/SDL/src/render/vitagxm/SDL_render_vita_gxm_memory.o
OBJS += external/SDL/src/render/vitagxm/SDL_render_vita_gxm_tools.o
OBJS += external/SDL/src/sensor/SDL_sensor.o
OBJS += external/SDL/src/stdlib/SDL_crc32.o
OBJS += external/SDL/src/stdlib/SDL_getenv.o
OBJS += external/SDL/src/stdlib/SDL_iconv.o
OBJS += external/SDL/src/stdlib/SDL_malloc.o
OBJS += external/SDL/src/stdlib/SDL_qsort.o
OBJS += external/SDL/src/stdlib/SDL_stdlib.o
OBJS += external/SDL/src/stdlib/SDL_string.o
OBJS += external/SDL/src/stdlib/SDL_strtokr.o
OBJS += external/SDL/src/thread/SDL_thread.o
OBJS += external/SDL/src/timer/SDL_timer.o
OBJS += external/SDL/src/video/SDL_RLEaccel.o
OBJS += external/SDL/src/video/SDL_blit.o
OBJS += external/SDL/src/video/SDL_blit_0.o
OBJS += external/SDL/src/video/SDL_blit_1.o
OBJS += external/SDL/src/video/SDL_blit_A.o
OBJS += external/SDL/src/video/SDL_blit_N.o
OBJS += external/SDL/src/video/SDL_blit_auto.o
OBJS += external/SDL/src/video/SDL_blit_copy.o
OBJS += external/SDL/src/video/SDL_blit_slow.o
OBJS += external/SDL/src/video/SDL_bmp.o
OBJS += external/SDL/src/video/SDL_clipboard.o
OBJS += external/SDL/src/video/SDL_egl.o
OBJS += external/SDL/src/video/SDL_fillrect.o
OBJS += external/SDL/src/video/SDL_pixels.o
OBJS += external/SDL/src/video/SDL_rect.o
OBJS += external/SDL/src/video/SDL_shape.o
OBJS += external/SDL/src/video/SDL_stretch.o
OBJS += external/SDL/src/video/SDL_surface.o
OBJS += external/SDL/src/video/SDL_video.o
OBJS += external/SDL/src/video/SDL_vulkan_utils.o
OBJS += external/SDL/src/video/SDL_yuv.o
OBJS += external/SDL/src/video/yuv2rgb/yuv_rgb.o
OBJS += external/SDL/src/audio/dummy/SDL_dummyaudio.o
OBJS += external/SDL/src/audio/disk/SDL_diskaudio.o
OBJS += external/SDL/src/loadso/dlopen/SDL_sysloadso.o
OBJS += external/SDL/src/joystick/virtual/SDL_virtualjoystick.o
OBJS += external/SDL/src/video/dummy/SDL_nullevents.o
OBJS += external/SDL/src/video/dummy/SDL_nullframebuffer.o
OBJS += external/SDL/src/video/dummy/SDL_nullvideo.o
OBJS += external/SDL/src/audio/dsp/SDL_dspaudio.o
OBJS += external/SDL/src/audio/alsa/SDL_alsa_audio.o
OBJS += external/SDL/src/audio/pulseaudio/SDL_pulseaudio.o
OBJS += external/SDL/src/audio/sndio/SDL_sndioaudio.o
OBJS += external/SDL/src/video/x11/SDL_x11clipboard.o
OBJS += external/SDL/src/video/x11/SDL_x11dyn.o
OBJS += external/SDL/src/video/x11/SDL_x11events.o
OBJS += external/SDL/src/video/x11/SDL_x11framebuffer.o
OBJS += external/SDL/src/video/x11/SDL_x11keyboard.o
OBJS += external/SDL/src/video/x11/SDL_x11messagebox.o
OBJS += external/SDL/src/video/x11/SDL_x11modes.o
OBJS += external/SDL/src/video/x11/SDL_x11mouse.o
OBJS += external/SDL/src/video/x11/SDL_x11opengl.o
OBJS += external/SDL/src/video/x11/SDL_x11opengles.o
OBJS += external/SDL/src/video/x11/SDL_x11shape.o
OBJS += external/SDL/src/video/x11/SDL_x11touch.o
OBJS += external/SDL/src/video/x11/SDL_x11video.o
OBJS += external/SDL/src/video/x11/SDL_x11vulkan.o
OBJS += external/SDL/src/video/x11/SDL_x11window.o
OBJS += external/SDL/src/video/x11/SDL_x11xfixes.o
OBJS += external/SDL/src/video/x11/SDL_x11xinput2.o
OBJS += external/SDL/src/video/x11/edid-parse.o
OBJS += external/SDL/src/video/wayland/SDL_waylandclipboard.o
OBJS += external/SDL/src/video/wayland/SDL_waylanddatamanager.o
OBJS += external/SDL/src/video/wayland/SDL_waylanddyn.o
OBJS += external/SDL/src/video/wayland/SDL_waylandevents.o
OBJS += external/SDL/src/video/wayland/SDL_waylandkeyboard.o
OBJS += external/SDL/src/video/wayland/SDL_waylandmessagebox.o
OBJS += external/SDL/src/video/wayland/SDL_waylandmouse.o
OBJS += external/SDL/src/video/wayland/SDL_waylandopengles.o
OBJS += external/SDL/src/video/wayland/SDL_waylandtouch.o
OBJS += external/SDL/src/video/wayland/SDL_waylandvideo.o
OBJS += external/SDL/src/video/wayland/SDL_waylandvulkan.o
OBJS += external/SDL/src/video/wayland/SDL_waylandwindow.o
OBJS += external/SDL/wayland-generated-protocols/idle-inhibit-unstable-v1-protocol.o
OBJS += external/SDL/wayland-generated-protocols/keyboard-shortcuts-inhibit-unstable-v1-protocol.o
OBJS += external/SDL/wayland-generated-protocols/pointer-constraints-unstable-v1-protocol.o
OBJS += external/SDL/wayland-generated-protocols/relative-pointer-unstable-v1-protocol.o
OBJS += external/SDL/wayland-generated-protocols/tablet-unstable-v2-protocol.o
OBJS += external/SDL/wayland-generated-protocols/text-input-unstable-v3-protocol.o
OBJS += external/SDL/wayland-generated-protocols/viewporter-protocol.o
OBJS += external/SDL/wayland-generated-protocols/wayland-protocol.o
OBJS += external/SDL/wayland-generated-protocols/xdg-activation-v1-protocol.o
OBJS += external/SDL/wayland-generated-protocols/xdg-decoration-unstable-v1-protocol.o
OBJS += external/SDL/wayland-generated-protocols/xdg-output-unstable-v1-protocol.o
OBJS += external/SDL/wayland-generated-protocols/xdg-shell-protocol.o
OBJS += external/SDL/src/core/unix/SDL_poll.o
OBJS += external/SDL/src/haptic/linux/SDL_syshaptic.o
OBJS += external/SDL/src/core/linux/SDL_dbus.o
OBJS += external/SDL/src/core/linux/SDL_ime.o
OBJS += external/SDL/src/core/linux/SDL_ibus.o
OBJS += external/SDL/src/core/linux/SDL_fcitx.o
OBJS += external/SDL/src/core/linux/SDL_udev.o
OBJS += external/SDL/src/core/linux/SDL_evdev.o
OBJS += external/SDL/src/core/linux/SDL_evdev_kbd.o
OBJS += external/SDL/src/core/linux/SDL_evdev_capabilities.o
OBJS += external/SDL/src/core/linux/SDL_threadprio.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_gamecube.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_luna.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_ps4.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_ps5.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_rumble.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_stadia.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_steam.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_switch.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_xbox360.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_xbox360w.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapi_xboxone.o
OBJS += external/SDL/src/joystick/hidapi/SDL_hidapijoystick.o
OBJS += external/SDL/src/joystick/linux/SDL_sysjoystick.o
OBJS += external/SDL/src/joystick/steam/SDL_steamcontroller.o
OBJS += external/SDL/src/thread/pthread/SDL_systhread.o
OBJS += external/SDL/src/thread/pthread/SDL_sysmutex.o
OBJS += external/SDL/src/thread/pthread/SDL_syscond.o
OBJS += external/SDL/src/thread/pthread/SDL_systls.o
OBJS += external/SDL/src/thread/pthread/SDL_syssem.o
OBJS += external/SDL/src/misc/unix/SDL_sysurl.o
OBJS += external/SDL/src/power/linux/SDL_syspower.o
OBJS += external/SDL/src/locale/unix/SDL_syslocale.o
OBJS += external/SDL/src/filesystem/unix/SDL_sysfilesystem.o
OBJS += external/SDL/src/timer/unix/SDL_systimer.o
OBJS += external/SDL/src/sensor/dummy/SDL_dummysensor.o
endif

#libFAudio.a
OBJS += external/FAudio/src/F3DAudio.o
OBJS += external/FAudio/src/F3DAudio.o
OBJS += external/FAudio/src/FACT3D.o
OBJS += external/FAudio/src/FACT.o
OBJS += external/FAudio/src/FACT_internal.o
OBJS += external/FAudio/src/FAPOBase.o
OBJS += external/FAudio/src/FAPOFX.o
OBJS += external/FAudio/src/FAPOFX_echo.o
OBJS += external/FAudio/src/FAPOFX_eq.o
OBJS += external/FAudio/src/FAPOFX_masteringlimiter.o
OBJS += external/FAudio/src/FAPOFX_reverb.o
OBJS += external/FAudio/src/FAudio.o
OBJS += external/FAudio/src/FAudioFX_reverb.o
OBJS += external/FAudio/src/FAudioFX_volumemeter.o
OBJS += external/FAudio/src/FAudio_internal.o
OBJS += external/FAudio/src/FAudio_internal_simd.o
OBJS += external/FAudio/src/FAudio_operationset.o
OBJS += external/FAudio/src/FAudio_platform_sdl2.o
OBJS += external/FAudio/src/FAudio_platform_win32.o
OBJS += external/FAudio/src/XNA_Song.o

#krkrz
OBJS += external/krkrz/base/BinaryStream.o
OBJS += external/krkrz/base/CharacterSet.o
OBJS += external/krkrz/base/EventIntf.o
OBJS += external/krkrz/base/PluginIntf.o
OBJS += external/krkrz/base/ScriptMgnIntf.o
OBJS += external/krkrz/base/StorageIntf.o
OBJS += external/krkrz/base/SysInitIntf.o
OBJS += external/krkrz/base/SystemIntf.o
OBJS += external/krkrz/base/TextStream.o
OBJS += external/krkrz/base/UtilStreams.o
OBJS += external/krkrz/base/XP3Archive.o
OBJS += external/krkrz/extension/Extension.o
OBJS += external/krkrz/msg/MsgIntf.o
OBJS += external/krkrz/sound/MathAlgorithms.o
OBJS += external/krkrz/sound/OpusCodecDecoder.o
#
#WaveIntf.cpp: TVPRegisterOpusDecoderCreator
#
OBJS += external/krkrz/sound/PhaseVocoderDSP.o
OBJS += external/krkrz/sound/PhaseVocoderFilter.o
OBJS += external/krkrz/sound/QueueSoundBufferImpl.o
OBJS += external/krkrz/sound/RealFFT.o
OBJS += external/krkrz/sound/SoundBufferBaseImpl.o
OBJS += external/krkrz/sound/SoundBufferBaseIntf.o
OBJS += external/krkrz/sound/SoundDecodeThread.o
OBJS += external/krkrz/sound/SoundEventThread.o
OBJS += external/krkrz/sound/SoundPlayer.o
OBJS += external/krkrz/sound/WaveFormatConverter.o
OBJS += external/krkrz/sound/WaveIntf.o
OBJS += external/krkrz/sound/WaveLoopManager.o
OBJS += external/krkrz/sound/WaveSegmentQueue.o
OBJS += external/krkrz/sound/xmmlib.o
OBJS += external/krkrz/tjs2/tjs.o
OBJS += external/krkrz/tjs2/tjs.tab.o
OBJS += external/krkrz/tjs2/tjsArray.o
OBJS += external/krkrz/tjs2/tjsBinarySerializer.o
OBJS += external/krkrz/tjs2/tjsByteCodeLoader.o
OBJS += external/krkrz/tjs2/tjsCompileControl.o
OBJS += external/krkrz/tjs2/tjsConfig.o
OBJS += external/krkrz/tjs2/tjsConstArrayData.o
OBJS += external/krkrz/tjs2/tjsDate.o
OBJS += external/krkrz/tjs2/tjsDateParser.o
OBJS += external/krkrz/tjs2/tjsDebug.o
OBJS += external/krkrz/tjs2/tjsDictionary.o
OBJS += external/krkrz/tjs2/tjsDisassemble.o
OBJS += external/krkrz/tjs2/tjsError.o
OBJS += external/krkrz/tjs2/tjsException.o
OBJS += external/krkrz/tjs2/tjsGlobalStringMap.o
OBJS += external/krkrz/tjs2/tjsInterCodeExec.o
OBJS += external/krkrz/tjs2/tjsInterCodeGen.o
OBJS += external/krkrz/tjs2/tjsInterface.o
OBJS += external/krkrz/tjs2/tjsLex.o
OBJS += external/krkrz/tjs2/tjsMT19937ar-cok.o
OBJS += external/krkrz/tjs2/tjsMath.o
OBJS += external/krkrz/tjs2/tjsMessage.o
OBJS += external/krkrz/tjs2/tjsNamespace.o
OBJS += external/krkrz/tjs2/tjsNative.o
OBJS += external/krkrz/tjs2/tjsObject.o
OBJS += external/krkrz/tjs2/tjsObjectExtendable.o
OBJS += external/krkrz/tjs2/tjsOctPack.o
OBJS += external/krkrz/tjs2/tjsRandomGenerator.o
OBJS += external/krkrz/tjs2/tjsRegExp.o
OBJS += external/krkrz/tjs2/tjsScriptBlock.o
OBJS += external/krkrz/tjs2/tjsScriptCache.o
OBJS += external/krkrz/tjs2/tjsSnprintf.o
OBJS += external/krkrz/tjs2/tjsString.o
OBJS += external/krkrz/tjs2/tjsUtils.o
OBJS += external/krkrz/tjs2/tjsVariant.o
OBJS += external/krkrz/tjs2/tjsVariantString.o
OBJS += external/krkrz/tjs2/tjsdate.tab.o
OBJS += external/krkrz/tjs2/tjspp.tab.o
OBJS += external/krkrz/utils/ClipboardIntf.o
OBJS += external/krkrz/utils/DebugIntf.o
OBJS += external/krkrz/utils/MiscUtility.o
OBJS += external/krkrz/utils/Random.o
OBJS += external/krkrz/utils/TVPTimer.o
OBJS += external/krkrz/utils/ThreadIntf.o
OBJS += external/krkrz/utils/TickCount.o
OBJS += external/krkrz/utils/TimerIntf.o
OBJS += external/krkrz/utils/TimerThread.o
OBJS += external/krkrz/utils/VelocityTracker.o
OBJS += external/krkrz/utils/cp932_uni.o
OBJS += external/krkrz/utils/md5.o
OBJS += external/krkrz/utils/uni_cp932.o
OBJS += external/krkrz/visual/BitmapIntf.o
OBJS += external/krkrz/visual/BitmapLayerTreeOwner.o
OBJS += external/krkrz/visual/CharacterData.o
OBJS += external/krkrz/visual/ComplexRect.o
OBJS += external/krkrz/visual/DrawDevice.o
OBJS += external/krkrz/visual/FontSystem.o
OBJS += external/krkrz/visual/FreeType.o
OBJS += external/krkrz/visual/FreeTypeFontRasterizer.o
OBJS += external/krkrz/visual/GraphicsLoadThread.o
OBJS += external/krkrz/visual/GraphicsLoaderIntf.o
OBJS += external/krkrz/visual/ImageFunction.o
OBJS += external/krkrz/visual/LayerBitmapImpl.o
OBJS += external/krkrz/visual/LayerBitmapIntf.o
OBJS += external/krkrz/visual/LayerIntf.o
OBJS += external/krkrz/visual/LayerManager.o
OBJS += external/krkrz/visual/LayerTreeOwnerImpl.o
OBJS += external/krkrz/visual/LoadJPEG.o
OBJS += external/krkrz/visual/LoadPNG.o
OBJS += external/krkrz/visual/LoadTLG.o
OBJS += external/krkrz/visual/NullDrawDevice.o
OBJS += external/krkrz/visual/PrerenderedFont.o
OBJS += external/krkrz/visual/RectItf.o
OBJS += external/krkrz/visual/SaveTLG5.o
OBJS += external/krkrz/visual/SaveTLG6.o
OBJS += external/krkrz/visual/TransIntf.o
OBJS += external/krkrz/visual/VideoOvlIntf.o
OBJS += external/krkrz/visual/WindowIntf.o
OBJS += external/krkrz/visual/gl/ResampleImage.o
OBJS += external/krkrz/visual/gl/WeightFunctor.o
OBJS += external/krkrz/visual/gl/blend_function.o
OBJS += external/krkrz/visual/gl/x86simdutil.o
OBJS += external/krkrz/visual/tvpgl.o

#freetype
OBJS += external/krkrz/external/freetype/src/autofit/autofit.o
OBJS += external/krkrz/external/freetype/src/base/ftbase.o
OBJS += external/krkrz/external/freetype/src/base/ftbbox.o
OBJS += external/krkrz/external/freetype/src/base/ftbitmap.o
OBJS += external/krkrz/external/freetype/src/base/ftfntfmt.o
OBJS += external/krkrz/external/freetype/src/base/ftfstype.o
OBJS += external/krkrz/external/freetype/src/base/ftgasp.o
OBJS += external/krkrz/external/freetype/src/base/ftglyph.o
OBJS += external/krkrz/external/freetype/src/base/ftgxval.o
OBJS += external/krkrz/external/freetype/src/base/ftinit.o
OBJS += external/krkrz/external/freetype/src/base/ftlcdfil.o
OBJS += external/krkrz/external/freetype/src/base/ftmm.o
OBJS += external/krkrz/external/freetype/src/base/ftotval.o
OBJS += external/krkrz/external/freetype/src/base/ftpatent.o
OBJS += external/krkrz/external/freetype/src/base/ftpfr.o
OBJS += external/krkrz/external/freetype/src/base/ftstroke.o
OBJS += external/krkrz/external/freetype/src/base/ftsynth.o
OBJS += external/krkrz/external/freetype/src/base/ftsystem.o
OBJS += external/krkrz/external/freetype/src/base/fttype1.o
OBJS += external/krkrz/external/freetype/src/base/ftwinfnt.o
OBJS += external/krkrz/external/freetype/src/bdf/bdf.o
OBJS += external/krkrz/external/freetype/src/cache/ftcache.o
OBJS += external/krkrz/external/freetype/src/cff/cff.o
OBJS += external/krkrz/external/freetype/src/cid/type1cid.o
OBJS += external/krkrz/external/freetype/src/gzip/ftgzip.o
OBJS += external/krkrz/external/freetype/src/lzw/ftlzw.o
OBJS += external/krkrz/external/freetype/src/pcf/pcf.o
OBJS += external/krkrz/external/freetype/src/pfr/pfr.o
OBJS += external/krkrz/external/freetype/src/psaux/psaux.o
OBJS += external/krkrz/external/freetype/src/pshinter/pshinter.o
OBJS += external/krkrz/external/freetype/src/psnames/psmodule.o
OBJS += external/krkrz/external/freetype/src/raster/raster.o
OBJS += external/krkrz/external/freetype/src/sfnt/sfnt.o
OBJS += external/krkrz/external/freetype/src/smooth/smooth.o
OBJS += external/krkrz/external/freetype/src/truetype/truetype.o
OBJS += external/krkrz/external/freetype/src/type1/type1.o
OBJS += external/krkrz/external/freetype/src/type42/type42.o
OBJS += external/krkrz/external/freetype/src/winfonts/winfnt.o

#libjpeg-turbo
OBJS += external/krkrz/external/libjpeg-turbo/jaricom.o
OBJS += external/krkrz/external/libjpeg-turbo/jcapimin.o
OBJS += external/krkrz/external/libjpeg-turbo/jcapistd.o
OBJS += external/krkrz/external/libjpeg-turbo/jcarith.o
OBJS += external/krkrz/external/libjpeg-turbo/jccoefct.o
OBJS += external/krkrz/external/libjpeg-turbo/jccolor.o
OBJS += external/krkrz/external/libjpeg-turbo/jcdctmgr.o
OBJS += external/krkrz/external/libjpeg-turbo/jchuff.o
OBJS += external/krkrz/external/libjpeg-turbo/jcinit.o
OBJS += external/krkrz/external/libjpeg-turbo/jcmainct.o
OBJS += external/krkrz/external/libjpeg-turbo/jcmarker.o
OBJS += external/krkrz/external/libjpeg-turbo/jcmaster.o
OBJS += external/krkrz/external/libjpeg-turbo/jcomapi.o
OBJS += external/krkrz/external/libjpeg-turbo/jcparam.o
OBJS += external/krkrz/external/libjpeg-turbo/jcphuff.o
OBJS += external/krkrz/external/libjpeg-turbo/jcprepct.o
OBJS += external/krkrz/external/libjpeg-turbo/jcsample.o
OBJS += external/krkrz/external/libjpeg-turbo/jctrans.o
OBJS += external/krkrz/external/libjpeg-turbo/jdapimin.o
OBJS += external/krkrz/external/libjpeg-turbo/jdapistd.o
OBJS += external/krkrz/external/libjpeg-turbo/jdarith.o
OBJS += external/krkrz/external/libjpeg-turbo/jdatadst-tj.o
OBJS += external/krkrz/external/libjpeg-turbo/jdatadst.o
OBJS += external/krkrz/external/libjpeg-turbo/jdatasrc-tj.o
OBJS += external/krkrz/external/libjpeg-turbo/jdatasrc.o
OBJS += external/krkrz/external/libjpeg-turbo/jdcoefct.o
OBJS += external/krkrz/external/libjpeg-turbo/jdcolor.o
OBJS += external/krkrz/external/libjpeg-turbo/jddctmgr.o
OBJS += external/krkrz/external/libjpeg-turbo/jdhuff.o
OBJS += external/krkrz/external/libjpeg-turbo/jdinput.o
OBJS += external/krkrz/external/libjpeg-turbo/jdmainct.o
OBJS += external/krkrz/external/libjpeg-turbo/jdmarker.o
OBJS += external/krkrz/external/libjpeg-turbo/jdmaster.o
OBJS += external/krkrz/external/libjpeg-turbo/jdmerge.o
OBJS += external/krkrz/external/libjpeg-turbo/jdphuff.o
OBJS += external/krkrz/external/libjpeg-turbo/jdpostct.o
OBJS += external/krkrz/external/libjpeg-turbo/jdsample.o
OBJS += external/krkrz/external/libjpeg-turbo/jdtrans.o
OBJS += external/krkrz/external/libjpeg-turbo/jerror.o
OBJS += external/krkrz/external/libjpeg-turbo/jfdctflt.o
OBJS += external/krkrz/external/libjpeg-turbo/jfdctfst.o
OBJS += external/krkrz/external/libjpeg-turbo/jfdctint.o
OBJS += external/krkrz/external/libjpeg-turbo/jidctflt.o
OBJS += external/krkrz/external/libjpeg-turbo/jidctfst.o
OBJS += external/krkrz/external/libjpeg-turbo/jidctint.o
OBJS += external/krkrz/external/libjpeg-turbo/jidctred.o
OBJS += external/krkrz/external/libjpeg-turbo/jmemmgr.o
OBJS += external/krkrz/external/libjpeg-turbo/jmemnobs.o
OBJS += external/krkrz/external/libjpeg-turbo/jquant1.o
OBJS += external/krkrz/external/libjpeg-turbo/jquant2.o
OBJS += external/krkrz/external/libjpeg-turbo/jsimd_none.o
OBJS += external/krkrz/external/libjpeg-turbo/jutils.o
OBJS += external/krkrz/external/libjpeg-turbo/transupp.o
OBJS += external/krkrz/external/libjpeg-turbo/turbojpeg.o

#libogg
OBJS += external/krkrz/external/libogg/src/bitwise.o
OBJS += external/krkrz/external/libogg/src/framing.o

#lpng
OBJS += external/krkrz/external/lpng/png.o
OBJS += external/krkrz/external/lpng/pngerror.o
OBJS += external/krkrz/external/lpng/pngget.o
OBJS += external/krkrz/external/lpng/pngmem.o
OBJS += external/krkrz/external/lpng/pngpread.o
OBJS += external/krkrz/external/lpng/pngread.o
OBJS += external/krkrz/external/lpng/pngrio.o
OBJS += external/krkrz/external/lpng/pngrtran.o
OBJS += external/krkrz/external/lpng/pngrutil.o
OBJS += external/krkrz/external/lpng/pngset.o
OBJS += external/krkrz/external/lpng/pngtrans.o
OBJS += external/krkrz/external/lpng/pngwio.o
OBJS += external/krkrz/external/lpng/pngwrite.o
OBJS += external/krkrz/external/lpng/pngwtran.o
OBJS += external/krkrz/external/lpng/pngwutil.o

#onig
OBJS += external/krkrz/external/onig/src/ascii.o
OBJS += external/krkrz/external/onig/src/big5.o
OBJS += external/krkrz/external/onig/src/cp1251.o
OBJS += external/krkrz/external/onig/src/euc_jp.o
OBJS += external/krkrz/external/onig/src/euc_jp_prop.o
OBJS += external/krkrz/external/onig/src/euc_kr.o
OBJS += external/krkrz/external/onig/src/euc_tw.o
OBJS += external/krkrz/external/onig/src/gb18030.o
OBJS += external/krkrz/external/onig/src/iso8859_1.o
OBJS += external/krkrz/external/onig/src/iso8859_10.o
OBJS += external/krkrz/external/onig/src/iso8859_11.o
OBJS += external/krkrz/external/onig/src/iso8859_13.o
OBJS += external/krkrz/external/onig/src/iso8859_14.o
OBJS += external/krkrz/external/onig/src/iso8859_15.o
OBJS += external/krkrz/external/onig/src/iso8859_16.o
OBJS += external/krkrz/external/onig/src/iso8859_2.o
OBJS += external/krkrz/external/onig/src/iso8859_3.o
OBJS += external/krkrz/external/onig/src/iso8859_4.o
OBJS += external/krkrz/external/onig/src/iso8859_5.o
OBJS += external/krkrz/external/onig/src/iso8859_6.o
OBJS += external/krkrz/external/onig/src/iso8859_7.o
OBJS += external/krkrz/external/onig/src/iso8859_8.o
OBJS += external/krkrz/external/onig/src/iso8859_9.o
OBJS += external/krkrz/external/onig/src/koi8_r.o
OBJS += external/krkrz/external/onig/src/onig_init.o
OBJS += external/krkrz/external/onig/src/regcomp.o
OBJS += external/krkrz/external/onig/src/regenc.o
OBJS += external/krkrz/external/onig/src/regerror.o
OBJS += external/krkrz/external/onig/src/regexec.o
OBJS += external/krkrz/external/onig/src/regext.o
OBJS += external/krkrz/external/onig/src/reggnu.o
OBJS += external/krkrz/external/onig/src/regparse.o
OBJS += external/krkrz/external/onig/src/regsyntax.o
OBJS += external/krkrz/external/onig/src/regtrav.o
OBJS += external/krkrz/external/onig/src/regversion.o
OBJS += external/krkrz/external/onig/src/sjis.o
OBJS += external/krkrz/external/onig/src/sjis_prop.o
OBJS += external/krkrz/external/onig/src/st.o
OBJS += external/krkrz/external/onig/src/unicode.o
OBJS += external/krkrz/external/onig/src/unicode_fold1_key.o
OBJS += external/krkrz/external/onig/src/unicode_fold2_key.o
OBJS += external/krkrz/external/onig/src/unicode_fold3_key.o
OBJS += external/krkrz/external/onig/src/unicode_unfold_key.o
OBJS += external/krkrz/external/onig/src/utf16_be.o
OBJS += external/krkrz/external/onig/src/utf16_le.o
OBJS += external/krkrz/external/onig/src/utf32_be.o
OBJS += external/krkrz/external/onig/src/utf32_le.o
OBJS += external/krkrz/external/onig/src/utf8.o

#opus
OBJS += external/krkrz/external/opus/celt/bands.o
OBJS += external/krkrz/external/opus/celt/celt.o
OBJS += external/krkrz/external/opus/celt/celt_decoder.o
OBJS += external/krkrz/external/opus/celt/celt_encoder.o
OBJS += external/krkrz/external/opus/celt/celt_lpc.o
OBJS += external/krkrz/external/opus/celt/cwrs.o
OBJS += external/krkrz/external/opus/celt/entcode.o
OBJS += external/krkrz/external/opus/celt/entdec.o
OBJS += external/krkrz/external/opus/celt/entenc.o
OBJS += external/krkrz/external/opus/celt/kiss_fft.o
OBJS += external/krkrz/external/opus/celt/laplace.o
OBJS += external/krkrz/external/opus/celt/mathops.o
OBJS += external/krkrz/external/opus/celt/mdct.o
OBJS += external/krkrz/external/opus/celt/modes.o
OBJS += external/krkrz/external/opus/celt/pitch.o
OBJS += external/krkrz/external/opus/celt/quant_bands.o
OBJS += external/krkrz/external/opus/celt/rate.o
OBJS += external/krkrz/external/opus/celt/vq.o
OBJS += external/krkrz/external/opus/silk/A2NLSF.o
OBJS += external/krkrz/external/opus/silk/CNG.o
OBJS += external/krkrz/external/opus/silk/HP_variable_cutoff.o
OBJS += external/krkrz/external/opus/silk/LPC_analysis_filter.o
OBJS += external/krkrz/external/opus/silk/LPC_inv_pred_gain.o
OBJS += external/krkrz/external/opus/silk/LP_variable_cutoff.o
OBJS += external/krkrz/external/opus/silk/NLSF2A.o
OBJS += external/krkrz/external/opus/silk/NLSF_VQ.o
OBJS += external/krkrz/external/opus/silk/NLSF_VQ_weights_laroia.o
OBJS += external/krkrz/external/opus/silk/NLSF_decode.o
OBJS += external/krkrz/external/opus/silk/NLSF_del_dec_quant.o
OBJS += external/krkrz/external/opus/silk/NLSF_encode.o
OBJS += external/krkrz/external/opus/silk/NLSF_stabilize.o
OBJS += external/krkrz/external/opus/silk/NLSF_unpack.o
OBJS += external/krkrz/external/opus/silk/NSQ.o
OBJS += external/krkrz/external/opus/silk/NSQ_del_dec.o
OBJS += external/krkrz/external/opus/silk/PLC.o
OBJS += external/krkrz/external/opus/silk/VAD.o
OBJS += external/krkrz/external/opus/silk/VQ_WMat_EC.o
OBJS += external/krkrz/external/opus/silk/ana_filt_bank_1.o
OBJS += external/krkrz/external/opus/silk/biquad_alt.o
OBJS += external/krkrz/external/opus/silk/bwexpander.o
OBJS += external/krkrz/external/opus/silk/bwexpander_32.o
OBJS += external/krkrz/external/opus/silk/check_control_input.o
OBJS += external/krkrz/external/opus/silk/code_signs.o
OBJS += external/krkrz/external/opus/silk/control_SNR.o
OBJS += external/krkrz/external/opus/silk/control_audio_bandwidth.o
OBJS += external/krkrz/external/opus/silk/control_codec.o
OBJS += external/krkrz/external/opus/silk/debug.o
OBJS += external/krkrz/external/opus/silk/dec_API.o
OBJS += external/krkrz/external/opus/silk/decode_core.o
OBJS += external/krkrz/external/opus/silk/decode_frame.o
OBJS += external/krkrz/external/opus/silk/decode_indices.o
OBJS += external/krkrz/external/opus/silk/decode_parameters.o
OBJS += external/krkrz/external/opus/silk/decode_pitch.o
OBJS += external/krkrz/external/opus/silk/decode_pulses.o
OBJS += external/krkrz/external/opus/silk/decoder_set_fs.o
OBJS += external/krkrz/external/opus/silk/enc_API.o
OBJS += external/krkrz/external/opus/silk/encode_indices.o
OBJS += external/krkrz/external/opus/silk/encode_pulses.o
OBJS += external/krkrz/external/opus/silk/float/LPC_analysis_filter_FLP.o
OBJS += external/krkrz/external/opus/silk/float/LPC_inv_pred_gain_FLP.o
OBJS += external/krkrz/external/opus/silk/float/LTP_analysis_filter_FLP.o
OBJS += external/krkrz/external/opus/silk/float/LTP_scale_ctrl_FLP.o
OBJS += external/krkrz/external/opus/silk/float/apply_sine_window_FLP.o
OBJS += external/krkrz/external/opus/silk/float/autocorrelation_FLP.o
OBJS += external/krkrz/external/opus/silk/float/burg_modified_FLP.o
OBJS += external/krkrz/external/opus/silk/float/bwexpander_FLP.o
OBJS += external/krkrz/external/opus/silk/float/corrMatrix_FLP.o
OBJS += external/krkrz/external/opus/silk/float/encode_frame_FLP.o
OBJS += external/krkrz/external/opus/silk/float/energy_FLP.o
OBJS += external/krkrz/external/opus/silk/float/find_LPC_FLP.o
OBJS += external/krkrz/external/opus/silk/float/find_LTP_FLP.o
OBJS += external/krkrz/external/opus/silk/float/find_pitch_lags_FLP.o
OBJS += external/krkrz/external/opus/silk/float/find_pred_coefs_FLP.o
OBJS += external/krkrz/external/opus/silk/float/inner_product_FLP.o
OBJS += external/krkrz/external/opus/silk/float/k2a_FLP.o
OBJS += external/krkrz/external/opus/silk/float/levinsondurbin_FLP.o
OBJS += external/krkrz/external/opus/silk/float/noise_shape_analysis_FLP.o
OBJS += external/krkrz/external/opus/silk/float/pitch_analysis_core_FLP.o
OBJS += external/krkrz/external/opus/silk/float/prefilter_FLP.o
OBJS += external/krkrz/external/opus/silk/float/process_gains_FLP.o
OBJS += external/krkrz/external/opus/silk/float/regularize_correlations_FLP.o
OBJS += external/krkrz/external/opus/silk/float/residual_energy_FLP.o
OBJS += external/krkrz/external/opus/silk/float/scale_copy_vector_FLP.o
OBJS += external/krkrz/external/opus/silk/float/scale_vector_FLP.o
OBJS += external/krkrz/external/opus/silk/float/schur_FLP.o
OBJS += external/krkrz/external/opus/silk/float/solve_LS_FLP.o
OBJS += external/krkrz/external/opus/silk/float/sort_FLP.o
OBJS += external/krkrz/external/opus/silk/float/warped_autocorrelation_FLP.o
OBJS += external/krkrz/external/opus/silk/float/wrappers_FLP.o
OBJS += external/krkrz/external/opus/silk/gain_quant.o
OBJS += external/krkrz/external/opus/silk/init_decoder.o
OBJS += external/krkrz/external/opus/silk/init_encoder.o
OBJS += external/krkrz/external/opus/silk/inner_prod_aligned.o
OBJS += external/krkrz/external/opus/silk/interpolate.o
OBJS += external/krkrz/external/opus/silk/lin2log.o
OBJS += external/krkrz/external/opus/silk/log2lin.o
OBJS += external/krkrz/external/opus/silk/pitch_est_tables.o
OBJS += external/krkrz/external/opus/silk/process_NLSFs.o
OBJS += external/krkrz/external/opus/silk/quant_LTP_gains.o
OBJS += external/krkrz/external/opus/silk/resampler.o
OBJS += external/krkrz/external/opus/silk/resampler_down2.o
OBJS += external/krkrz/external/opus/silk/resampler_down2_3.o
OBJS += external/krkrz/external/opus/silk/resampler_private_AR2.o
OBJS += external/krkrz/external/opus/silk/resampler_private_IIR_FIR.o
OBJS += external/krkrz/external/opus/silk/resampler_private_down_FIR.o
OBJS += external/krkrz/external/opus/silk/resampler_private_up2_HQ.o
OBJS += external/krkrz/external/opus/silk/resampler_rom.o
OBJS += external/krkrz/external/opus/silk/shell_coder.o
OBJS += external/krkrz/external/opus/silk/sigm_Q15.o
OBJS += external/krkrz/external/opus/silk/sort.o
OBJS += external/krkrz/external/opus/silk/stereo_LR_to_MS.o
OBJS += external/krkrz/external/opus/silk/stereo_MS_to_LR.o
OBJS += external/krkrz/external/opus/silk/stereo_decode_pred.o
OBJS += external/krkrz/external/opus/silk/stereo_encode_pred.o
OBJS += external/krkrz/external/opus/silk/stereo_find_predictor.o
OBJS += external/krkrz/external/opus/silk/stereo_quant_pred.o
OBJS += external/krkrz/external/opus/silk/sum_sqr_shift.o
OBJS += external/krkrz/external/opus/silk/table_LSF_cos.o
OBJS += external/krkrz/external/opus/silk/tables_LTP.o
OBJS += external/krkrz/external/opus/silk/tables_NLSF_CB_NB_MB.o
OBJS += external/krkrz/external/opus/silk/tables_NLSF_CB_WB.o
OBJS += external/krkrz/external/opus/silk/tables_gain.o
OBJS += external/krkrz/external/opus/silk/tables_other.o
OBJS += external/krkrz/external/opus/silk/tables_pitch_lag.o
OBJS += external/krkrz/external/opus/silk/tables_pulses_per_block.o
OBJS += external/krkrz/external/opus/src/analysis.o
OBJS += external/krkrz/external/opus/src/mlp.o
OBJS += external/krkrz/external/opus/src/mlp_data.o
OBJS += external/krkrz/external/opus/src/opus.o
OBJS += external/krkrz/external/opus/src/opus_decoder.o
OBJS += external/krkrz/external/opus/src/opus_encoder.o
OBJS += external/krkrz/external/opus/src/opus_multistream.o
OBJS += external/krkrz/external/opus/src/opus_multistream_decoder.o
OBJS += external/krkrz/external/opus/src/opus_multistream_encoder.o
OBJS += external/krkrz/external/opus/src/repacketizer.o

#opusfile
OBJS += external/krkrz/external/opusfile/src/http.o
OBJS += external/krkrz/external/opusfile/src/info.o
OBJS += external/krkrz/external/opusfile/src/internal.o
OBJS += external/krkrz/external/opusfile/src/opusfile.o
OBJS += external/krkrz/external/opusfile/src/stream.o
OBJS += external/krkrz/external/opusfile/src/wincerts.o

#zlib
OBJS += external/krkrz/external/zlib/adler32.o
OBJS += external/krkrz/external/zlib/compress.o
OBJS += external/krkrz/external/zlib/crc32.o
OBJS += external/krkrz/external/zlib/deflate.o
OBJS += external/krkrz/external/zlib/infback.o
OBJS += external/krkrz/external/zlib/inffast.o
OBJS += external/krkrz/external/zlib/inflate.o
OBJS += external/krkrz/external/zlib/inftrees.o
OBJS += external/krkrz/external/zlib/trees.o
OBJS += external/krkrz/external/zlib/uncompr.o
OBJS += external/krkrz/external/zlib/zutil.o

#krkrsdl2
OBJS += src/core/base/sdl2/AndroidAssetManager.o
OBJS += src/core/base/sdl2/EventImpl.o
OBJS += src/core/base/sdl2/FileSelector.o
OBJS += src/core/base/sdl2/FuncStubs.o
OBJS += src/core/base/sdl2/NativeEventQueue.o
OBJS += src/core/base/sdl2/PluginImpl.o
OBJS += src/core/base/sdl2/ScriptMgnImpl.o
OBJS += src/core/base/sdl2/StorageImpl.o
OBJS += src/core/base/sdl2/SysInitImpl.o
OBJS += src/core/base/sdl2/SystemImpl.o
OBJS += src/core/environ/sdl2/Application.o
OBJS += src/core/environ/sdl2/DetectCPU.o
OBJS += src/core/environ/sdl2/SystemControl.o
OBJS += src/core/msg/sdl2/MsgImpl.o
OBJS += src/core/msg/sdl2/MsgLoad.o
#OBJS += src/core/sdl2/SDLApplication.o #main entry
OBJS += src/core/sdl2/SDLBitmapCompletion.o
OBJS += src/core/sound/sdl2/AudioDeviceCreator.o
OBJS += src/core/sound/sdl2/FAudioDevice.o
OBJS += src/core/sound/sdl2/NullAudioDevice.o
OBJS += src/core/sound/sdl2/OpenALWaveMixer.o
OBJS += src/core/sound/sdl2/WaveImpl.o
OBJS += src/core/utils/sdl2/ClipboardImpl.o
OBJS += src/core/visual/sdl2/BasicDrawDevice.o
OBJS += src/core/visual/sdl2/BitmapBitsAlloc.o
OBJS += src/core/visual/sdl2/BitmapInfomation.o
OBJS += src/core/visual/sdl2/GraphicsLoaderImpl.o
OBJS += src/core/visual/sdl2/LayerImpl.o
OBJS += src/core/visual/sdl2/TVPScreen.o
OBJS += src/core/visual/sdl2/VideoOvlImpl.o
OBJS += src/core/visual/sdl2/WindowImpl.o
OBJS += src/core/visual/sdl2/opengl/OpenGLPlatformSDL2.o

#krkrz SSE
OBJS += external/krkrz/sound/MathAlgorithms_SSE.o
OBJS += external/krkrz/sound/RealFFT_SSE.o
OBJS += external/krkrz/sound/WaveFormatConverter_SSE.o
OBJS += external/krkrz/visual/gl/ResampleImageSSE2.o
OBJS += external/krkrz/visual/gl/adjust_color_sse2.o
OBJS += external/krkrz/visual/gl/blend_function_sse2.o
OBJS += external/krkrz/visual/gl/boxblur_sse2.o
OBJS += external/krkrz/visual/gl/colorfill_sse2.o
OBJS += external/krkrz/visual/gl/colormap_sse2.o
OBJS += external/krkrz/visual/gl/pixelformat_sse2.o
OBJS += external/krkrz/visual/gl/tlg_sse2.o
OBJS += external/krkrz/visual/gl/univtrans_sse2.o
OBJS += external/krkrz/visual/gl/ResampleImageAVX2.o

OBJS += external/krkrz/visual/gl/blend_function_avx2.o
OBJS += external/krkrz/visual/gl/x86simdutilAVX2.o

#USE_KIRIKIROID2_TEXTSTREAM, 
OBJS += external/krkrz/utils/encoding/gbk2unicode.o
OBJS += external/krkrz/utils/encoding/jis2unicode.o

#vorbis
#https://github.com/zeas2/Kirikiroid2/blob/master/src/core/sound/VorbisWaveDecoder.cpp
#https://github.com/w-dee/kirikiri3-legacy/blob/master/src/core/risa/packages/risa/sound/decoder/vorbis/VorbisDecoder.cpp
OBJS += external/krkrz/sound/VorbisWaveDecoder.o
###OBJS += external/krkrz/external/libogg-1.1.3/src/bitwise.o
###OBJS += external/krkrz/external/libogg-1.1.3/src/framing.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/analysis.o
#OBJS += external/krkrz/external/libvorbis-1.2.0/lib/barkmel.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/bitrate.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/block.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/codebook.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/envelope.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/floor0.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/floor1.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/info.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/lookup.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/lpc.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/lsp.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/mapping0.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/mdct.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/psy.o
#OBJS += external/krkrz/external/libvorbis-1.2.0/lib/psytune.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/registry.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/res0.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/sharedbook.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/smallft.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/synthesis.o
#OBJS += external/krkrz/external/libvorbis-1.2.0/lib/tone.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/vorbisenc.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/vorbisfile.o
OBJS += external/krkrz/external/libvorbis-1.2.0/lib/window.o

KRKRSDL2_OBJS := 

all : krkrsdl2

krkrsdl2.a : $(OBJS)
	$(AR) $@ $(OBJS)
	$(RANLIB) $@

krkrsdl2: src/core/sdl2/SDLApplication.cpp krkrsdl2.a $(KRKRSDL2_OBJS)
	$(CPP) src/core/sdl2/SDLApplication.cpp $(KRKRSDL2_OBJS) krkrsdl2.a -o $@ $(CPPFLAGS) $(LDFLAGS)

%.o : %.cpp
	$(CPP) $(CPPFLAGS2) $(CPPFLAGS) -o $@ -c $<

%.o : %.cc
	$(CPP) $(CPPFLAGS2) $(CPPFLAGS) -o $@ -c $<

%.o : %.c
	$(CC) $(CPPFLAGS) -o $@ -c $<

#ok, utf-8	
test:
	./krkrsdl2

debug:
	gdb --args ./krkrsdl2

#exception, shift_jis
test2:
	cp ./krkrsdl2 kr2_230r2_sjis/.
	kr2_230r2_sjis/krkrsdl2 -deffont font.ttf

#ok, shift_jis
test3:
	cp ./krkrsdl2 kr2_230r2_sjis_merge/.
	kr2_230r2_sjis_merge/krkrsdl2

#exception, gbk
test4:
	cp ./krkrsdl2 kagexpress_gbk/.
	kagexpress_gbk/krkrsdl2

#ok, gbk
test5:
	cp ./krkrsdl2 kagexpress_gbk_merge/.
	kagexpress_gbk_merge/krkrsdl2

#crash, need use USE_NO_SSE2=1
test6:
	cp ./krkrsdl2 kagexpress_gbk_merge0/.
	gdb kagexpress_gbk_merge0/krkrsdl2

test7:
	cp ./krkrsdl2 spring_days/.
	gdb spring_days/krkrsdl2
	
test8:
	cp ./krkrsdl2 spring_days_data/.
	gdb --args spring_days_data/krkrsdl2

test9:
	cp ./krkrsdl2 krkrsdl2_data/.
	gdb --args krkrsdl2_data/krkrsdl2 
#-readencoding2=UTF-8

#gdb spring_days/krkrsdl2
#(gdb) catch throw

#FreeType.cpp
#b tFreeTypeFace::GetGlyphFromCharcode
#if( (index = GetGlyphMetricsFromCharcode(code, metrics)) < 0 )
#		return nullptr;<--go here
#if (GlyphMetricsCache[code].index < 0) return -1; <-go here

#
#search GlyphMetricsCache[code].index = 
#b FreeType.cpp:1207

#(b tFreeTypeFace::LoadGlyphSlotFromCharcode, not need)
#FT_UInt glyph_index = FT_Get_Char_Index(faceset->FTFace, localcode);
#		if(glyph_index == 0)
#			continue; <-go here
#
#//bacause FT_Get_Char_Index return 0
#
#(gdb) print *faceset.get()
#$7 = {FontName = u"Ume Gothic O5", 
#  Face = std::unique_ptr<tBaseFreeTypeFace> = {get() = 0x5555581fb510}, 
#  FTFace = 0x555557e7d1f0, 
#  GlyphIndexToCharcodeVector = std::unique_ptr<std::vector<unsigned long, std::allocator<unsigned long> >> = {get() = 0x0}, UnicodeToLocalChar = 0x0, 
#  LocalCharToUnicode = 0x0}
#		

ifeq ($(MIYOO),3)
else ifeq ($(MIYOO),2)
#adb push krkrsdl2 /tmp
#killall -KILL runtrimui.sh MainUI
#cd /tmp
#chmod +x ./krkrsdl2
#LD_LIBRARY_PATH=/usr/trimui/lib ./krkrsdl2
endif
#for trimui smart pro
install:
	adb push ./krkrsdl2 /mnt/SDCARD/Apps/krkrsdl2/.
	
#cd /mnt/SDCARD/Apps/krkrsdl2/; LD_LIBRARY_PATH=/usr/trimui/lib ./krkrsdl2

run:
	adb shell 'cd /mnt/SDCARD/Apps/krkrsdl2/; LD_LIBRARY_PATH=/usr/trimui/lib ./krkrsdl2'

#make MIYOO=2 && make install && make run

clean :
	$(RM) $(OBJS) $(KRKRSDL2_OBJS) krkrsdl2.a krkrsdl2 
	$(RM) kr2_230r2_sjis/krkrsdl2
	$(RM) kr2_230r2_sjis_merge/krkrsdl2
	$(RM) kagexpress_gbk/krkrsdl2
	$(RM) kagexpress_gbk_merge/krkrsdl2
	$(RM) kagexpress_gbk_merge0/krkrsdl2
	$(RM) spring_days/krkrsdl2
	$(RM) spring_days_data/krkrsdl2
	$(RM) krkrsdl2_data/krkrsdl2
	




