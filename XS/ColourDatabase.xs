#############################################################################
## Name:        XS/ColourDatabase.xs
## Purpose:     XS for Wx::ColourDatabase
## Author:      Mark Dootson
## Modified by:
## Created:     14/09/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ColourDatabase

void
AddColour( colourname, colour )
    wxString colourname
    wxColour* colour
  CODE:
    wxTheColourDatabase->AddColour( colourname, *colour );
    
wxColour*
Find( colourname )
    wxString colourname
  CODE:
    RETVAL = new wxColour( wxTheColourDatabase->Find( colourname ) );
  OUTPUT: RETVAL
  
wxString
FindName( colour )
    wxColour* colour
  CODE:
    RETVAL = wxTheColourDatabase->FindName( *colour );
  OUTPUT: RETVAL
  
  