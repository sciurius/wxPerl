#############################################################################
## Name:        XS/ImageList.xs
## Purpose:     XS for Wx::ImageList
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: ImageList.xs,v 1.13 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2000-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%{
#include <wx/imaglist.h>

#define wxNullBitmapPtr (wxBitmap*) &wxNullBitmap
%}

%module{Wx};

%name{Wx::ImageList} class wxImageList
{
    wxImageList( int width, int height, bool mask = true,
                 int initialCount = 1 );

    %name{AddBitmap} int Add( const wxBitmap& bitmap,
                              const wxBitmap& mask = wxNullBitmapPtr );
    %name{AddWithColourMask} int Add( const wxBitmap& bitmap,
                                      const wxColour& colour );
    %name{AddIcon} int Add( const wxIcon& icon );
    bool Draw( int index, const wxDC& dc, int x, int y,
               int flags = wxIMAGELIST_DRAW_NORMAL,
               bool solidBackground = false );
    int GetImageCount();
    bool Remove( int index );
    bool RemoveAll();

#if defined( __WXMSW__ )
    %name{ReplaceBitmap} bool Replace( int index, const wxBitmap& bitmap,
                                       const wxBitmap&mask = wxNullBitmapPtr );
#else
    %name{ReplaceBitmap} bool Replace( int index, const wxBitmap& bitmap );
#endif
    %name{ReplaceIcon} bool Replace( int index, const wxIcon& icon );
#if WXPERL_W_VERSION_GE( 2, 5, 4 )
    wxBitmap GetBitmap( int index );
    wxIcon GetIcon( int index );
#endif
};

%{

MODULE=Wx PACKAGE=Wx::ImageList

static void
wxImageList::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
DESTROY( THIS )
    wxImageList* THIS
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::ImageList", THIS, ST(0) );
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;

void
wxImageList::Add( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wbmp_wcol, AddWithColourMask )
        MATCH_REDISP( wxPliOvl_wico, AddIcon )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wbmp_wbmp, AddBitmap, 1 )
    END_OVERLOAD( Wx::ImageList::Add )

void
wxImageList::GetSize( index )
    int index
  PREINIT:
    int width;
    int height;
    bool result;
  PPCODE:
    result = THIS->GetSize( index, width, height );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( result ) ) );
    PUSHs( sv_2mortal( newSViv( width ) ) );
    PUSHs( sv_2mortal( newSViv( height ) ) );

void
wxImageList::Replace( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_wico, ReplaceIcon )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_wbmp_wbmp, ReplaceBitmap, 2 )
    END_OVERLOAD( Wx::ImageList::Replace )

%}
