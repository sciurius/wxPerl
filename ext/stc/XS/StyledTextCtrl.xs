#############################################################################
## Name:        StyledTextCtrl.xs
## Purpose:     XS for Wx::StyledTextCtrl
## Author:      Marcus Friedlaender and Mattia Barbon
## Created:     23/ 5/2002
## RCS-ID:      $Id: StyledTextCtrl.xs,v 1.10 2003/12/13 17:16:56 mbarbon Exp $
## Copyright:   (c) 2002-2003 Graciliano M. P., Marcus Friedlaender,
##                            Mattia Barbon, Simon Flack
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StyledTextCtrl

#undef FindText
#include "wx/stc/stc.h"

Wx_StyledTextCtrl*
Wx_StyledTextCtrl::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxSTCNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name

void
Wx_StyledTextCtrl::AddText( text )
    wxString text

void
Wx_StyledTextCtrl::SetLexer( lexer )
    int lexer

int
Wx_StyledTextCtrl::GetLexer()


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
Wx_StyledTextCtrl::StyleSetSpec( style, spec )
    int style
    wxString spec

void
Wx_StyledTextCtrl::StyleSetFont( style, font )
    int style
    Wx_Font* font
  CODE:
    THIS->StyleSetFont( style, *font );

void
Wx_StyledTextCtrl::StyleSetFontAttr( styleNum, size, faceName, bold, italic, underline )
    int styleNum
    int size
    wxString faceName
    bool bold
    bool italic
    bool underline

void
Wx_StyledTextCtrl::StyleClearAll()

void
Wx_StyledTextCtrl::ClearDocumentStyle()

void
Wx_StyledTextCtrl::StyleSetForeground( style, fore )
    int style
    Wx_Colour* fore
  CODE:
    THIS->StyleSetForeground( style, *fore );

void
Wx_StyledTextCtrl::StyleSetBackground( style, back )
    int style
    Wx_Colour* back
  CODE:
    THIS->StyleSetBackground( style, *back );

void
Wx_StyledTextCtrl::StyleSetBold( style, bold )
    int style
    bool bold

void
Wx_StyledTextCtrl::StyleSetItalic( style, italic )
    int style
    bool italic

void
Wx_StyledTextCtrl::StyleSetUnderline( style, underline )
    int style
    bool underline

void
Wx_StyledTextCtrl::InsertText(pos, text)
    int pos
    wxString text

void
Wx_StyledTextCtrl::StyleSetSize(style, size_points)
    int style
    int size_points

void
Wx_StyledTextCtrl::StyleSetFaceName(style, font_name)
    int style
    wxString font_name

void
Wx_StyledTextCtrl::StyleSetEOLFilled( style, filled )
    int style
    bool filled

void
Wx_StyledTextCtrl::StyleResetDefault()

void
Wx_StyledTextCtrl::StyleSetCase( style, caseForce )
    int style
    int caseForce

void
Wx_StyledTextCtrl::StyleSetCharacterSet( style, characterSet )
    int style
    int characterSet

void
Wx_StyledTextCtrl::SetSelForeground( useSetting, fore )
    bool useSetting
    Wx_Colour* fore
  CODE:
    THIS->SetSelForeground( useSetting, *fore );

void
Wx_StyledTextCtrl::SetSelBackground( useSetting, back )
    bool useSetting
    Wx_Colour* back
  CODE:
    THIS->SetSelBackground( useSetting, *back );

void
Wx_StyledTextCtrl::SetCaretForeground( fore )
    Wx_Colour* fore
  CODE:
    THIS->SetCaretForeground( *fore );

void
Wx_StyledTextCtrl::CmdKeyAssign( key, modifiers, cmd )
    int key
    int modifiers
    int cmd

void
Wx_StyledTextCtrl::CmdKeyClear( key, modifiers )
    int key
    int modifiers

void
Wx_StyledTextCtrl::CmdKeyClearAll()

void
Wx_StyledTextCtrl::SetStyleBytes( length, styleBytes )
    int length
    char* styleBytes

