#ifndef _CRT_LINUX_PWD_BI
#define _CRT_LINUX_PWD_BI

#include once "crt/sys/types.bi"

type passwd
	pw_name as zstring ptr
	pw_passwd as zstring ptr
	pw_uid as uid_t
	pw_gid as gid_t
	pw_gecos as zstring ptr
	pw_dir as zstring ptr
	pw_shell as zstring ptr
end type

extern "C"
	declare sub setpwent()
	declare sub endpwent()
	declare function getpwent() as passwd ptr

	declare function getpwuid (as uid_t) as passwd ptr
	declare function getpwnam (as zstring ptr) as passwd ptr
	
	declare function getpwuid_r (as uid_t, as passwd ptr, as zstring ptr,_
								 as size_t, as passwd ptr ptr) as long
								 
	declare function getpwnam_r (as const zstring ptr, as passwd ptr, _
								 as zstring ptr, as size_t, as passwd ptr ptr) as long
end extern

#endif
