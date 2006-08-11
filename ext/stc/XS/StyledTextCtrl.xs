#############################################################################
## Name:        ext/stc/XS/StyledTextCtrl.xs
## Purpose:     XS for Wx::StyledTextCtrl
## Author:      Marcus Friedlaender and Mattia Barbon
## Created:     23/05/2002
## RCS-ID:      $Id: StyledTextCtrl.xs,v 1.20 2006/08/11 19:54:59 mbarbon Exp $
## Copyright:   (c) 2002-2004, 2006 Graciliano M. P., Marcus Friedlaender,
##                  Mattia Barbon, Simon Flack
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StyledTextCtrl

#undef FindText
#include "wx/stc/stc.h"

wxStyledTextCtrl*
wxStyledTextCtrl::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxSTCNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxStyledTextCtrl( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

void
wxStyledTextCtrl::AddText( text )
    wxString text

void
wxStyledTextCtrl::SetLexer( lexer )
    int lexer

int
wxStyledTextCtrl::GetLexer()


## Extract style settings from a spec-string which is composed of one or
## more of the following comma separated elements:
##
##      bold                    turns on bold
##      italic                  turns on italics
##      fore:#RRGGBB            sets the foreground colour
##      back:#RRGGBB            sets the background colour
##      face:[facename]         sets the font face name to use
##      size:[num]              sets the font size in points
##      eol                     turns on eol filling
##      underline               turns on underlining

void
wxStyledTextCtrl::StyleSetSpec( style, spec )
    int style
    wxString spec

void
wxStyledTextCtrl::StyleSetFont( style, font )
    int style
    wxFont* font
  CODE:
    THIS->StyleSetFont( style, *font );

void
wxStyledTextCtrl::StyleSetFontAttr( styleNum, size, faceName, bold, italic, underline )
    int styleNum
    int size
    wxString faceName
    bool bold
    bool italic
    bool underline

void
wxStyledTextCtrl::StyleClearAll()

void
wxStyledTextCtrl::ClearDocumentStyle()

void
wxStyledTextCtrl::StyleSetForeground( style, fore )
    int style
    wxColour* fore
  CODE:
    THIS->StyleSetForeground( style, *fore );

void
wxStyledTextCtrl::StyleSetBackground( style, back )
    int style
    wxColour* back
  CODE:
    THIS->StyleSetBackground( style, *back );

void
wxStyledTextCtrl::StyleSetBold( style, bold )
    int style
    bool bold

void
wxStyledTextCtrl::StyleSetItalic( style, italic )
    int style
    bool italic

void
wxStyledTextCtrl::StyleSetUnderline( style, underline )
    int style
    bool underline

void
wxStyledTextCtrl::InsertText(pos, text)
    int pos
    wxString text

void
wxStyledTextCtrl::StyleSetSize(style, size_points)
    int style
    int size_points

void
wxStyledTextCtrl::StyleSetFaceName(style, font_name)
    int style
    wxString font_name

void
wxStyledTextCtrl::StyleSetEOLFilled( style, filled )
    int style
    bool filled

void
wxStyledTextCtrl::StyleResetDefault()

void
wxStyledTextCtrl::StyleSetCase( style, caseForce )
    int style
    int caseForce

void
wxStyledTextCtrl::StyleSetCharacterSet( style, characterSet )
    int style
    int characterSet

void
wxStyledTextCtrl::SetSelForeground( useSetting, fore )
    bool useSetting
    wxColour* fore
  CODE:
    THIS->SetSelForeground( useSetting, *fore );

void
wxStyledTextCtrl::SetSelBackground( useSetting, back )
    bool useSetting
    wxColour* back
  CODE:
    THIS->SetSelBackground( useSetting, *back );

void
wxStyledTextCtrl::SetCaretForeground( fore )
    wxColour* fore
  CODE:
    THIS->SetCaretForeground( *fore );

void
wxStyledTextCtrl::CmdKeyAssign( key, modifiers, cmd )
    int key
    int modifiers
    int cmd

void
wxStyledTextCtrl::CmdKeyClear( key, modifiers )
    int key
    int modifiers

void
wxStyledTextCtrl::CmdKeyClearAll()

void
wxStyledTextCtrl::SetStyleBytes( length, styleBytes )
    int length
    char* styleBytes

void
wxStyledTextCtrl::StyleSetVisible( style, visible )
    int style
    bool visible

int
wxStyledTextCtrl::GetCaretPeriod()

void
wxStyledTextCtrl::SetCaretPeriod( periodMilliseconds )
    int periodMilliseconds

void
wxStyledTextCtrl::SetWordChars( characters )
    wxString characters

void
wxStyledTextCtrl::BeginUndoAction()

void
wxStyledTextCtrl::EndUndoAction()

void
wxStyledTextCtrl::IndicatorSetStyle( indic, style )
    int indic
    int style

int
wxStyledTextCtrl::IndicatorGetStyle( indic )
    int indic

void
wxStyledTextCtrl::IndicatorSetForeground( indic, fore )
    int indic
    wxColour* fore
  CODE:
    THIS->IndicatorSetForeground( indic, *fore );

void
wxStyledTextCtrl::SetWhitespaceForeground( useSetting, fore )
    bool useSetting
    wxColour* fore
  CODE:
    THIS->SetWhitespaceForeground( useSetting, *fore );

void
wxStyledTextCtrl::SetWhitespaceBackground( useSetting, back )
    bool useSetting
    wxColour* back
  CODE:
    THIS->SetWhitespaceBackground( useSetting, *back );

void
wxStyledTextCtrl::SetStyleBits( bits )
    int bits

int
wxStyledTextCtrl::GetStyleBits()

void
wxStyledTextCtrl::SetLineState( line, state )
    int line
    int state

int
wxStyledTextCtrl::GetLineState( line )
    int line

int
wxStyledTextCtrl::GetMaxLineState()

bool
wxStyledTextCtrl::GetCaretLineVisible()

void
wxStyledTextCtrl::SetCaretLineVisible( show )
    bool show

void
wxStyledTextCtrl::SetCaretLineBack( back )
    wxColour* back
  CODE:
    THIS->SetCaretLineBack( *back );

void
wxStyledTextCtrl::StyleSetChangeable( style, changeable )
    int style
    bool changeable

void
wxStyledTextCtrl::AutoCompShow( lenEntered, itemList )
    int lenEntered
    wxString itemList

void
wxStyledTextCtrl::AutoCompCancel()

bool
wxStyledTextCtrl::AutoCompActive()

int
wxStyledTextCtrl::AutoCompPosStart()

void
wxStyledTextCtrl::AutoCompComplete()

void
wxStyledTextCtrl::AutoCompStops( characterSet )
    wxString characterSet

void
wxStyledTextCtrl::AutoCompSetSeparator( separatorCharacter )
    int separatorCharacter

int
wxStyledTextCtrl::AutoCompGetSeparator()

void
wxStyledTextCtrl::AutoCompSelect( text )
    wxString text

void
wxStyledTextCtrl::AutoCompSetCancelAtStart( cancel )
    bool cancel

bool
wxStyledTextCtrl::AutoCompGetCancelAtStart()

void
wxStyledTextCtrl::AutoCompSetFillUps( characterSet )
    wxString characterSet

void
wxStyledTextCtrl::AutoCompSetChooseSingle( chooseSingle )
    bool chooseSingle

bool
wxStyledTextCtrl::AutoCompGetChooseSingle()

bool
wxStyledTextCtrl::AutoCompGetIgnoreCase()

void
wxStyledTextCtrl::UserListShow( listType, itemList )
    int listType
    wxString itemList

void
wxStyledTextCtrl::AutoCompSetAutoHide( autoHide )
    bool autoHide

bool
wxStyledTextCtrl::AutoCompGetAutoHide()

void
wxStyledTextCtrl::AutoCompSetDropRestOfWord( dropRestOfWord )
    bool dropRestOfWord

bool
wxStyledTextCtrl::AutoCompGetDropRestOfWord()

void
wxStyledTextCtrl::SetIndent( indentSize )
    int indentSize

int
wxStyledTextCtrl::GetIndent()

void
wxStyledTextCtrl::SetUseTabs( useTabs )
    bool useTabs

bool
wxStyledTextCtrl::GetUseTabs()

void
wxStyledTextCtrl::SetLineIndentation( line, indentSize )
    int line
    int indentSize

int
wxStyledTextCtrl::GetLineIndentation( line )
    int line

int
wxStyledTextCtrl::GetLineIndentPosition( line )
    int line

int
wxStyledTextCtrl::GetColumn( pos )
    int pos

void
wxStyledTextCtrl::SetUseHorizontalScrollBar( show )
    bool show

bool
wxStyledTextCtrl::GetUseHorizontalScrollBar()

void
wxStyledTextCtrl::SetIndentationGuides( show )
    bool show

bool
wxStyledTextCtrl::GetIndentationGuides()

void
wxStyledTextCtrl::SetHighlightGuide( column )
    int column

int
wxStyledTextCtrl::GetHighlightGuide()

int
wxStyledTextCtrl::GetLineEndPosition( line )
    int line

int
wxStyledTextCtrl::GetCodePage()

bool
wxStyledTextCtrl::GetReadOnly()

void
wxStyledTextCtrl::SetCurrentPos( pos )
    int pos

void
wxStyledTextCtrl::SetSelectionStart( pos )
    int pos

int
wxStyledTextCtrl::GetSelectionStart()

void
wxStyledTextCtrl::SetSelectionEnd( pos )
    int pos

int
wxStyledTextCtrl::GetSelectionEnd()

void
wxStyledTextCtrl::SetPrintMagnification( magnification )
    int magnification

int
wxStyledTextCtrl::GetPrintMagnification()

void
wxStyledTextCtrl::SetPrintColourMode( mode )
    int mode

int
wxStyledTextCtrl::GetPrintColourMode()

int
wxStyledTextCtrl::FindText( minPos, maxPos, text, flags = 0 )
    int minPos
    int maxPos
    wxString text
    int flags

int
wxStyledTextCtrl::GetFirstVisibleLine()

int
wxStyledTextCtrl::GetLineCount()

void
wxStyledTextCtrl::SetMarginLeft( pixelWidth )
    int pixelWidth

int
wxStyledTextCtrl::GetMarginLeft()

void
wxStyledTextCtrl::SetMarginRight( pixelWidth )
    int pixelWidth

int
wxStyledTextCtrl::GetMarginRight()

bool
wxStyledTextCtrl::GetModify()

void
wxStyledTextCtrl::SetSelection( start, end )
    int start
    int end

#if WXPERL_W_VERSION_GE( 2, 6, 0 )

void
wxStyledTextCtrl::SetSelectionMode( mode )
    int mode

int
wxStyledTextCtrl::GetSelectionMode()

#endif

void
wxStyledTextCtrl::HideSelection( normal )
    bool normal

int
wxStyledTextCtrl::LineFromPosition( pos )
    int pos

int
wxStyledTextCtrl::PositionFromLine( line )
    int line

void
wxStyledTextCtrl::LineScroll( columns, lines )
    int columns
    int lines

void
wxStyledTextCtrl::EnsureCaretVisible()

void
wxStyledTextCtrl::ReplaceSelection( text )
    wxString text

void
wxStyledTextCtrl::SetReadOnly( readOnly )
    bool readOnly

bool
wxStyledTextCtrl::CanPaste()

bool
wxStyledTextCtrl::CanUndo()

void
wxStyledTextCtrl::EmptyUndoBuffer()

void
wxStyledTextCtrl::Undo()

void
wxStyledTextCtrl::Cut()

void
wxStyledTextCtrl::Copy()

void
wxStyledTextCtrl::Paste()

void
wxStyledTextCtrl::Clear()

int
wxStyledTextCtrl::GetTextLength()

void
wxStyledTextCtrl::SetOvertype( overtype )
    bool overtype

bool
wxStyledTextCtrl::GetOvertype()

void
wxStyledTextCtrl::SetCaretWidth( pixelWidth )
    int pixelWidth

int
wxStyledTextCtrl::GetCaretWidth()

void
wxStyledTextCtrl::SetTargetStart( pos )
    int pos

int
wxStyledTextCtrl::GetTargetStart()

void
wxStyledTextCtrl::SetTargetEnd( pos )
    int pos

int
wxStyledTextCtrl::GetTargetEnd()

int
wxStyledTextCtrl::ReplaceTarget( text )
    wxString text

int
wxStyledTextCtrl::ReplaceTargetRE( text )
    wxString text

int
wxStyledTextCtrl::SearchInTarget( text )
    wxString text

void
wxStyledTextCtrl::SetSearchFlags( flags )
    int flags

int
wxStyledTextCtrl::GetSearchFlags()

void
wxStyledTextCtrl::CallTipShow( pos, definition )
    int pos
    wxString definition

void
wxStyledTextCtrl::CallTipCancel()

bool
wxStyledTextCtrl::CallTipActive()

int
wxStyledTextCtrl::CallTipPosAtStart()

void
wxStyledTextCtrl::CallTipSetHighlight( start, end )
    int start
    int end

void
wxStyledTextCtrl::CallTipSetBackground( back )
    wxColour* back
  CODE:
    THIS->CallTipSetBackground( *back );

int
wxStyledTextCtrl::VisibleFromDocLine( line )
    int line

int
wxStyledTextCtrl::DocLineFromVisible( lineDisplay )
    int lineDisplay

void
wxStyledTextCtrl::SetFoldLevel( line, level )
    int line
    int level

int
wxStyledTextCtrl::GetFoldLevel( line )
    int line

int
wxStyledTextCtrl::GetLastChild( line, level )
    int line
    int level

int
wxStyledTextCtrl::GetFoldParent( line )
    int line

void
wxStyledTextCtrl::ShowLines( lineStart, lineEnd )
    int lineStart
    int lineEnd

void
wxStyledTextCtrl::HideLines( lineStart, lineEnd )
    int lineStart
    int lineEnd

bool
wxStyledTextCtrl::GetLineVisible( line )
    int line

void
wxStyledTextCtrl::SetFoldExpanded( line, expanded )
    int line
    bool expanded

bool
wxStyledTextCtrl::GetFoldExpanded( line )
    int line

void
wxStyledTextCtrl::ToggleFold( line )
    int line

void
wxStyledTextCtrl::EnsureVisible( line )
    int line

void
wxStyledTextCtrl::SetFoldFlags( flags )
    int flags

void
wxStyledTextCtrl::EnsureVisibleEnforcePolicy( line )
    int line

void
wxStyledTextCtrl::SetTabIndents( tabIndents )
    bool tabIndents

bool
wxStyledTextCtrl::GetTabIndents()

void
wxStyledTextCtrl::SetBackSpaceUnIndents( bsUnIndents )
    bool bsUnIndents

bool
wxStyledTextCtrl::GetBackSpaceUnIndents()

void
wxStyledTextCtrl::SetMouseDwellTime( periodMilliseconds )
    int periodMilliseconds

int
wxStyledTextCtrl::GetMouseDwellTime()

int
wxStyledTextCtrl::WordStartPosition( pos, onlyWordCharacters )
    int pos
    bool onlyWordCharacters

int
wxStyledTextCtrl::WordEndPosition( pos, onlyWordCharacters )
    int pos
    bool onlyWordCharacters

void
wxStyledTextCtrl::SetLayoutCache( mode )
    int mode

int
wxStyledTextCtrl::GetLayoutCache()

void
wxStyledTextCtrl::SetScrollWidth( pixelWidth )
    int pixelWidth

int
wxStyledTextCtrl::GetScrollWidth()

int
wxStyledTextCtrl::TextWidth( style, text )
    int style
    wxString text

void
wxStyledTextCtrl::SetEndAtLastLine( endAtLastLine )
    bool endAtLastLine

int
wxStyledTextCtrl::GetEndAtLastLine()

int
wxStyledTextCtrl::TextHeight( line )
    int line

void
wxStyledTextCtrl::HomeDisplay()

void
wxStyledTextCtrl::HomeDisplayExtend()

void
wxStyledTextCtrl::LineEndDisplay()

void
wxStyledTextCtrl::LineEndDisplayExtend()

void
wxStyledTextCtrl::MoveCaretInsideView()

int
wxStyledTextCtrl::LineLength( line )
    int line

void
wxStyledTextCtrl::BraceHighlight( pos1, pos2 )
    int pos1
    int pos2

void
wxStyledTextCtrl::BraceBadLight( pos )
    int pos

int
wxStyledTextCtrl::BraceMatch( pos )
    int pos

bool
wxStyledTextCtrl::GetViewEOL()

void
wxStyledTextCtrl::SetViewEOL( visible )
    bool visible

void*
wxStyledTextCtrl::GetDocPointer()

void
wxStyledTextCtrl::SetDocPointer( docPointer )
    void* docPointer

void
wxStyledTextCtrl::SetModEventMask( mask )
    int mask

int
wxStyledTextCtrl::GetEdgeColumn()

void
wxStyledTextCtrl::SetEdgeColumn( column )
    int column

int
wxStyledTextCtrl::GetEdgeMode()

void
wxStyledTextCtrl::SetEdgeMode( mode )
    int mode

void
wxStyledTextCtrl::SetEdgeColour( edgeColour )
    wxColour edgeColour

void
wxStyledTextCtrl::SearchAnchor()

int
wxStyledTextCtrl::SearchNext( flags, text )
    int flags
    wxString text

int
wxStyledTextCtrl::SearchPrev( flags, text )
    int flags
    wxString text

int
wxStyledTextCtrl::LinesOnScreen()

void
wxStyledTextCtrl::UsePopUp( allowPopUp )
    bool allowPopUp

bool
wxStyledTextCtrl::SelectionIsRectangle()

void
wxStyledTextCtrl::SetZoom( zoom )
    int zoom

int
wxStyledTextCtrl::GetZoom()

void*
wxStyledTextCtrl::CreateDocument()

void
wxStyledTextCtrl::AddRefDocument( docPointer )
    void* docPointer

void
wxStyledTextCtrl::ReleaseDocument( docPointer )
    void* docPointer

int
wxStyledTextCtrl::GetModEventMask()

void
wxStyledTextCtrl::SetSTCFocus( focus )
    bool focus

bool
wxStyledTextCtrl::GetSTCFocus()

void
wxStyledTextCtrl::SetStatus( statusCode )
    int statusCode

int
wxStyledTextCtrl::GetStatus()

void
wxStyledTextCtrl::SetMouseDownCaptures( captures )
    bool captures

bool
wxStyledTextCtrl::GetMouseDownCaptures()

void
wxStyledTextCtrl::SetControlCharSymbol( symbol )
    int symbol

int
wxStyledTextCtrl::GetControlCharSymbol()

void
wxStyledTextCtrl::WordPartLeft()

void
wxStyledTextCtrl::WordPartLeftExtend()

void
wxStyledTextCtrl::WordPartRight()

void
wxStyledTextCtrl::WordPartRightExtend()

void
wxStyledTextCtrl::SetVisiblePolicy( visiblePolicy, visibleSlop )
    int visiblePolicy
    int visibleSlop

void
wxStyledTextCtrl::DelLineLeft()

void
wxStyledTextCtrl::DelLineRight()

void
wxStyledTextCtrl::SetXOffset( newOffset )
    int newOffset

int
wxStyledTextCtrl::GetXOffset()

void
wxStyledTextCtrl::SetXCaretPolicy( caretPolicy, caretSlop )
    int caretPolicy
    int caretSlop

void
wxStyledTextCtrl::SetYCaretPolicy( caretPolicy, caretSlop )
    int caretPolicy
    int caretSlop

void
wxStyledTextCtrl::StartRecord()

void
wxStyledTextCtrl::StopRecord()

void
wxStyledTextCtrl::Colourise( start, end )
    int start
    int end

void
wxStyledTextCtrl::SetProperty( key, value )
    wxString key
    wxString value

void
wxStyledTextCtrl::SetKeyWords( keywordSet, keyWords )
    int keywordSet
    wxString keyWords

void
wxStyledTextCtrl::SetLexerLanguage( language )
    wxString language

## Retrieve the selected text
wxString
wxStyledTextCtrl::GetSelectedText()

## Retrieve a range of text
wxString
wxStyledTextCtrl::GetTextRange(startPos, endPos)
    int startPos
    int endPos

## Retrieve all the text in the document.
wxString
wxStyledTextCtrl::GetText()

## Returns the position of the opposite end of the selection to the caret.
int
wxStyledTextCtrl::GetAnchor()

## Returns the style byte at the position
int
wxStyledTextCtrl::GetStyleAt(pos)
    int pos

## Redoes the next action on the undo history.
void
wxStyledTextCtrl::Redo()

## Select all the text in the document.
void
wxStyledTextCtrl::SelectAll()

## Remember the current position in the undo history as the position
## at which the document was saved.
void
wxStyledTextCtrl::SetSavePoint()

## Replace the contents of the document with the argument text.
void
wxStyledTextCtrl::SetText(text)
    wxString text

## Are there any redoable actions in the undo history?
bool
wxStyledTextCtrl::CanRedo()

## Retrieve the line number at which a particular marker is located.
int
wxStyledTextCtrl::MarkerLineFromHandle( handle )
    int handle

## Delete a marker
void
wxStyledTextCtrl::MarkerDeleteHandle( handle )
    int handle

## Is undo history being collected?
bool
wxStyledTextCtrl::GetUndoCollection()

## Are white space characters currently visible?
## Returns one of SCWS_* constants.
int
wxStyledTextCtrl::GetViewWhiteSpace()

## Make white space characters invisible, always visible or visible outside indentation.
void
wxStyledTextCtrl::SetViewWhiteSpace( viewWs )
    int viewWs

## Find the position from a point within the window.
int
wxStyledTextCtrl::PositionFromPoint( pt )
    wxPoint pt

int
wxStyledTextCtrl::PositionFromPointClose( x, y )
    int x
    int y

## Set caret to start of a line and ensure it is visible.
void
wxStyledTextCtrl::GotoLine(line)
    int line

## Set caret to a position and ensure it is visible.
void
wxStyledTextCtrl::GotoPos(pos)
    int pos

void
wxStyledTextCtrl::SetAnchor( posAnchor )
    int posAnchor

int
wxStyledTextCtrl::GetEndStyled()

void
wxStyledTextCtrl::ConvertEOLs( eolMode )
    int eolMode

int
wxStyledTextCtrl::GetEOLMode()

void
wxStyledTextCtrl::SetEOLMode( eolMode )
    int eolMode

void
wxStyledTextCtrl::StartStyling( pos, mask )
    int pos
    int mask

void
wxStyledTextCtrl::SetStyling( length, style )
    int length
    int style

bool
wxStyledTextCtrl::GetBufferedDraw()

void
wxStyledTextCtrl::SetBufferedDraw( buffered )
    bool buffered

void
wxStyledTextCtrl::SetTabWidth( tabWidth )
    int tabWidth

int
wxStyledTextCtrl::GetTabWidth()

void
wxStyledTextCtrl::SetCodePage( codePage )
    int codePage

void
wxStyledTextCtrl::MarkerDefine( markerNumber, markerSymbol, foreground, background )
    int markerNumber
    int markerSymbol
    wxColour* foreground
    wxColour* background
  CODE:
    THIS->MarkerDefine( markerNumber, markerSymbol, *foreground, *background );

void
wxStyledTextCtrl::MarkerDefineBitmap( markerNumber, bmp )
    int markerNumber
    wxBitmap* bmp
  C_ARGS: markerNumber, *bmp

void
wxStyledTextCtrl::MarkerSetForeground( markerNumber, fore )
    int markerNumber
    wxColour* fore
  CODE:
    THIS->MarkerSetForeground( markerNumber, *fore );

void
wxStyledTextCtrl::MarkerSetBackground( markerNumber, back )
    int markerNumber
    wxColour* back
  CODE:
    THIS->MarkerSetBackground( markerNumber, *back );

int
wxStyledTextCtrl::MarkerAdd( line, markerNumber )
    int line
    int markerNumber

void
wxStyledTextCtrl::MarkerDelete( line, markerNumber )
    int line
    int markerNumber

void
wxStyledTextCtrl::MarkerDeleteAll( markerNumber )
    int markerNumber

int
wxStyledTextCtrl::MarkerGet( line )
    int line

int
wxStyledTextCtrl::MarkerNext( lineStart, markerMask )
    int lineStart
    int markerMask

int
wxStyledTextCtrl::MarkerPrevious( lineStart, markerMask )
    int lineStart
    int markerMask

void
wxStyledTextCtrl::SetMarginType( margin, marginType )
    int margin
    int marginType

int
wxStyledTextCtrl::GetMarginType( margin )
    int margin

void
wxStyledTextCtrl::SetMarginWidth( margin, pixelWidth )
    int margin
    int pixelWidth

int
wxStyledTextCtrl::GetMarginWidth( margin )
    int margin

void
wxStyledTextCtrl::SetMarginMask( margin, mask )
    int margin
    int mask

int
wxStyledTextCtrl::GetMarginMask( margin )
    int margin

void
wxStyledTextCtrl::SetMarginSensitive( margin, sensitive )
    int margin
    bool sensitive

bool
wxStyledTextCtrl::GetMarginSensitive( margin )
    int margin


## Returns the position of the caret
int
wxStyledTextCtrl::GetCurrentPos()

int
wxStyledTextCtrl::GetLength()

int
wxStyledTextCtrl::GetCharAt( pos )
    int pos

## Sets whether text is word wrapped
void
wxStyledTextCtrl::SetWrapMode(mode)
    int mode

## Retrieve whether text is word wrapped
int
wxStyledTextCtrl::GetWrapMode()

## Retrieve the contents of a line.
wxString
wxStyledTextCtrl::GetLine(line)
    int line

## Delete all text in the document
void
wxStyledTextCtrl::ClearAll()

## Returns the line number of the line with the caret.
int
wxStyledTextCtrl::GetCurrentLine()

void
wxStyledTextCtrl::CmdKeyExecute( cmd )
    int cmd

void
wxStyledTextCtrl::SetMargins( left, right )
    int left
    int right

void
wxStyledTextCtrl::SetUndoCollection( collectUndo )
    bool collectUndo

wxColour*
wxStyledTextCtrl::IndicatorGetForeground( indic )
    int indic
  CODE:
    RETVAL = new wxColour( THIS->IndicatorGetForeground( indic ) );
  OUTPUT:
    RETVAL

wxColour*
wxStyledTextCtrl::GetCaretLineBack()
  CODE:
    RETVAL = new wxColour( THIS->GetCaretLineBack() );
  OUTPUT:
    RETVAL

wxColour*
wxStyledTextCtrl::GetCaretForeground()
  CODE:
    RETVAL = new wxColour( THIS->GetCaretForeground() );
  OUTPUT:
    RETVAL

int
wxStyledTextCtrl::FormatRange( doDraw , startPos , endPos , draw , target , renderRect , pageRect )
    bool   doDraw
    int    startPos
    int    endPos
    wxDC*  draw
    wxDC*  target
    wxRect* renderRect
    wxRect* pageRect
  CODE:
    RETVAL = THIS->FormatRange( doDraw, startPos, endPos, draw,
                                target, *renderRect, *pageRect );
  OUTPUT:
    RETVAL

wxColour*
wxStyledTextCtrl::GetEdgeColour()
  CODE:
    RETVAL = new wxColour( THIS->GetEdgeColour() );
  OUTPUT:
    RETVAL

bool
wxStyledTextCtrl::GetLastKeydownProcessed()

void
wxStyledTextCtrl::SetLastKeydownProcessed( val )
    bool val

wxPoint*
wxStyledTextCtrl::PointFromPosition( pos )
    int pos
  CODE:
    RETVAL = new wxPoint( THIS->PointFromPosition( pos ) );
  OUTPUT: RETVAL

void
wxStyledTextCtrl::ScrollToLine( line )
    int line

void
wxStyledTextCtrl::SetHScrollBar( bar )
    wxScrollBar* bar

void
wxStyledTextCtrl::SetVScrollBar( bar )
    wxScrollBar* bar

void
wxStyledTextCtrl::GetSelection()
  PREINIT:
    int start, end;
  PPCODE:
    THIS->GetSelection( &start, &end );
    XPUSHs( newSViv( start ) );
    XPUSHs( newSViv( end ) );

bool
wxStyledTextCtrl::SaveFile(wxString filename)

bool
wxStyledTextCtrl::LoadFile(wxString filename)
