/* binw$ routines */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrBin_b ( unsigned char num )
{
	return fb_WstrBinEx_l( num, 0 );
}

FBCALL FB_WCHAR *fb_WstrBin_s ( unsigned short num )
{
	return fb_WstrBinEx_l( num, 0 );
}

FBCALL FB_WCHAR *fb_WstrBin_i ( unsigned int num )
{
	return fb_WstrBinEx_l( num, 0 );
}

FBCALL FB_WCHAR *fb_WstrBinEx_b( unsigned char num, int digits )
{
	return fb_WstrBinEx_l( num, digits );
}

FBCALL FB_WCHAR *fb_WstrBinEx_s( unsigned short num, int digits )
{
	return fb_WstrBinEx_l( num, digits );
}

FBCALL FB_WCHAR *fb_WstrBinEx_i ( unsigned int num, int digits )
{
	return fb_WstrBinEx_l( num, digits );
}
