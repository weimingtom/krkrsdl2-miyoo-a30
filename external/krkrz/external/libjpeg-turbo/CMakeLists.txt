cmake_minimum_required(VERSION 3.4.1)

enable_language(ASM)

if( ANDROID )
	set(CMAKE_CXX_FLAGS_DEBUG "-g3 -O0")
	set(CMAKE_C_FLAGS_DEBUG "-g3 -O0")
	set(CMAKE_CXX_FLAGS_RELEASE "-O2 -s -DNDEBUG")
	set(CMAKE_C_FLAGS_RELEASE "-O2 -s -DNDEBUG")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-g3 -Og")
	set(CMAKE_C_FLAGS_RELWITHDEBINFO "-g3 -Og")
	set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -s -DNDEBUG")
	set(CMAKE_C_FLAGS_MINSIZEREL "-Os -s -DNDEBUG")

	include_directories( include android )
#else()
	include_directories( include )
endif()


set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DONIG_EXTERN=extern" )

if(ANDROID_ARM_NEON)
	set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__ARM_HAVE_NEON" )
endif()

if( ANDROID )
	set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -DELF")
endif()

set( JPEG_TURBO_SRC 
	jcapimin.c
	jcapistd.c
	jccoefct.c
	jccolor.c
	jcdctmgr.c
	jchuff.c
	jcinit.c
	jcmainct.c
	jcmarker.c
	jcmaster.c
	jcomapi.c
	jcparam.c
	jcphuff.c
	jcprepct.c
	jcsample.c
	jctrans.c
	jdapimin.c
	jdapistd.c
	jdatadst.c
	jdatasrc.c
	jdcoefct.c
	jdcolor.c
	jddctmgr.c
	jdhuff.c
	jdinput.c
	jdmainct.c
	jdmarker.c
	jdmaster.c
	jdmerge.c
	jdphuff.c
	jdpostct.c
	jdsample.c
	jdtrans.c
	jerror.c
	jfdctflt.c
	jfdctfst.c
	jfdctint.c
	jidctflt.c
	jidctfst.c
	jidctint.c
	jidctred.c
	jquant1.c
	jquant2.c
	jutils.c
	jmemmgr.c
	jmemnobs.c )

if( ANDROID_ABI STREQUAL x86 )
	list(APPEND JPEG_TURBO_SRC 
	simd/jsimd_i386.c
	simd/jsimdcpu.asm
	simd/jfdctflt-3dn.asm
	simd/jidctflt-3dn.asm
	simd/jquant-3dn.asm
	simd/jccolor-mmx.asm
	simd/jcgray-mmx.asm
	simd/jcsample-mmx.asm
	simd/jdcolor-mmx.asm
	simd/jdmerge-mmx.asm
	simd/jdsample-mmx.asm
	simd/jfdctfst-mmx.asm
	simd/jfdctint-mmx.asm
	simd/jidctfst-mmx.asm
	simd/jidctint-mmx.asm
	simd/jidctred-mmx.asm
	simd/jquant-mmx.asm
	simd/jfdctflt-sse.asm
	simd/jidctflt-sse.asm
	simd/jquant-sse.asm
	simd/jccolor-sse2.asm
	simd/jcgray-sse2.asm
	simd/jcsample-sse2.asm
	simd/jdcolor-sse2.asm
	simd/jdmerge-sse2.asm
	simd/jdsample-sse2.asm
	simd/jfdctfst-sse2.asm
	simd/jfdctint-sse2.asm
	simd/jidctflt-sse2.asm
	simd/jidctfst-sse2.asm
	simd/jidctint-sse2.asm
	simd/jidctred-sse2.asm
	simd/jquantf-sse2.asm
	simd/jquanti-sse2.asm )

	set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSIZEOF_SIZE_T=4" )

elseif( ANDROID_ABI STREQUAL x86_64 )
	list(APPEND JPEG_TURBO_SRC
	simd/jsimd_x86_64.c
	simd/jfdctflt-sse-64.asm
	simd/jccolor-sse2-64.asm
	simd/jcgray-sse2-64.asm
	simd/jcsample-sse2-64.asm
	simd/jdcolor-sse2-64.asm
	simd/jdmerge-sse2-64.asm
	simd/jdsample-sse2-64.asm
	simd/jfdctfst-sse2-64.asm
	simd/jfdctint-sse2-64.asm
	simd/jidctflt-sse2-64.asm
	simd/jidctfst-sse2-64.asm
	simd/jidctint-sse2-64.asm
	simd/jidctred-sse2-64.asm
	simd/jquantf-sse2-64.asm
	simd/jquanti-sse2-64.asm )
	
	set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSIZEOF_SIZE_T=8" )
	set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -D__x86_64__")

#elseif(ANDROID_ABI STREQUAL armeabi-v7a)
elseif( ARMEABI_V7A )
	list(APPEND JPEG_TURBO_SRC
	simd/jsimd_arm.c
	simd/jsimd_arm_neon.S )

	set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSIZEOF_SIZE_T=4" )

#elseif(ANDROID_ABI STREQUAL arm64-v8a)
elseif( ARM64_V8A )
	list(APPEND JPEG_TURBO_SRC
	simd/jsimd_arm64.c
	simd/jsimd_arm64_neon.S )

	set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSIZEOF_SIZE_T=8" )

#elseif(ANDROID_ABI STREQUAL armeabi)
elseif( ARMEABI )
	set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSIZEOF_SIZE_T=4" )

endif()

# if WITH_ARITH_ENC from Makefile.am
list(APPEND JPEG_TURBO_SRC
	jaricom.c
	jcarith.c
	jdarith.c )

# libturbojpeg_la_SOURCES from Makefile.am
list(APPEND JPEG_TURBO_SRC
	turbojpeg.c
	transupp.c
	jdatadst-tj.c
	jdatasrc-tj.c )

include_directories( . android simd )


add_library( jpeg-turbo STATIC ${JPEG_TURBO_SRC} )

