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
endif()

include_directories( . include )

add_library( ogg STATIC
src/bitwise.c
src/framing.c )

