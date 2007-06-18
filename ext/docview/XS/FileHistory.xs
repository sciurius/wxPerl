#############################################################################
## Name:        ext/docview/XS/FileHistory.xs
## Purpose:     XS for wxFileHistory (Document/View Framework)
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::FileHistory

wxFileHistory *
wxFileHistory::new( maxFiles = 9 )
    int maxFiles
  CODE:
    RETVAL=new wxPliFileHistory(CLASS, maxFiles );
  OUTPUT:
    RETVAL

void
wxFileHistory::AddFileToHistory( file )
    wxString file

void
wxFileHistory::RemoveFileFromHistory( i )
    int i 

int
wxFileHistory::GetMaxFiles()

void
wxFileHistory::UseMenu( menu )
    wxMenu* menu

void
wxFileHistory::RemoveMenu( menu )
    wxMenu* menu

## Work out the config stuff

void
wxFileHistory::AddFilesToMenu( ... )
  CASE: items == 1
    CODE:
      THIS->AddFilesToMenu();
  CASE: items == 2
    INPUT:
      wxMenu* menu = NO_INIT
    CODE:
      THIS->AddFilesToMenu( menu );
  CASE:
    CODE:
      croak( "Usage: Wx::FileHistory::AddfilesToMenu(THIS [, menu ] )" );

wxString
wxFileHistory::GetHistoryFile( i )
    int i

int
wxFileHistory::GetCount()

#if WXPERL_W_VERSION_LT( 2, 5, 1 )

int
wxFileHistory::GetNoHistoryFiles()

#endif

SV*
wxFileHistory::GetMenus()
  CODE:
    AV* aMenus = wxPli_objlist_2_av( aTHX_ THIS->GetMenus() );
    RETVAL = newRV_noinc( (SV*)aMenus  );
  OUTPUT: RETVAL

