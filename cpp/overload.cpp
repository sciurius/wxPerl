/////////////////////////////////////////////////////////////////////////////
// Name:        overload.cpp
// Purpose:     C++ implementation for a function to match a function's
//              argument list against a prototype
// Author:      Mattia Barbon
// Modified by:
// Created:      7/ 8/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/overload.h"

#if 0
class wxPliArgArray
{
public:
    virtual ~wxPliArgArray() {};

    virtual SV* operator[]( size_t index ) = 0;
    virtual size_t GetCount() const = 0;
};

class wxPliStackArray
{
public:
    wxPliStackArray();

private:
    SV*** sp;
    
};
#endif

//FIXME// move to header
extern I32 my_looks_like_number( pTHX_ SV* sv );

bool wxPli_match_arguments_offset( pTHX_ const unsigned char prototype[],
                                   size_t nproto, int required,
                                   bool allow_more, size_t offset );

bool wxPli_match_arguments_skipfirst( pTHX_ const unsigned char prototype[],
                                      size_t nproto, int required /* = -1 */,
                                      bool allow_more /* = FALSE */ )
{
    return wxPli_match_arguments_offset( aTHX_ prototype, nproto, required,
                                         allow_more, 1 );
}

bool wxPli_match_arguments( pTHX_ const unsigned char prototype[],
                            size_t nproto, int required /* = -1 */,
                            bool allow_more /* = FALSE */ )
{
    return wxPli_match_arguments_offset( aTHX_ prototype, nproto, required,
                                         allow_more, 0 );
}

bool wxPli_match_arguments_offset( pTHX_ const unsigned char prototype[],
                                   size_t nproto, int required,
                                   bool allow_more, size_t offset )
{
    dXSARGS; // restore the mark we implicitly popped in dMARK!
    int argc = items - int(offset);

    if( required != -1 )
    {
        if(  allow_more && argc <  required )
            { PUSHMARK(MARK); return FALSE; }
        if( !allow_more && argc != required )
            { PUSHMARK(MARK); return FALSE; }
    }

    size_t max = wxMin( nproto, argc ) + offset;
    for( size_t i = offset; i < max; ++i )
    {
        unsigned char p = prototype[i - offset];
        // everything is a string or a boolean
        if( p == wxPliOvlstr ||
            p == wxPliOvlbool )
            continue;

        SV* t = ST(i);

        // want a number
        if( p == wxPliOvlnum )
        {
            if( my_looks_like_number( aTHX_ t ) ) continue;
            else { PUSHMARK(MARK); return FALSE; }
        }
        // want an object/package name, accept undef, too
        if( !SvOK( t ) || ( wxPliOvl_tnames[size_t(p)] != 0 &&
            sv_derived_from( t, wxPliOvl_tnames[size_t(p)] ) ) )
            continue;
        // want an array reference
        if( p == wxPliOvlarr && wxPli_avref_2_av( t ) ) continue;
        // want a wxPoint/wxSize, accept an array reference, too
        if( ( p == wxPliOvlwpoi || p == wxPliOvlwsiz )
            && wxPli_avref_2_av( t ) ) continue;
        // want an input/output stream, accept any reference
        if( ( p == wxPliOvlwist || p == wxPliOvlwost ) &&
            SvROK( t ) ) continue;

        // type clash: return FALSE
        PUSHMARK(MARK);
        return FALSE;
    }

    PUSHMARK(MARK);
    return TRUE;
}
