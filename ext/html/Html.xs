/////////////////////////////////////////////////////////////////////////////
// Name:        ext/html/Html.xs
// Purpose:     XS for Wx::Html*
// Author:      Mattia Barbon
// Modified by:
// Created:     10/03/2001
// RCS-ID:      $Id: Html.xs,v 1.14 2004/03/01 21:24:10 mbarbon Exp $
// Copyright:   (c) 2001-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

MODULE=Wx__Html

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/HtmlWindow.xs
INCLUDE: XS/HtmlHelpController.xs
INCLUDE: XS/HtmlEasyPrinting.xs

INCLUDE: perl ../../script/xsubppp.pl --typemap=typemap.xsp --typemap=../../typemap.xsp XS/HtmlParser.xsp |

INCLUDE: perl ../../script/xsubppp.pl --typemap=typemap.xsp --typemap=../../typemap.xsp XS/HtmlTagHandler.xsp |

INCLUDE: perl ../../script/xsubppp.pl --typemap=typemap.xsp --typemap=../../typemap.xsp XS/HtmlTag.xsp |

INCLUDE: perl ../../script/xsubppp.pl --typemap=typemap.xsp --typemap=../../typemap.xsp XS/HtmlCell.xsp |

#include "cpp/ht_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Html