#############################################################################
## Name:        XS/FileDialog.xs
## Purpose:     XS for Wx::FileDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      $Id: FileDialog.xs,v 1.9 2006/11/19 16:06:44 mbarbon Exp $
## Copyright:   (c) 2000-2002, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filedlg.h>

MODULE=Wx PACKAGE=Wx::FileDialog

wxFileDialog*
wxFileDialog::new( parent, message = wxFileSelectorPromptStr, defaultDir = wxEmptyString, defaultFile = wxEmptyString, wildcard = wxFileSelectorDefaultWildcardStr, style = 0, pos = wxDefaultPosition )
    wxWindow* parent
    wxString message
    wxString defaultDir
    wxString defaultFile
    wxString wildcard
    long style
    wxPoint pos

wxString
wxFileDialog::GetDirectory()

wxString
wxFileDialog::GetFilename()

void
wxFileDialog::GetFilenames()
  PREINIT:
    wxArrayString filenames;
    int i, max;
  PPCODE:
    THIS->GetFilenames( filenames );
    max = filenames.GetCount();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i ) {
#if wxUSE_UNICODE
      SV* tmp = sv_2mortal( newSVpv( filenames[i].mb_str(wxConvUTF8), 0 ) );
      SvUTF8_on( tmp );
      PUSHs( tmp );
#else
      PUSHs( sv_2mortal( newSVpv( CHAR_P filenames[i].c_str(), 0 ) ) );
#endif
    }

int
wxFileDialog::GetFilterIndex()

wxString
wxFileDialog::GetMessage()

wxString
wxFileDialog::GetPath()

void
wxFileDialog::GetPaths()
  PREINIT:
    wxArrayString filenames;
    int i, max;
  PPCODE:
    THIS->GetPaths( filenames );
    max = filenames.GetCount();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i ) {
#if wxUSE_UNICODE
      SV* tmp = sv_2mortal( newSVpv( filenames[i].mb_str(wxConvUTF8), 0 ) );
      SvUTF8_on( tmp );
      PUSHs( tmp );
#else
      PUSHs( sv_2mortal( newSVpv( CHAR_P filenames[i].c_str(), 0 ) ) );
#endif
    }

#if WXPERL_W_VERSION_LT( 2, 7, 0 )

long
wxFileDialog::GetStyle()

#endif

wxString
wxFileDialog::GetWildcard()

void
wxFileDialog::SetDirectory( directory )
    wxString directory

void
wxFileDialog::SetFilename( name )
    wxString name

void
wxFileDialog::SetFilterIndex( index )
    int index

void
wxFileDialog::SetMessage( message )
    wxString message

void
wxFileDialog::SetPath( path )
    wxString path

#if WXPERL_W_VERSION_LT( 2, 7, 0 )

void
wxFileDialog::SetStyle( style )
    long style

#endif

void
wxFileDialog::SetWildcard( wildcard )
    wxString wildcard

int
wxFileDialog::ShowModal()

MODULE=Wx PACKAGE=Wx PREFIX=wx

wxString
wxFileSelector( message, default_path = wxEmptyString, default_filename = wxEmptyString, default_extension = wxEmptyString, wildcard = wxT("*.*"), flags = 0, parent = 0, x = -1, y = -1 )
    wxString message
    wxString default_path
    wxString default_filename
    wxString default_extension
    wxString wildcard
    int flags
    wxWindow* parent
    int x
    int y
