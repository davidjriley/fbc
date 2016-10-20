#ifndef __crt_pwd_bi__
#define __crt_pwd_bi__

#if defined(__FB_LINUX__)
#include once "crt/linux/pwd.bi"
#else
#error unsupported platform
#endif

#endif
