''
''
'' sys\stat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_stat_bi__
#define __crt_sys_stat_bi__

#include once "crt/stddef.bi"
#include once "crt/sys/types.bi"

#if defined(__FB_WIN32__)
#include once "crt/sys/win32/stat.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/sys/linux/stat.bi"
#else
#error Platform unsupported
#endif

#endif
