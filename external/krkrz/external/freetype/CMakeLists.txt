cmake_minimum_required(VERSION 3.4.1)

if( ANDROID )
	set(CMAKE_CXX_FLAGS_DEBUG "-g3 -O0")
	set(CMAKE_C_FLAGS_DEBUG "-g3 -O0")
	set(CMAKE_CXX_FLAGS_RELEASE "-O2 -s -DNDEBUG")
	set(CMAKE_C_FLAGS_RELEASE "-O2 -s -DNDEBUG")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-g3 -Og")
	set(CMAKE_C_FLAGS_RELWITHDEBINFO "-g3 -Og")
	set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -s -DNDEBUG")
	set(CMAKE_C_FLAGS_MINSIZEREL "-Os -s -DNDEBUG")

	set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DANDROID_NDK -DFT2_BUILD_LIBRARY=1" )
endif()


include_directories( include src )

add_library( freetype STATIC
             src/autofit/autofit.c
             src/base/basepic.c
             src/base/ftapi.c
             src/base/ftbase.c
             src/base/ftbbox.c
             src/base/ftbitmap.c
             src/base/ftdbgmem.c
             src/base/ftdebug.c
             src/base/ftglyph.c
             src/base/ftinit.c
             src/base/ftpic.c
             src/base/ftstroke.c
             src/base/ftsynth.c
             src/base/ftsystem.c
             src/cff/cff.c
             src/pshinter/pshinter.c
             src/pshinter/pshglob.c
             src/pshinter/pshpic.c
             src/pshinter/pshrec.c
             src/psnames/psnames.c
             src/psnames/pspic.c
             src/raster/raster.c
             src/raster/rastpic.c
             src/sfnt/pngshim.c
             src/sfnt/sfntpic.c
             src/sfnt/ttbdf.c
             src/sfnt/ttkern.c
             src/sfnt/ttload.c
             src/sfnt/ttmtx.c
             src/sfnt/ttpost.c
             src/sfnt/ttsbit.c
             src/sfnt/sfobjs.c
             src/sfnt/ttcmap.c
             src/sfnt/sfdriver.c
             src/smooth/smooth.c
             src/smooth/ftspic.c
             src/truetype/truetype.c
             src/type1/t1driver.c
             src/cid/cidgload.c
             src/cid/cidload.c
             src/cid/cidobjs.c
             src/cid/cidparse.c
             src/cid/cidriver.c
             src/pfr/pfr.c
             src/pfr/pfrgload.c
             src/pfr/pfrload.c
             src/pfr/pfrobjs.c
             src/pfr/pfrsbit.c
             src/type42/t42objs.c
             src/type42/t42parse.c
             src/type42/type42.c
             src/winfonts/winfnt.c
             src/pcf/pcfread.c
             src/pcf/pcfutil.c
             src/pcf/pcfdrivr.c
             src/psaux/afmparse.c
             src/psaux/psaux.c
             src/psaux/psconv.c
             src/psaux/psobjs.c
             src/psaux/t1decode.c
             src/tools/apinames.c
             src/type1/t1afm.c
             src/type1/t1gload.c
             src/type1/t1load.c
             src/type1/t1objs.c
             src/type1/t1parse.c
             src/bdf/bdfdrivr.c
             src/bdf/bdflib.c
             src/gzip/ftgzip.c
             src/lzw/ftlzw.c )





