/////////////////////////////////////////////////////////////////////////////
// Name:        window.h
// Purpose:     c++ wrapper for wxWindow
// Author:      Mattia Barbon
// Modified by:
// Created:      3/11/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

WXPLI_DECLARE_CLASS_6( Window, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxString& );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliWindow, wxWindow );

// Local variables: //
// mode: c++ //
// End: //
