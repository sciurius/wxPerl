#############################################################################
## Name:        XS/ClassInfo.xs
## Purpose:     XS for Wx::ClassInfo the CLASSINFO macro
## Author:      Mattia Barbon
## Modified by:
## Created:     20/11/2000
## RCS-ID:      $Id: ClassInfo.xs,v 1.4 2004/02/28 22:59:06 mbarbon Exp $
## Copyright:   (c) 2000-2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ClassInfo

wxClassInfo*
FindClass( name )
    wxChar* name
  CODE:
    RETVAL = wxClassInfo::FindClass( name );
  OUTPUT:
    RETVAL

const wxChar*
wxClassInfo::GetBaseClassName1()

const wxChar*
wxClassInfo::GetBaseClassName2()

const wxChar*
wxClassInfo::GetClassName()
