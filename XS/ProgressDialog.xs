#############################################################################
## Name:        XS/ProgressDialog.xs
## Purpose:     XS for Wx::ProgressDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     29/12/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2002, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/progdlg.h>

MODULE=Wx PACKAGE=Wx::ProgressDialog

wxProgressDialog*
wxProgressDialog::new( title, message, maximum = 100, parent = 0, style = wxPD_AUTO_HIDE|wxPD_APP_MODAL )
    wxString title
    wxString message
    int maximum
    wxWindow* parent
    long style
  CODE:
    RETVAL = new wxProgressDialog( title, message, maximum, parent, style );
  OUTPUT: RETVAL

void
wxProgressDialog::Resume()


#if WXPERL_W_VERSION_GE( 2, 9, 1 )

bool
wxProgressDialog::Update( value = -1, newmsg = wxEmptyString )
    int value
    wxString newmsg
  PREINIT:
    bool skipval = false;
  CODE:
    RETVAL = THIS->Update( value, newmsg, &skipval);
    if( skipval )
        RETVAL = false;

  OUTPUT: RETVAL


bool 
wxProgressDialog::Pulse( newmsg = wxEmptyString )
	wxString newmsg
  PREINIT:
    bool skipval = false;    
  CODE:
    RETVAL = THIS->Pulse(newmsg, &skipval);
    if( skipval )
        RETVAL = false;
    
  OUTPUT: RETVAL


int
wxProgressDialog::GetRange()

int
wxProgressDialog::GetValue()

wxString
wxProgressDialog::GetMessage()

void
wxProgressDialog::SetRange( maximum )
    int maximum

bool
wxProgressDialog::WasCancelled()

bool
wxProgressDialog::WasSkipped()

bool
wxProgressDialog::Show( show = true )
	bool show

#else

bool
wxProgressDialog::Update( value = -1, newmsg = wxEmptyString )
    int value
    wxString newmsg

#if WXPERL_W_VERSION_GE( 2, 8, 0 )

bool
wxProgressDialog::Show( show = true )
	bool show

bool 
wxProgressDialog::Pulse( newmsg = wxEmptyString )
	wxString newmsg

#endif

#endif
