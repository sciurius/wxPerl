/////////////////////////////////////////////////////////////////////////////
// Name:        chkconfig.h
// Purpose:     checks if desired configurations for wxPerl and wxWindows
//              are compatible
// Author:      Mattia Barbon
// Modified by:
// Created:      5/11/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#if 1
#define wxPERL_USE_PRINTING_ARCHITECTURE 1
#define wxPERL_USE_MDI_ARCHITECTURE 1
#define wxPERL_USE_SNGLINST_CHECKER 1
// #define wxPERL_USE_DRAG_AND_DROP 1
// #define wxPERL_USE_TOGGLEBTN 1
#endif

#if wxUSE_MDI_ARCHITECTURE
#   ifndef wxPERL_USE_MDI_ARCHITECTURE
#       define wxPERL_USE_MDI_ARCHITECTURE 1
#   endif
#elif wxPERL_USE_MDI_ARCHITECTURE
#   error "Recompile wxWindows with wxUSE_MDI_ARCHITECTURE"
#endif

#if wxUSE_PRINTING_ARCHITECTURE
#   ifndef wxPERL_USE_PRINTING_ARCHITECTURE
#       define wxPERL_USE_PRINTING_ARCHITECTURE 1
#   endif
#elif wxPERL_USE_PRINTING_ARCHITECTURE
#   error "Recompile wxWindows with wxUSE_PRINTING_ARCHITECTURE"
#endif

#if wxUSE_DRAG_AND_DROP
#   ifndef wxPERL_USE_DRAG_AND_DROP
#       define wxPERL_USE_DRAG_AND_DROP 1
#   endif
#elif wxPERL_USE_DRAG_AND_DROP
#   error "Recompile wxWindows with wxUSE_DRAG_AND_DROP"
#endif

// 2.3 specific checks

// 2.3.1

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

#if wxUSE_SNGLINST_CHECKER
#   ifndef wxPERL_USE_SNGLINST_CHECKER
#       define wxPERL_USE_SNGLINST_CHECKER 1
#   endif
#elif wxPERL_USE_SNGLINST_CHECKER
#   error "Recompile wxWindows with wxUSE_SNGLINST_CHECKER"
#endif

#if wxUSE_TOGGLEBTN
#   ifndef wxPERL_USE_TOGGLEBTN
#       define wxPERL_USE_TOGGLEBTN 1
#   endif
#elif wxPERL_USE_TOGGLEBTN
#   error "Recompile wxWindows with wxUSE_TOGGLEBTN"
#endif

#endif    
