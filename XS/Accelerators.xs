#############################################################################
## Name:        Accelerators.xs
## Purpose:     XS for Wx::AcceleratorTable, Wx::AcceleratorEntry
## Author:      Mattia Barbon
## Modified by:
## Created:     13/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/accel.h>

MODULE=Wx PACKAGE=Wx::AcceleratorEntry

Wx_AcceleratorEntry*
Wx_AcceleratorEntry::new( flags, code, cmd )
    int flags
    Wx_KeyCode code
    int cmd

void
Wx_AcceleratorEntry::DESTROY()

int
Wx_AcceleratorEntry::GetCommand()

int
Wx_AcceleratorEntry::GetFlags()

Wx_KeyCode
Wx_AcceleratorEntry::GetKeyCode()

void
Wx_AcceleratorEntry::Set( flags, code, cmd )
    int flags
    Wx_KeyCode code
    int cmd

MODULE=Wx PACKAGE=Wx::AcceleratorTable

Wx_AcceleratorTable*
Wx_AcceleratorTable::new( ... )
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

## XXX threads
void
Wx_AcceleratorTable::DESTROY()

bool
Wx_AcceleratorTable::Ok()