void
Wx_StyledTextCtrl::StyleSetVisible( style, visible )
    int style
    bool visible

int
Wx_StyledTextCtrl::GetCaretPeriod()

void
Wx_StyledTextCtrl::SetCaretPeriod( periodMilliseconds )
    int periodMilliseconds

void
Wx_StyledTextCtrl::SetWordChars( characters )
    wxString characters

void
Wx_StyledTextCtrl::BeginUndoAction()

void
Wx_StyledTextCtrl::EndUndoAction()

void
Wx_StyledTextCtrl::IndicatorSetStyle( indic, style )
    int indic
    int style

int
Wx_StyledTextCtrl::IndicatorGetStyle( indic )
    int indic

void
Wx_StyledTextCtrl::IndicatorSetForeground( indic, fore )
    int indic
    Wx_Colour* fore
  CODE:
    THIS->IndicatorSetForeground( indic, *fore );

void
Wx_StyledTextCtrl::SetWhitespaceForeground( useSetting, fore )
    bool useSetting
    Wx_Colour* fore
  CODE:
    THIS->SetWhitespaceForeground( useSetting, *fore );

void
Wx_StyledTextCtrl::SetWhitespaceBackground( useSetting, back )
    bool useSetting
    Wx_Colour* back
  CODE:
    THIS->SetWhitespaceBackground( useSetting, *back );

void
Wx_StyledTextCtrl::SetStyleBits( bits )
    int bits

int
Wx_StyledTextCtrl::GetStyleBits()

void
Wx_StyledTextCtrl::SetLineState( line, state )
    int line
    int state

int
Wx_StyledTextCtrl::GetLineState( line )
    int line

int
Wx_StyledTextCtrl::GetMaxLineState()

bool
Wx_StyledTextCtrl::GetCaretLineVisible()

void
Wx_StyledTextCtrl::SetCaretLineVisible( show )
    bool show

void
Wx_StyledTextCtrl::SetCaretLineBack( back )
    Wx_Colour* back
  CODE:
    THIS->SetCaretLineBack( *back );

void
Wx_StyledTextCtrl::StyleSetChangeable( style, changeable )
    int style
    bool changeable

void
Wx_StyledTextCtrl::AutoCompShow( lenEntered, itemList )
    int lenEntered
    wxString itemList

void
Wx_StyledTextCtrl::AutoCompCancel()

bool
Wx_StyledTextCtrl::AutoCompActive()

int
Wx_StyledTextCtrl::AutoCompPosStart()

void
Wx_StyledTextCtrl::AutoCompComplete()

void
Wx_StyledTextCtrl::AutoCompStops( characterSet )
    wxString characterSet

void
Wx_StyledTextCtrl::AutoCompSetSeparator( separatorCharacter )
    int separatorCharacter

int
Wx_StyledTextCtrl::AutoCompGetSeparator()

void
Wx_StyledTextCtrl::AutoCompSelect( text )
    wxString text

void
Wx_StyledTextCtrl::AutoCompSetCancelAtStart( cancel )
    bool cancel

bool
Wx_StyledTextCtrl::AutoCompGetCancelAtStart()

void
Wx_StyledTextCtrl::AutoCompSetFillUps( characterSet )
    wxString characterSet

void
Wx_StyledTextCtrl::AutoCompSetChooseSingle( chooseSingle )
    bool chooseSingle

bool
Wx_StyledTextCtrl::AutoCompGetChooseSingle()

bool
Wx_StyledTextCtrl::AutoCompGetIgnoreCase()

void
Wx_StyledTextCtrl::UserListShow( listType, itemList )
    int listType
    wxString itemList

void
Wx_StyledTextCtrl::AutoCompSetAutoHide( autoHide )
    bool autoHide

bool
Wx_StyledTextCtrl::AutoCompGetAutoHide()

void
Wx_StyledTextCtrl::AutoCompSetDropRestOfWord( dropRestOfWord )
    bool dropRestOfWord

