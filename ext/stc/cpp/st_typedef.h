/////////////////////////////////////////////////////////////////////////////
// Name:        st_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     23/ 5/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_STC_TYPEDEF_H
#define _WXPERL_STC_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

FD_TD( StyledTextCtrl );

#undef FD_TD

#endif
  // _WXPERL_STC_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //

