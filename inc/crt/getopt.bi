#ifndef _crt_getopt_bi_
#define _crt_getopt_bi_

''	getopt.bi -- translated with the help of fbfrog

const no_argument = 0
const required_argument = 1
const optional_argument = 2

extern "C"

type option_
	name_ as const zstring ptr
	has_arg as long
	flag as long ptr
	val_ as long
end type

declare function getopt(byval as long, byval as zstring const ptr ptr, byval as const zstring ptr) as long
extern optarg as zstring ptr
extern optind as long
extern opterr as long
extern optopt as long
extern optreset as long

declare function getopt_long(byval as long, byval as zstring const ptr ptr, byval as const zstring ptr, byval as const option_ ptr, byval as long ptr) as long
declare function getopt_long_only(byval as long, byval as zstring const ptr ptr, byval as const zstring ptr, byval as const option_ ptr, byval as long ptr) as long

end extern

#endif