bool
Wx_StyledTextCtrl::AutoCompGetDropRestOfWord()

void
Wx_StyledTextCtrl::SetIndent( indentSize )
    int indentSize

int
Wx_StyledTextCtrl::GetIndent()

void
Wx_StyledTextCtrl::SetUseTabs( useTabs )
    bool useTabs

bool
Wx_StyledTextCtrl::GetUseTabs()

void
Wx_StyledTextCtrl::SetLineIndentation( line, indentSize )
    int line
    int indentSize

int
Wx_StyledTextCtrl::GetLineIndentation( line )
    int line

int
Wx_StyledTextCtrl::GetLineIndentPosition( line )
    int line

int
Wx_StyledTextCtrl::GetColumn( pos )
    int pos

void
Wx_StyledTextCtrl::SetUseHorizontalScrollBar( show )
    bool show

bool
Wx_StyledTextCtrl::GetUseHorizontalScrollBar()

void
Wx_StyledTextCtrl::SetIndentationGuides( show )
    bool show

bool
Wx_StyledTextCtrl::GetIndentationGuides()

void
Wx_StyledTextCtrl::SetHighlightGuide( column )
    int column

int
Wx_StyledTextCtrl::GetHighlightGuide()

int
Wx_StyledTextCtrl::GetLineEndPosition( line )
    int line

int
Wx_StyledTextCtrl::GetCodePage()

bool
Wx_StyledTextCtrl::GetReadOnly()

void
Wx_StyledTextCtrl::SetCurrentPos( pos )
    int pos

void
Wx_StyledTextCtrl::SetSelectionStart( pos )
    int pos

int
Wx_StyledTextCtrl::GetSelectionStart()

void
Wx_StyledTextCtrl::SetSelectionEnd( pos )
    int pos

int
Wx_StyledTextCtrl::GetSelectionEnd()

void
Wx_StyledTextCtrl::SetPrintMagnification( magnification )
    int magnification

int
Wx_StyledTextCtrl::GetPrintMagnification()

void
Wx_StyledTextCtrl::SetPrintColourMode( mode )
    int mode

int
Wx_StyledTextCtrl::GetPrintColourMode()

#undef FindText
#if 0

int
Wx_StyledTextCtrl::FindText( minPos, maxPos, text, flags = 0 )
    int minPos
    int maxPos
    wxString text
    int flags
  CODE:
    RETVAL = THIS->FindText( minPos, maxPos, text, flags );
  OUTPUT: RETVAL

#endif

int
Wx_StyledTextCtrl::GetFirstVisibleLine()

int
Wx_StyledTextCtrl::GetLineCount()

void
Wx_StyledTextCtrl::SetMarginLeft( pixelWidth )
    int pixelWidth

int
Wx_StyledTextCtrl::GetMarginLeft()

void
Wx_StyledTextCtrl::SetMarginRight( pixelWidth )
    int pixelWidth

int
Wx_StyledTextCtrl::GetMarginRight()

bool
Wx_StyledTextCtrl::GetModify()

void
Wx_StyledTextCtrl::SetSelection( start, end )
    int start
    int end

void
Wx_StyledTextCtrl::HideSelection( normal )
    bool normal

int
Wx_StyledTextCtrl::LineFromPosition( pos )
    int pos

int
Wx_StyledTextCtrl::PositionFromLine( line )
    int line

void
Wx_StyledTextCtrl::LineScroll( columns, lines )
    int columns
    int lines

void
Wx_StyledTextCtrl::EnsureCaretVisible()

void
Wx_StyledTextCtrl::ReplaceSelection( text )
    wxString text

void
Wx_StyledTextCtrl::SetReadOnly( readOnly )
    bool readOnly

bool
Wx_StyledTextCtrl::CanPaste()

bool
Wx_StyledTextCtrl::CanUndo()

void
Wx_StyledTextCtrl::EmptyUndoBuffer()

void
Wx_StyledTextCtrl::Undo()

