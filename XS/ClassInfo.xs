#############################################################################
## Name:        ClassInfo.xs
## Purpose:     XS for Wx::ClassInfo the CLASSINFO macro
## Author:      Mattia Barbon
## Modified by:
## Created:     20/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ClassInfo

Wx_ClassInfo*
FindClass( name )
    char* name
  CODE:
    RETVAL = wxClassInfo::FindClass( name );
  OUTPUT:
    RETVAL

const char*
Wx_ClassInfo::GetBaseClassName1()

const char*
Wx_ClassInfo::GetBaseClassName2()

const char*
Wx_ClassInfo::GetClassName()
