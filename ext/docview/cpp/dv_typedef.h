/////////////////////////////////////////////////////////////////////////////
// Name:        dv_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     23/ 5/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_DOCVIEW_TYPEDEF_H
#define _WXPERL_DOCVIEW_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name;

FD_TD( CommandProcessor );
FD_TD( DocChildFrame );
FD_TD( DocMDIChildFrame );
FD_TD( DocMDIParentFrame );
FD_TD( DocManager );
FD_TD( DocParentFrame );
FD_TD( DocPrintout );
FD_TD( DocTemplate );
FD_TD( Document );
FD_TD( FileHistory );
FD_TD( View );
#if defined( WXPL_STATIC )
class wxPrintout;
class wxMDIParentFrame;
typedef wxPrintout Wx_Printout;
typedef wxMDIParentFrame Wx_MDIParentFrame;
#else
FD_TD( MDIParentFrame );
FD_TD( Printout );
#endif

#undef FD_TD

#endif
  // _WXPERL_DocView_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //
