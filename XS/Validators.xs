#############################################################################
## Name:        XS/Validators.xs
## Purpose:     XS for Wx::Validator
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Validators.xs,v 1.10 2006/08/11 19:38:44 mbarbon Exp $
## Copyright:   (c) 2000-2002, 2004 Mattia Barbon
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