void
Wx_StyledTextCtrl::Cut()

void
Wx_StyledTextCtrl::Copy()

void
Wx_StyledTextCtrl::Paste()

void
Wx_StyledTextCtrl::Clear()

int
Wx_StyledTextCtrl::GetTextLength()

void
Wx_StyledTextCtrl::SetOvertype( overtype )
    bool overtype

bool
Wx_StyledTextCtrl::GetOvertype()

void
Wx_StyledTextCtrl::SetCaretWidth( pixelWidth )
    int pixelWidth

int
Wx_StyledTextCtrl::GetCaretWidth()

void
Wx_StyledTextCtrl::SetTargetStart( pos )
    int pos

int
Wx_StyledTextCtrl::GetTargetStart()

void
Wx_StyledTextCtrl::SetTargetEnd( pos )
    int pos

int
Wx_StyledTextCtrl::GetTargetEnd()

int
Wx_StyledTextCtrl::ReplaceTarget( text )
    wxString text

int
Wx_StyledTextCtrl::ReplaceTargetRE( text )
    wxString text

int
Wx_StyledTextCtrl::SearchInTarget( text )
    wxString text

void
Wx_StyledTextCtrl::SetSearchFlags( flags )
    int flags

int
Wx_StyledTextCtrl::GetSearchFlags()

void
Wx_StyledTextCtrl::CallTipShow( pos, definition )
    int pos
    wxString definition

void
Wx_StyledTextCtrl::CallTipCancel()

bool
Wx_StyledTextCtrl::CallTipActive()

int
Wx_StyledTextCtrl::CallTipPosAtStart()

void
Wx_StyledTextCtrl::CallTipSetHighlight( start, end )
    int start
    int end

void
Wx_StyledTextCtrl::CallTipSetBackground( back )
    Wx_Colour* back
  CODE:
    THIS->CallTipSetBackground( *back );

int
Wx_StyledTextCtrl::VisibleFromDocLine( line )
    int line

int
Wx_StyledTextCtrl::DocLineFromVisible( lineDisplay )
    int lineDisplay

void
Wx_StyledTextCtrl::SetFoldLevel( line, level )
    int line
    int level

int
Wx_StyledTextCtrl::GetFoldLevel( line )
    int line

int
Wx_StyledTextCtrl::GetLastChild( line, level )
    int line
    int level

int
Wx_StyledTextCtrl::GetFoldParent( line )
    int line

void
Wx_StyledTextCtrl::ShowLines( lineStart, lineEnd )
    int lineStart
    int lineEnd

void
Wx_StyledTextCtrl::HideLines( lineStart, lineEnd )
    int lineStart
    int lineEnd

bool
Wx_StyledTextCtrl::GetLineVisible( line )
    int line

void
Wx_StyledTextCtrl::SetFoldExpanded( line, expanded )
    int line
    bool expanded

bool
Wx_StyledTextCtrl::GetFoldExpanded( line )
    int line

void
Wx_StyledTextCtrl::ToggleFold( line )
    int line

void
Wx_StyledTextCtrl::EnsureVisible( line )
    int line

void
Wx_StyledTextCtrl::SetFoldFlags( flags )
    int flags

void
Wx_StyledTextCtrl::EnsureVisibleEnforcePolicy( line )
    int line

void
Wx_StyledTextCtrl::SetTabIndents( tabIndents )
    bool tabIndents

bool
Wx_StyledTextCtrl::GetTabIndents()

void
Wx_StyledTextCtrl::SetBackSpaceUnIndents( bsUnIndents )
    bool bsUnIndents

bool
Wx_StyledTextCtrl::GetBackSpaceUnIndents()

void
Wx_StyledTextCtrl::SetMouseDwellTime( periodMilliseconds )
    int periodMilliseconds

int
Wx_StyledTextCtrl::GetMouseDwellTime()

int
Wx_StyledTextCtrl::WordStartPosition( pos, onlyWordCharacters )
    int pos
    bool onlyWordCharacters

