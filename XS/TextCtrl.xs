#############################################################################
## Name:        XS/TextCtrl.xs
## Purpose:     XS for Wx::TextCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: TextCtrl.xs,v 1.11 2003/06/04 20:38:43 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

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

Wx_TextAttr*
Wx_TextAttr::new( colText = wxNullColour, colBack = wxNullColour, font = (Wx_Font*)&wxNullFont )
    Wx_Colour colText
    Wx_Colour colBack
    Wx_Font* font
  CODE:
    if( items == 1 )
        RETVAL = new wxTextAttr();
    else
        RETVAL = new wxTextAttr( colText, colBack, *font );
  OUTPUT:
    RETVAL

void
Wx_TextAttr::DESTROY()

Wx_Colour*
Wx_TextAttr::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

Wx_Font*
Wx_TextAttr::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_TextAttr::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

bool
Wx_TextAttr::HasBackgroundColour()

bool
Wx_TextAttr::HasFont()

bool
Wx_TextAttr::HasTextColour()

bool
Wx_TextAttr::IsDefault()

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
Wx_TextCtrl::AppendText( text )
    wxString text

bool
Wx_TextCtrl::CanCopy()

bool
Wx_TextCtrl::CanCut()

bool
Wx_TextCtrl::CanPaste()

bool
Wx_TextCtrl::CanRedo()

bool
Wx_TextCtrl::CanUndo()

void
Wx_TextCtrl::Clear()

void
Wx_TextCtrl::Copy()

void
Wx_TextCtrl::Cut()

void
Wx_TextCtrl::DiscardEdits()

Wx_TextAttr*
Wx_TextCtrl::GetDefaultStyle()
  CODE:
    RETVAL = new wxTextAttr( THIS->GetDefaultStyle() );
  OUTPUT:
    RETVAL

long
Wx_TextCtrl::GetInsertionPoint()

long
Wx_TextCtrl::GetLastPosition()

int
Wx_TextCtrl::GetLineLength( lineno )
    int lineno

wxString
Wx_TextCtrl::GetLineText( lineno )
    int lineno

int
Wx_TextCtrl::GetNumberOfLines()

wxString
Wx_TextCtrl::GetRange( from, to )
    long from
    long to

void
Wx_TextCtrl::GetSelection()
  PREINIT:
    long from;
    long to;
  PPCODE:
    THIS->GetSelection( &from, &to );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( from ) ) );
    PUSHs( sv_2mortal( newSViv( to ) ) );

wxString
Wx_TextCtrl::GetStringSelection()

wxString
Wx_TextCtrl::GetValue()

bool
Wx_TextCtrl::IsModified()

bool
wxTextCtrl::IsSingleLine()

bool
wxTextCtrl::IsMultiLine()

bool
Wx_TextCtrl::LoadFile( filename )
    wxString filename

void
Wx_TextCtrl::Paste()

void
Wx_TextCtrl::PositionToXY( pos )
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
Wx_TextCtrl::Redo()

void
Wx_TextCtrl::Remove( from, to )
    long from
    long to

void
Wx_TextCtrl::Replace( from, to, value )
    long from
    long to
    wxString value

bool
Wx_TextCtrl::SaveFile( filename )
    wxString filename

void
Wx_TextCtrl::SetDefaultStyle( style )
    Wx_TextAttr* style
  CODE:
    THIS->SetDefaultStyle( *style );

void
Wx_TextCtrl::SetEditable( editable )
    bool editable

void
Wx_TextCtrl::SetInsertionPoint( pos )
    long pos

void
Wx_TextCtrl::SetInsertionPointEnd()

void
Wx_TextCtrl::SetMaxLength( len )
    unsigned long len

void
Wx_TextCtrl::SetSelection( from, to )
    long from
    long to

void
Wx_TextCtrl::SetStyle( start, end, style )
    long start
    long end
    Wx_TextAttr* style
  CODE:
    THIS->SetStyle( start, end, *style );

void
Wx_TextCtrl::SetValue( value )
    wxString value

void
Wx_TextCtrl::ShowPosition( pos )
    long pos

void
Wx_TextCtrl::Undo()

void
Wx_TextCtrl::WriteText( text )
    wxString text

long
Wx_TextCtrl::XYToPosition( x, y )
    long x
    long y
