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

version:
	echo $(WXVERSION)

wxdir:
	echo $(WXWIN)

# for 2.4.0 or less vs. 2.4.1 and 2.5.0
cxxflags:
	echo $(CPPFLAGS) $(ALL_CPPFLAGS) $(ALL_CXXFLAGS)

linkflags:
	echo $(LINKFLAGS)

libs:
	echo $(LIBS)

# this one is for import library ( not in wx-config )
implib:
	echo $(WXLIB)
