#ifndef _crt_linux_glob_bi_
#define _crt_linux_glob_bi_

#include "crt/stddef.bi"

type glob_t
	gl_pathc as size_t
	gl_pathv as zstring ptr ptr
	gl_offs as size_t
	__dummy1 as short
	__dummy2(0 to 5) as any ptr
end type

extern "C"
declare function glob(byval as const zstring ptr,_
					  byval as long,_
					  byval as function(byval as const zstring ptr, byval as long) as long,_
					  byval as glob_t ptr) as long
					  
declare sub globfree(as glob_t ptr)
end extern

#define GLOB_ERR      &h01
#define GLOB_MARK     &h02
#define GLOB_NOSORT   &h04
#define GLOB_DOOFFS   &h08
#define GLOB_NOCHECK  &h10
#define GLOB_APPEND   &h20
#define GLOB_NOESCAPE &h40
#define	GLOB_PERIOD   &h80

#define GLOB_NOSPACE 1
#define GLOB_ABORTED 2
#define GLOB_NOMATCH 3
#define GLOB_NOSYS   4

#endif
