/////////////////////////////////////////////////////////////////////////////
// Name:        xr_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     27/ 7/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_XRC_TYPEDEF_H
#define _WXPERL_XRC_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

#define FD_TD_NAME( name, cls ) \
  class wx##cls; \
  typedef wx##cls Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name;

FD_TD( XmlResource );
FD_TD( XmlResourceHandler );

#undef FD_TD

#endif
  // _WXPERL_XRC_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //
