#############################################################################
## Name:        XS/Wizard.xs
## Purpose:     XS for Wx::Wizard and related classes
## Author:      Mattia Barbon
## Modified by:
## Created:     28/08/2002
## RCS-ID:      $Id: Wizard.xs,v 1.10 2003/08/17 19:34:40 mbarbon Exp $
## Copyright:   (c) 2002-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

## bug in 2.2
#include <wx/bitmap.h> 
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
    SV* CLASS
  CODE:
    RETVAL = new wxWizard();
  OUTPUT:
    RETVAL

wxWizard*
newFull( CLASS, parent, id = -1, title = wxEmptyString, bitmap = (wxBitmap*)&wxNullBitmap, pos = wxDefaultPosition )
    SV* CLASS
    wxWindow* parent
    wxWindowID id
    wxString title
    wxBitmap* bitmap
    wxPoint pos
  CODE:
    RETVAL = new wxWizard( parent, id, title, *bitmap, pos );
  OUTPUT:
    RETVAL

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

#if WXPERL_W_VERSION_GE( 2, 5, 0 )

wxSizer*
wxWizard::GetPageAreaSizer()

#endif

MODULE=Wx PACKAGE=Wx::WizardPage

wxWizardPage*
wxWizardPage::new( parent, bitmap = (wxBitmap*)&wxNullBitmap )
    wxWizard* parent
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxPliWizardPage( CLASS, parent, *bitmap );
  OUTPUT:
    RETVAL

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

