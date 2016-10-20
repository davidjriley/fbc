#ifndef _crt_win32_dirent_bi
#define _crt_win32_dirent_bi

#include once "crt/io.bi"
#include once "crt/long.bi"

extern "C"

type dirent
	d_ino as clong
	d_reclen as ushort
	d_namlen as ushort
	d_name as zstring * 260
end type

'Do not use, for internal use by libc only
type DIR
    dd_dta as _finddata_t
    dd_dir as dirent
    dd_handle as intptr_t
    dd_stat as long
    dd_name as zstring * 1
end type

declare function closedir(byval as DIR ptr) as long
declare function opendir(byval as const zstring ptr) as DIR ptr
declare function readdir(byval as DIR ptr) as dirent ptr
declare sub rewinddir(byval as DIR ptr)
declare sub seekdir(byval as DIR ptr, byval as clong)
declare function telldir(byval as DIR ptr) as clong

end extern
#endif
