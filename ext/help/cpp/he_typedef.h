/////////////////////////////////////////////////////////////////////////////
// Name:        he_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     18/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_HELP_TYPEDEF_H
#define _WXPERL_HELP_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

FD_TD( HelpControllerBase );
FD_TD( HelpControllerHtml );
FD_TD( WinHelpController );
FD_TD( ExtHelpController );
FD_TD( CHMHelpController );

FD_TD( ContextHelp );
FD_TD( ContextHelpButton );
FD_TD( HelpProvider );
FD_TD( SimpleHelpProvider );
FD_TD( HelpControllerHelpProvider );

#undef FD_TD

#endif
  // _WXPERL_HELP_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //

