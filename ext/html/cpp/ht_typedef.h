/////////////////////////////////////////////////////////////////////////////
// Name:        ht_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     17/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_HTML_TYPEDEF_H
#define _WXPERL_HTML_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

FD_TD( HtmlWindow );
FD_TD( HtmlLinkInfo );
FD_TD( HtmlCell );
FD_TD( HtmlHelpController );
FD_TD( HtmlEasyPrinting );
// do not need to depend upon Wx::Config
FD_TD( ConfigBase );
// do not need to depend upon Wx::Print
FD_TD( PrintData );
FD_TD( PageSetupDialogData );

#undef FD_TD

#endif
  // _WXPERL_HTML_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //

