#ifndef __crt_dirent_bi__
#define __crt_dirent_bi__

#if defined(__FB_WIN32__)
#include once "crt/win32/dirent.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/linux/dirent.bi"
#else
#error unsupported platform
#endif

#endif
