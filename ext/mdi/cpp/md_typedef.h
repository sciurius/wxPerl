/////////////////////////////////////////////////////////////////////////////
// Name:        md_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:      6/ 9/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_MDI_TYPEDEF_H
#define _WXPERL_MDI_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name;

#define FD_TD_NAME( name, cls ) \
  class wx##cls; \
  typedef wx##cls Wx_##name;

FD_TD( MDIParentFrame );
FD_TD( MDIChildFrame );
FD_TD( MDIClientWindow );

#undef FD_TD

#endif
  // _WXPERL_MDI_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //
