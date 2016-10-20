#ifndef _crt_linux_dirent_bi
#define _crt_linux_dirent_bi

#include once "crt/sys/types.bi"
#include once "crt/long.bi"


extern "C"

type DIR as __dirstream

type dirent
	d_ino as _ino_t
	d_off as _off_t
	d_reclen as ushort
	d_type as ubyte
	d_name as zstring * 256
end type

#define d_fileno d_ino
declare function closedir(byval as DIR ptr) as long
declare function fdopendir(byval as long) as DIR ptr
declare function opendir(byval as const zstring ptr) as DIR ptr
declare function readdir(byval as DIR ptr) as dirent ptr
declare function readdir_r(byval as DIR ptr, byval as dirent ptr, byval as dirent ptr ptr) as long
declare sub rewinddir(byval as DIR ptr)
declare sub seekdir(byval as DIR ptr, byval as clong)
declare function telldir(byval as DIR ptr) as clong
declare function dirfd(byval as DIR ptr) as long
declare function alphasort(byval as const dirent ptr ptr, byval as const dirent ptr ptr) as long
declare function scandir(byval as const zstring ptr, byval as dirent ptr ptr ptr, byval as function(byval as const dirent ptr) as long, byval as function(byval as const dirent ptr ptr, byval as const dirent ptr ptr) as long) as long

end extern

#endif
