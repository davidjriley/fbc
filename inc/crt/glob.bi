#ifndef __crt_glob_bi__
#define __crt_glob_bi__

#if defined(__FB_LINUX__)
#include once "crt/linux/glob.bi"
#else
#error unsupported platform
#endif

#endif
