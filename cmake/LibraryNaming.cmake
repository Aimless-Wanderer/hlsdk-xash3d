include(CheckSymbolExists)

# generated(see comments in public/build.h)
set(CMAKE_REQUIRED_INCLUDES "${PROJECT_SOURCE_DIR}/public/")
check_symbol_exists(XASH_64BIT "build.h" XASH_64BIT)
check_symbol_exists(XASH_AMD64 "build.h" XASH_AMD64)
check_symbol_exists(XASH_ANDROID "build.h" XASH_ANDROID)
check_symbol_exists(XASH_APPLE "build.h" XASH_APPLE)
check_symbol_exists(XASH_ARM "build.h" XASH_ARM)
check_symbol_exists(XASH_ARM_HARDFP "build.h" XASH_ARM_HARDFP)
check_symbol_exists(XASH_ARM_SOFTFP "build.h" XASH_ARM_SOFTFP)
check_symbol_exists(XASH_ARMv4 "build.h" XASH_ARMv4)
check_symbol_exists(XASH_ARMv5 "build.h" XASH_ARMv5)
check_symbol_exists(XASH_ARMv6 "build.h" XASH_ARMv6)
check_symbol_exists(XASH_ARMv7 "build.h" XASH_ARMv7)
check_symbol_exists(XASH_ARMv8 "build.h" XASH_ARMv8)
check_symbol_exists(XASH_BIG_ENDIAN "build.h" XASH_BIG_ENDIAN)
check_symbol_exists(XASH_BSD "build.h" XASH_BSD)
check_symbol_exists(XASH_E2K "build.h" XASH_E2K)
check_symbol_exists(XASH_EMSCRIPTEN "build.h" XASH_EMSCRIPTEN)
check_symbol_exists(XASH_FREEBSD "build.h" XASH_FREEBSD)
check_symbol_exists(XASH_IOS "build.h" XASH_IOS)
check_symbol_exists(XASH_JS "build.h" XASH_JS)
check_symbol_exists(XASH_LINUX "build.h" XASH_LINUX)
check_symbol_exists(XASH_LITTLE_ENDIAN "build.h" XASH_LITTLE_ENDIAN)
check_symbol_exists(XASH_MINGW "build.h" XASH_MINGW)
check_symbol_exists(XASH_MIPS "build.h" XASH_MIPS)
check_symbol_exists(XASH_MOBILE_PLATFORM "build.h" XASH_MOBILE_PLATFORM)
check_symbol_exists(XASH_MSVC "build.h" XASH_MSVC)
check_symbol_exists(XASH_NETBSD "build.h" XASH_NETBSD)
check_symbol_exists(XASH_OPENBSD "build.h" XASH_OPENBSD)
check_symbol_exists(XASH_HAIKU "build.h" XASH_HAIKU)
check_symbol_exists(XASH_WIN32 "build.h" XASH_WIN32)
check_symbol_exists(XASH_WIN64 "build.h" XASH_WIN64)
check_symbol_exists(XASH_X86 "build.h" XASH_X86)
unset(CMAKE_REQUIRED_INCLUDES)

# engine/common/build.c
if(XASH_ANDROID)
	set(BUILDOS "android")
elseif(XASH_WIN32 OR XASH_LINUX OR XASH_APPLE)
	set(BUILDOS "") # no prefix for default OS
elseif(XASH_FREEBSD)
	set(BUILDOS "freebsd")
elseif(XASH_NETBSD)
	set(BUILDOS "netbsd")
elseif(XASH_OPENBSD)
	set(BUILDOS "openbsd")
elseif(XASH_HAIKU)
	set(BUILDOS "haiku")
elseif(XASH_EMSCRIPTEN)
	set(BUILDOS "emscripten")
else()
	message(SEND_ERROR "Place your operating system name here! If this is a mistake, try to fix conditions above and report a bug")
endif()

if(XASH_AMD64)
	set(BUILDARCH "amd64")
elseif(XASH_X86)
	set(BUILDARCH "")
elseif(XASH_ARM AND XASH_64BIT)
	set(BUILDARCH "arm64")
elseif(XASH_ARM)
	set(BUILDARCH "armv")
	if(XASH_ARMv8)
		set(BUILDARCH "${BUILDARCH}8_32")
	elseif(XASH_ARMv7)
		set(BUILDARCH "${BUILDARCH}7")
	elseif(XASH_ARMv6)
		set(BUILDARCH "${BUILDARCH}6")
	elseif(XASH_ARMv5)
		set(BUILDARCH "${BUILDARCH}5")
	elseif(XASH_ARMv4)
		set(BUILDARCH "${BUILDARCH}4")
	else()
		message(SEND_ERROR "Unknown ARM")
	endif()

	if(XASH_ARM_HARDFP)
		set(BUILDARCH "${BUILDARCH}hf")
	else()
		set(BUILDARCH "${BUILDARCH}l")
	endif()
elseif(XASH_MIPS AND XASH_BIG_ENDIAN)
	set(BUILDARCH "mips")
elseif(XASH_MIPS AND XASH_LITTLE_ENDIAN)
	set(BUILDARCH "mipsel")
elseif(XASH_JS)
	set(BUILDARCH "javascript")
elseif(XASH_E2K)
	set(BUILDARCH "e2k")
else()
	message(SEND_ERROR "Place your architecture name here! If this is a mistake, try to fix conditions above and report a bug")
endif()

if(BUILDOS STREQUAL "android")
	set(POSTFIX "") # force disable for Android, as Android ports aren't distributed in normal way and doesn't follow library naming
elseif(BUILDOS AND BUILDARCH)
	set(POSTFIX "_${BUILDOS}_${BUILDARCH}")
elseif(BUILDARCH)
	set(POSTFIX "_${BUILDARCH}")
else()
	set(POSTFIX "")
endif()

message(STATUS "Library postfix: " ${POSTFIX})

set(CMAKE_RELEASE_POSTFIX ${POSTFIX})
set(CMAKE_DEBUG_POSTFIX ${POSTFIX})
set(CMAKE_RELWITHDEBINFO_POSTFIX ${POSTFIX})
set(CMAKE_MINSIZEREL_POSTFIX ${POSTFIX})
set(CMAKE_POSTFIX ${POSTFIX})
