/////////////////////////////////////////////////////////////////////////////
// Name:        sashwindow.h
// Purpose:     c++ wrapper for wxSashWindow
// Author:      Mattia Barbon
// Modified by:
// Created:      3/ 2/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

WXPLI_DECLARE_CLASS_6( SashWindow, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxString& );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSashWindow, wxSashWindow );

// Local variables: //
// mode: c++ //
// End: //
