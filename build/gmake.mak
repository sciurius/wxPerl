#############################################################################
## Name:        gmake.mak
## Purpose:     extracts some flag information from makeg95.env
## Author:      Mattia Barbon
## Modified by:
## Created:     10/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

WXUSINGDLL=1

include $(WXWIN)/src/makeg95.env

wxdir:
	echo $(WXWIN)

cccflags:
	echo $(CPPFLAGS)

linkflags:
	echo $(LINKFLAGS)

libs:
	echo $(LIBS)

