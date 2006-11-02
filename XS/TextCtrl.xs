#############################################################################
## Name:        XS/TextCtrl.xs
## Purpose:     XS for Wx::TextCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: TextCtrl.xs,v 1.22 2006/11/02 18:38:13 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2005-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/textctrl.h>

MODULE=Wx PACKAGE=Wx::TextUrlEvent

wxMouseEvent*
wxTextUrlEvent::GetMouseEvent()
  CODE:
    RETVAL = new wxMouseEvent( THIS->GetMouseEvent() );
  OUTPUT:
    RETVAL

long
wxTextUrlEvent::GetURLStart()

long
wxTextUrlEvent::GetURLEnd()

MODULE=Wx PACKAGE=Wx::TextAttr

wxTextAttr*
wxTextAttr::new( colText = wxNullColour, colBack = wxNullColour, font = (wxFont*)&wxNullFont )
    wxColour colText
    wxColour colBack
    wxFont* font
  CODE:
    if( items == 1 )
        RETVAL = new wxTextAttr();
    else
        RETVAL = new wxTextAttr( colText, colBack, *font );
  OUTPUT:
    RETVAL

## // thread KO
void
wxTextAttr::DESTROY()

wxColour*
wxTextAttr::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

wxFont*
wxTextAttr::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

wxColour*
wxTextAttr::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

bool
wxTextAttr::HasBackgroundColour()

bool
wxTextAttr::HasFont()

bool
wxTextAttr::HasTextColour()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxTextCtrl::HitTest( pt )
    wxPoint pt
  PPCODE:
    long col, row;
    wxTextCtrlHitTestResult res = THIS->HitTest( pt, &col, &row );

    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( res ) ) );
    PUSHs( sv_2mortal( newSViv( col ) ) );
    PUSHs( sv_2mortal( newSViv( row ) ) );

#endif

bool
wxTextAttr::IsDefault()

MODULE=Wx PACKAGE=Wx::TextCtrl

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::TextCtrl::new" )

wxTextCtrl*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxTextCtrl();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxTextCtrl*
newFull( CLASS, parent, id, value, pos = wxDefaultPosition, size = wxDefaultSize, style = 0 , validator = (wxValidator*)&wxDefaultValidator, name = wxTextCtrlNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxString value
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxTextCtrl( parent, id, value, pos, size,
                             style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxTextCtrl::Create( parent, id, value, pos = wxDefaultPosition, size = wxDefaultSize, style = 0 , validator = (wxValidator*)&wxDefaultValidator, name = wxTextCtrlNameStr )
    wxWindow* parent
    wxWindowID id
    wxString value
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, value, pos, size, style, *validator, name

void
wxTextCtrl::AppendText( text )
    wxString text

bool
wxTextCtrl::CanCopy()

bool
wxTextCtrl::CanCut()

bool
wxTextCtrl::CanPaste()

bool
wxTextCtrl::CanRedo()

bool
wxTextCtrl::CanUndo()

void
wxTextCtrl::Clear()

void
wxTextCtrl::Copy()

void
wxTextCtrl::Cut()

void
wxTextCtrl::DiscardEdits()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxTextCtrl::EmulateKeyPress( event )
    wxKeyEvent* event
  C_ARGS: *event

void
wxTextCtrl::MarkDirty()

#endif

wxTextAttr*
wxTextCtrl::GetDefaultStyle()
  CODE:
    RETVAL = new wxTextAttr( THIS->GetDefaultStyle() );
  OUTPUT:
    RETVAL

long
wxTextCtrl::GetInsertionPoint()

long
wxTextCtrl::GetLastPosition()

int
wxTextCtrl::GetLineLength( lineno )
    int lineno

wxString
wxTextCtrl::GetLineText( lineno )
    int lineno

int
wxTextCtrl::GetNumberOfLines()

wxString
wxTextCtrl::GetRange( from, to )
    long from
    long to

void
wxTextCtrl::GetSelection()
  PREINIT:
    long from;
    long to;
  PPCODE:
    THIS->GetSelection( &from, &to );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( from ) ) );
    PUSHs( sv_2mortal( newSViv( to ) ) );

wxString
wxTextCtrl::GetStringSelection()

wxString
wxTextCtrl::GetValue()

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

bool
wxTextCtrl::IsEmpty()

#endif

bool
wxTextCtrl::IsModified()

bool
wxTextCtrl::IsSingleLine()

bool
wxTextCtrl::IsMultiLine()

bool
wxTextCtrl::LoadFile( filename )
    wxString filename

void
wxTextCtrl::Paste()

void
wxTextCtrl::PositionToXY( pos )
    long pos
  PREINIT:
    long x;
    long y;
  PPCODE:
    THIS->PositionToXY( pos, &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

void
wxTextCtrl::Redo()

void
wxTextCtrl::Remove( from, to )
    long from
    long to

void
wxTextCtrl::Replace( from, to, value )
    long from
    long to
    wxString value

bool
wxTextCtrl::SaveFile( filename )
    wxString filename

void
wxTextCtrl::SetDefaultStyle( style )
    wxTextAttr* style
  CODE:
    THIS->SetDefaultStyle( *style );

void
wxTextCtrl::SetEditable( editable )
    bool editable

void
wxTextCtrl::SetInsertionPoint( pos )
    long pos

void
wxTextCtrl::SetInsertionPointEnd()

void
wxTextCtrl::SetMaxLength( len )
    unsigned long len

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

void
wxTextCtrl::SetModified( modified )
    bool modified

#endif

void
wxTextCtrl::SetSelection( from, to )
    long from
    long to

void
wxTextCtrl::SetStyle( start, end, style )
    long start
    long end
    wxTextAttr* style
  CODE:
    THIS->SetStyle( start, end, *style );

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

void
wxTextCtrl::ChangeValue( value )
    wxString value

#endif

void
wxTextCtrl::SetValue( value )
    wxString value

void
wxTextCtrl::ShowPosition( pos )
    long pos

void
wxTextCtrl::Undo()

void
wxTextCtrl::WriteText( text )
    wxString text

long
wxTextCtrl::XYToPosition( x, y )
    long x
    long y
