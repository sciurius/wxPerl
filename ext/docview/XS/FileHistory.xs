#############################################################################
## Name:        FileHistory.xs
## Purpose:     XS for wxFileHistory ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:      11/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::FileHistory

Wx_FileHistory *
Wx_FileHistory::new( maxFiles = 9 )
    int maxFiles
  CODE:
    RETVAL=new wxPliFileHistory(CLASS, maxFiles );
  OUTPUT:
    RETVAL

void
Wx_FileHistory::AddFileToHistory( file )
    wxString file

void
Wx_FileHistory::RemoveFileFromHistory( i )
    int i 

int
Wx_FileHistory::GetMaxFiles()

void
Wx_FileHistory::UseMenu( menu )
    Wx_Menu* menu

void
Wx_FileHistory::RemoveMenu( menu )
    Wx_Menu* menu

## Work out the config stuff

void
Wx_FileHistory::AddFilesToMenu( ... )
  CASE: items == 1
    CODE:
      THIS->AddFilesToMenu();
  CASE: items == 2
    INPUT:
      Wx_Menu* menu = NO_INIT
    CODE:
      THIS->AddFilesToMenu( menu );
  CASE:
    CODE:
      croak( "Usage: Wx::FileHistory::AddfilesToMenu(THIS [, menu ] )" );

wxString
Wx_FileHistory::GetHistoryFile( i )
    int i

int
wxFileHistory::GetCount()

#if !WXPERL_W_VERSION_GE( 2, 5, 0 )

int
wxFileHistory::GetNoHistoryFiles()

#endif

SV*
Wx_FileHistory::GetMenus()
  CODE:
    AV* aMenus = wxPli_objlist_2_av( aTHX_ THIS->GetMenus() );
    RETVAL = newRV_noinc( (SV*)aMenus  );
  OUTPUT: RETVAL

