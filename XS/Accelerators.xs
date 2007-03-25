#############################################################################
## Name:        XS/Accelerators.xs
## Purpose:     XS for Wx::AcceleratorTable, Wx::AcceleratorEntry
## Author:      Mattia Barbon
## Modified by:
## Created:     13/02/2001
## RCS-ID:      $Id: Accelerators.xs,v 1.13 2007/03/25 15:43:50 mbarbon Exp $
## Copyright:   (c) 2001-2002, 2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/accel.h>

MODULE=Wx PACKAGE=Wx::AcceleratorEntry

wxAcceleratorEntry*
wxAcceleratorEntry::new( flags, code, cmd )
    int flags
    wxKeyCode code
    int cmd

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

wxAcceleratorEntry*
Create( str )
    wxString str;
  CODE:
    RETVAL = wxAcceleratorEntry::Create( str );
  OUTPUT: RETVAL

#endif

static void
wxAcceleratorEntry::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxAcceleratorEntry::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::AcceleratorEntry", THIS, ST(0) );
    delete THIS;

int
wxAcceleratorEntry::GetCommand()

int
wxAcceleratorEntry::GetFlags()

## wxKeyCode
int
wxAcceleratorEntry::GetKeyCode()

void
wxAcceleratorEntry::Set( flags, code, cmd )
    int flags
    wxKeyCode code
    int cmd

MODULE=Wx PACKAGE=Wx::AcceleratorTable

wxAcceleratorTable*
wxAcceleratorTable::new( ... )
  CODE:
    if( items == 1 )
    {
        RETVAL = new wxAcceleratorTable;
    }
    else
    {
        int num = items - 1;
        wxAcceleratorEntry* entries = new wxAcceleratorEntry[ num ];

        for( int i = 0; i < num; ++i )
        {
            SV* rv = ST( i + 1 );

            if( SvROK( rv ) )
            {
                if( sv_derived_from( rv, CHAR_P "Wx::AcceleratorEntry" ) )
                {
                    entries[i] = *(wxAcceleratorEntry*)
                        wxPli_sv_2_object( aTHX_ rv,
                                           "Wx::AcceleratorEntry" );
                }
                else if( SvTYPE( SvRV( rv ) ) == SVt_PVAV )
                {
                    AV* av = (AV*) SvRV( rv );
                    I32 len = av_len( av ) + 1;

                    if( len != 3 )
                    {
                        delete[] entries;
                        croak( "the %d-th value does not have three"
                               " elements", i + 1 );
                    }

                    entries[i].Set( SvIV( *av_fetch( av, 0, 0 ) ),
                                    wxPli_sv_2_keycode( aTHX_
                                            *av_fetch( av, 1, 0 ) ),
                                    SvIV( *av_fetch( av, 2, 0 ) ) );
                }
                else
                {
                    delete[] entries;
                    croak( "the %d-th value is not an object"
                           " or array reference", i + 1 );
                }
            }
            else
            {
                delete[] entries;
                croak( "the %d-th value is not an object"
                       " or array reference", i + 1 );
            }
        }

        RETVAL = new wxAcceleratorTable( num, entries );
        delete[] entries;
    }
  OUTPUT:
    RETVAL

static void
wxAcceleratorTable::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxAcceleratorTable::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::AcceleratorTable", THIS, ST(0) );
    delete THIS;

bool
wxAcceleratorTable::Ok()