int
Wx_StyledTextCtrl::WordEndPosition( pos, onlyWordCharacters )
    int pos
    bool onlyWordCharacters

void
Wx_StyledTextCtrl::SetLayoutCache( mode )
    int mode

int
Wx_StyledTextCtrl::GetLayoutCache()

void
Wx_StyledTextCtrl::SetScrollWidth( pixelWidth )
    int pixelWidth

int
Wx_StyledTextCtrl::GetScrollWidth()

int
Wx_StyledTextCtrl::TextWidth( style, text )
    int style
    wxString text

void
Wx_StyledTextCtrl::SetEndAtLastLine( endAtLastLine )
    bool endAtLastLine

int
Wx_StyledTextCtrl::GetEndAtLastLine()

int
Wx_StyledTextCtrl::TextHeight( line )
    int line

void
Wx_StyledTextCtrl::HomeDisplay()

void
Wx_StyledTextCtrl::HomeDisplayExtend()

void
Wx_StyledTextCtrl::LineEndDisplay()

void
Wx_StyledTextCtrl::LineEndDisplayExtend()

void
Wx_StyledTextCtrl::MoveCaretInsideView()

int
Wx_StyledTextCtrl::LineLength( line )
    int line

void
Wx_StyledTextCtrl::BraceHighlight( pos1, pos2 )
    int pos1
    int pos2

void
Wx_StyledTextCtrl::BraceBadLight( pos )
    int pos

int
Wx_StyledTextCtrl::BraceMatch( pos )
    int pos

bool
Wx_StyledTextCtrl::GetViewEOL()

void
Wx_StyledTextCtrl::SetViewEOL( visible )
    bool visible

void
Wx_StyledTextCtrl::GetDocPointer()

void
Wx_StyledTextCtrl::SetDocPointer( docPointer )
    void* docPointer

void
Wx_StyledTextCtrl::SetModEventMask( mask )
    int mask

int
Wx_StyledTextCtrl::GetEdgeColumn()

void
Wx_StyledTextCtrl::SetEdgeColumn( column )
    int column

int
Wx_StyledTextCtrl::GetEdgeMode()

void
Wx_StyledTextCtrl::SetEdgeMode( mode )
    int mode

void
Wx_StyledTextCtrl::SetEdgeColour( edgeColour )
    wxColour edgeColour

void
Wx_StyledTextCtrl::SearchAnchor()

int
Wx_StyledTextCtrl::SearchNext( flags, text )
    int flags
    wxString text

int
Wx_StyledTextCtrl::SearchPrev( flags, text )
    int flags
    wxString text

int
Wx_StyledTextCtrl::LinesOnScreen()

void
Wx_StyledTextCtrl::UsePopUp( allowPopUp )
    bool allowPopUp

bool
Wx_StyledTextCtrl::SelectionIsRectangle()

void
Wx_StyledTextCtrl::SetZoom( zoom )
    int zoom

int
Wx_StyledTextCtrl::GetZoom()

void
Wx_StyledTextCtrl::CreateDocument()

void
Wx_StyledTextCtrl::AddRefDocument( docPointer )
    void* docPointer

void
Wx_StyledTextCtrl::ReleaseDocument( docPointer )
    void* docPointer

int
Wx_StyledTextCtrl::GetModEventMask()

void
Wx_StyledTextCtrl::SetSTCFocus( focus )
    bool focus

bool
Wx_StyledTextCtrl::GetSTCFocus()

void
Wx_StyledTextCtrl::SetStatus( statusCode )
    int statusCode

int
Wx_StyledTextCtrl::GetStatus()

void
Wx_StyledTextCtrl::SetMouseDownCaptures( captures )
    bool captures

bool
Wx_StyledTextCtrl::GetMouseDownCaptures()

void
Wx_StyledTextCtrl::SetCursor( cursorType )
    int cursorType

#if 0

int
Wx_StyledTextCtrl::GetCursor()

#endif

void
Wx_StyledTextCtrl::SetControlCharSymbol( symbol )
    int symbol

