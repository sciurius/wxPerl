#############################################################################
## Name:        XS/Validators.xs
## Purpose:     XS for Wx::Validator
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2002, 2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/validate.h>
#include "cpp/validators.h"

MODULE=Wx PACKAGE=Wx::Validator

wxWindow*
wxValidator::GetWindow()

void
wxValidator::SetBellOnError( doit = true )
    bool doit

void
wxValidator::SetWindow( window )
    wxWindow* window

# bool
# wxValidator::TransferFromWindow()

# bool
# wxValidator::TransferToWindow()

# bool
# wxValidator::Validate( parent )
#    wxWindow* parent

#!sub TransferFromWindow
#!sub TransferToWindow
#!sub Validate
#!sub Clone

MODULE=Wx PACKAGE=Wx::PlValidator

wxPlValidator*
wxPlValidator::new()
  CODE:
    RETVAL = new wxPlValidator( CLASS );
  OUTPUT:
    RETVAL

## // thread KO
void
wxPlValidator::DESTROY()
  PREINIT:
    static char wxPlPlValidatorName[] = "Wx::PlValidator";
  CODE:
    // nothing
