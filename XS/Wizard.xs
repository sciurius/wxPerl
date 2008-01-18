#############################################################################
## Name:        XS/Wizard.xs
## Purpose:     XS for Wx::Wizard and related classes
## Author:      Mattia Barbon
## Modified by:
## Created:     28/08/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002-2004, 2006-2008 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

## bug in 2.2
#include <wx/bitmap.h> 
#include <wx/panel.h>
#include <wx/dialog.h>
#include <wx/event.h>
#include <wx/wizard.h>
#include <wx/sizer.h>
#include "cpp/overload.h"
#include "cpp/wizard.h"

MODULE=Wx PACKAGE=Wx::Wizard

void
wxWizard::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newEmpty )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( Wx::Wizard::new )

wxWizard*
newEmpty( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliWizard( CLASS );
  OUTPUT:
    RETVAL

wxWizard*
newFull( CLASS, parent, id = wxID_ANY, title = wxEmptyString, bitmap = (wxBitmap*)&wxNullBitmap, pos = wxDefaultPosition )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxString title
    wxBitmap* bitmap
    wxPoint pos
  CODE:
    RETVAL = new wxPliWizard( CLASS, parent, id, title, *bitmap, pos );
  OUTPUT:
    RETVAL

bool
wxWizard::Create( parent, id = wxID_ANY, title = wxEmptyString, bitmap = (wxBitmap*)&wxNullBitmap, pos = wxDefaultPosition )
    wxWindow* parent
    wxWindowID id
    wxString title
    wxBitmap* bitmap
    wxPoint pos
  C_ARGS: parent, id, title, *bitmap, pos

bool
wxWizard::RunWizard( page )
    wxWizardPage* page

wxWizardPage*
wxWizard::GetCurrentPage()

wxSize*
wxWizard::GetPageSize()
  CODE:
    RETVAL = new wxSize( THIS->GetPageSize() );
  OUTPUT:
    RETVAL

void
wxWizard::SetPageSize( size )
    wxSize size

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxSizer*
wxWizard::GetPageAreaSizer()

#endif

#if WXPERL_W_VERSION_GE( 2, 8, 5 )

wxBitmap*
wxWizard::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT: RETVAL

void
wxWizard::SetBitmap( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

#endif

void
wxWizard::FitToPage( firstPage )
    wxWizardPage* firstPage

void
wxWizard::SetBorder( border )
    int border

bool
wxWizard::HasNextPage( page )
    wxWizardPage* page

bool
wxWizard::HasPrevPage( page )
    wxWizardPage* page

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

void
wxWizard::SetBitmapBackgroundColour( colour )
    wxColour colour

wxColour*
wxWizard::GetBitmapBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBitmapBackgroundColour() );
  OUTPUT: RETVAL

void
wxWizard::SetBitmapPlacement( placement )
    int placement

int
wxWizard::GetBitmapPlacement()

void
wxWizard::SetMinimumBitmapWidth( w )
    int w

int
wxWizard::GetMinimumBitmapWidth()

#endif

MODULE=Wx PACKAGE=Wx::WizardPage

void
wxWizardPage::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newEmpty )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( Wx::WizardPage::new )

wxWizardPage*
newEmpty( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliWizardPage( CLASS );
  OUTPUT:
    RETVAL

wxWizardPage*
newFull( CLASS, parent, bitmap = (wxBitmap*)&wxNullBitmap )
    PlClassName CLASS
    wxWizard* parent
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxPliWizardPage( CLASS, parent, *bitmap );
  OUTPUT:
    RETVAL

bool
wxWizardPage::Create( parent, bitmap = (wxBitmap*)&wxNullBitmap )
    wxWizard* parent
    wxBitmap* bitmap
  C_ARGS: parent, *bitmap

wxBitmap*
wxWizardPage::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

wxWizardPage*
wxWizardPageSimple::GetPrev()

wxWizardPage*
wxWizardPageSimple::GetNext()

MODULE=Wx PACKAGE=Wx::WizardPageSimple

wxWizardPageSimple*
wxWizardPageSimple::new( parent, prev = 0, next = 0 )
    wxWizard* parent
    wxWizardPage* prev
    wxWizardPage* next

void
wxWizardPageSimple::SetPrev( prev )
    wxWizardPage* prev

void
wxWizardPageSimple::SetNext( next )
    wxWizardPage* next

void
Chain( first, second )
    wxWizardPageSimple* first
    wxWizardPageSimple* second
  CODE:
    wxWizardPageSimple::Chain( first, second );

MODULE=Wx PACKAGE=Wx::WizardEvent

bool
wxWizardEvent::GetDirection()

wxWizardPage*
wxWizardEvent::GetPage()