int
Wx_StyledTextCtrl::GetControlCharSymbol()

void
Wx_StyledTextCtrl::WordPartLeft()

void
Wx_StyledTextCtrl::WordPartLeftExtend()

void
Wx_StyledTextCtrl::WordPartRight()

void
Wx_StyledTextCtrl::WordPartRightExtend()

void
Wx_StyledTextCtrl::SetVisiblePolicy( visiblePolicy, visibleSlop )
    int visiblePolicy
    int visibleSlop

void
Wx_StyledTextCtrl::DelLineLeft()

void
Wx_StyledTextCtrl::DelLineRight()

void
Wx_StyledTextCtrl::SetXOffset( newOffset )
    int newOffset

int
Wx_StyledTextCtrl::GetXOffset()

void
Wx_StyledTextCtrl::SetXCaretPolicy( caretPolicy, caretSlop )
    int caretPolicy
    int caretSlop

void
Wx_StyledTextCtrl::SetYCaretPolicy( caretPolicy, caretSlop )
    int caretPolicy
    int caretSlop

void
Wx_StyledTextCtrl::StartRecord()

void
Wx_StyledTextCtrl::StopRecord()

void
Wx_StyledTextCtrl::Colourise( start, end )
    int start
    int end

void
Wx_StyledTextCtrl::SetProperty( key, value )
    wxString key
    wxString value

void
Wx_StyledTextCtrl::SetKeyWords( keywordSet, keyWords )
    int keywordSet
    wxString keyWords

void
Wx_StyledTextCtrl::SetLexerLanguage( language )
    wxString language

## Retrieve the selected text
wxString
Wx_StyledTextCtrl::GetSelectedText()

## Retrieve a range of text
wxString
Wx_StyledTextCtrl::GetTextRange(startPos, endPos)
    int startPos
    int endPos

## Retrieve all the text in the document.
wxString
Wx_StyledTextCtrl::GetText()

## Returns the position of the opposite end of the selection to the caret.
int
Wx_StyledTextCtrl::GetAnchor()

## Returns the style byte at the position
int
Wx_StyledTextCtrl::GetStyleAt(pos)
    int pos

## Redoes the next action on the undo history.
void
Wx_StyledTextCtrl::Redo()

## Select all the text in the document.
void
Wx_StyledTextCtrl::SelectAll()

## Remember the current position in the undo history as the position
## at which the document was saved.
void
Wx_StyledTextCtrl::SetSavePoint()

## Replace the contents of the document with the argument text.
void
Wx_StyledTextCtrl::SetText(text)
    wxString text

## Are there any redoable actions in the undo history?
bool
Wx_StyledTextCtrl::CanRedo()

## Retrieve the line number at which a particular marker is located.
int
Wx_StyledTextCtrl::MarkerLineFromHandle( handle )
    int handle

## Delete a marker
void
Wx_StyledTextCtrl::MarkerDeleteHandle( handle )
    int handle

## Is undo history being collected?
bool
Wx_StyledTextCtrl::GetUndoCollection()

## Are white space characters currently visible?
## Returns one of SCWS_* constants.
int
Wx_StyledTextCtrl::GetViewWhiteSpace()

## Make white space characters invisible, always visible or visible outside indentation.
void
Wx_StyledTextCtrl::SetViewWhiteSpace( viewWs )
    int viewWs

## Find the position from a point within the window.
int
Wx_StyledTextCtrl::PositionFromPoint( pt )
    Wx_Point pt

int
Wx_StyledTextCtrl::PositionFromPointClose( x, y )
    int x
    int y

## Set caret to start of a line and ensure it is visible.
void
Wx_StyledTextCtrl::GotoLine(line)
    int line

## Set caret to a position and ensure it is visible.
void
Wx_StyledTextCtrl::GotoPos(pos)
    int pos

void
Wx_StyledTextCtrl::SetAnchor( posAnchor )
    int posAnchor

int
Wx_StyledTextCtrl::GetEndStyled()

