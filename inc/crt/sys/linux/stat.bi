#ifndef __crt_sys_linux_stat_bi__
#define __crt_sys_linux_stat_bi__

#include once "crt/sys/types.bi"

extern "C"
#define _S_IFMT   &O170000
#define _S_IFDIR  &O040000
#define _S_IFCHR  &O020000
#define _S_IFBLK  &O060000
#define _S_IFREG  &O100000
#define _S_IFIFO  &O010000
#define _S_IFLNK  &O120000
#define _S_IFSOCK &O140000

#ifndef _S_IRUSR
#define _S_ISUID &O4000
#define _S_ISGID &O2000
#define _S_ISVTX &O1000
#define _S_IRUSR &O400
#define _S_IWUSR &O200
#define _S_IXUSR &O100
#define _S_IRWXU &O700
#define _S_IRGRP &O040
#define _S_IWGRP &O020
#define _S_IXGRP &O010
#define _S_IRWXG &O070
#define _S_IROTH &O004
#define _S_IWOTH &O002
#define _S_IXOTH &O001
#define _S_IRWXO &O007
#endif

#define _S_ISDIR(m)  (((m) and _S_IFMT) = _S_IFDIR)
#define _S_ISCHR(m)  (((m) and _S_IFMT) = _S_IFCHR)
#define _S_ISBLK(m)  (((m) and _S_IFMT) = _S_IFBLK)
#define _S_ISREG(m)  (((m) and _S_IFMT) = _S_IFREG)
#define _S_ISFIFO(m) (((m) and _S_IFMT) = _S_IFIFO)
#define _S_ISLNK(m)  (((m) and _S_IFMT) = _S_IFLNK)
#define _S_ISSOCK(m) (((m) and _S_IFMT) = _S_IFSOCK)

type _stat
st_dev as dev_t
st_ino as ino_t
st_nlink as nlink_t
st_mode as mode_t
st_uid as uid_t
st_gid as gid_t
__pad0 as long
st_rdev as dev_t
st_size as off_t
st_blksize as blksize_t
st_blocks as blkcnt_t
st_atim as timespec
st_mtim as timespec
st_ctim as timespec
__unused(0 to 2) as long
end type

type __blksize_t as clong
type __blkcnt_t as clong

#ifndef stat
type stat as _stat
#endif



declare function stat    (byval as zstring ptr, byval as _stat ptr) as short
declare function fstat   (byval as short, byval as _stat ptr) as short
declare function fstatat (byval as short, byval as zstring ptr, byval as _stat ptr, byval as short) as short
declare function lstat   (byval as short, byval as _stat ptr) as short
declare function chmod   (byval as zstring ptr, byval as mode_t) as short
declare function fchmod  (byval as short, byval as mode_t) as short
declare function fchmodat(byval as short, byval as zstring ptr, byval as _stat ptr, byval as short) as short
declare function umask   (byval as mode_t) as mode_t
declare function _mkdir   alias "mkdir" (byval as zstring ptr, byval as mode_t) as short
declare function mkdirat (byval as short, byval as zstring ptr, byval as mode_t) as short
declare function mkfifo  (byval as zstring ptr, byval as mode_t) as short
declare function mkfifoat(byval as short, byval as zstring ptr, byval as mode_t) as short

end extern

#endif