void
Wx_StyledTextCtrl::ConvertEOLs( eolMode )
    int eolMode

int
Wx_StyledTextCtrl::GetEOLMode()

void
Wx_StyledTextCtrl::SetEOLMode( eolMode )
    int eolMode

void
Wx_StyledTextCtrl::StartStyling( pos, mask )
    int pos
    int mask

void
Wx_StyledTextCtrl::SetStyling( length, style )
    int length
    int style

bool
Wx_StyledTextCtrl::GetBufferedDraw()

void
Wx_StyledTextCtrl::SetBufferedDraw( buffered )
    bool buffered

void
Wx_StyledTextCtrl::SetTabWidth( tabWidth )
    int tabWidth

int
Wx_StyledTextCtrl::GetTabWidth()

void
Wx_StyledTextCtrl::SetCodePage( codePage )
    int codePage

void
Wx_StyledTextCtrl::MarkerDefine( markerNumber, markerSymbol, foreground, background )
    int markerNumber
    int markerSymbol
    Wx_Colour* foreground
    Wx_Colour* background
  CODE:
    THIS->MarkerDefine( markerNumber, markerSymbol, *foreground, *background );

void
Wx_StyledTextCtrl::MarkerSetForeground( markerNumber, fore )
    int markerNumber
    Wx_Colour* fore
  CODE:
    THIS->MarkerSetForeground( markerNumber, *fore );

void
Wx_StyledTextCtrl::MarkerSetBackground( markerNumber, back )
    int markerNumber
    Wx_Colour* back
  CODE:
    THIS->MarkerSetBackground( markerNumber, *back );

void
Wx_StyledTextCtrl::MarkerAdd( line, markerNumber )
    int line
    int markerNumber

void
Wx_StyledTextCtrl::MarkerDelete( line, markerNumber )
    int line
    int markerNumber

void
Wx_StyledTextCtrl::MarkerDeleteAll( markerNumber )
    int markerNumber

int
Wx_StyledTextCtrl::MarkerGet( line )
    int line

int
Wx_StyledTextCtrl::MarkerNext( lineStart, markerMask )
    int lineStart
    int markerMask

int
Wx_StyledTextCtrl::MarkerPrevious( lineStart, markerMask )
    int lineStart
    int markerMask

void
Wx_StyledTextCtrl::SetMarginType( margin, marginType )
    int margin
    int marginType

int
Wx_StyledTextCtrl::GetMarginType( margin )
    int margin

void
Wx_StyledTextCtrl::SetMarginWidth( margin, pixelWidth )
    int margin
    int pixelWidth

int
Wx_StyledTextCtrl::GetMarginWidth( margin )
    int margin

void
Wx_StyledTextCtrl::SetMarginMask( margin, mask )
    int margin
    int mask

int
Wx_StyledTextCtrl::GetMarginMask( margin )
    int margin

void
Wx_StyledTextCtrl::SetMarginSensitive( margin, sensitive )
    int margin
    bool sensitive

bool
Wx_StyledTextCtrl::GetMarginSensitive( margin )
    int margin


## Returns the position of the caret
int
Wx_StyledTextCtrl::GetCurrentPos()

int
Wx_StyledTextCtrl::GetLength()

int
Wx_StyledTextCtrl::GetCharAt( pos )
    int pos

## Sets whether text is word wrapped
void
Wx_StyledTextCtrl::SetWrapMode(mode)
    int mode

## Retrieve whether text is word wrapped
int
Wx_StyledTextCtrl::GetWrapMode()

## Retrieve the contents of a line.
wxString
Wx_StyledTextCtrl::GetLine(line)
    int line

## Delete all text in the document
void
Wx_StyledTextCtrl::ClearAll()

## Returns the line number of the line with the caret.
int
Wx_StyledTextCtrl::GetCurrentLine()

void
Wx_StyledTextCtrl::CmdKeyExecute( cmd )
    int cmd

void
Wx_StyledTextCtrl::SetMargins( left, right )
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
