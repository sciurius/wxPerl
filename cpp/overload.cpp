/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/overload.cpp
// Purpose:     C++ implementation for a function to match a function's
//              argument list against a prototype
// Author:      Mattia Barbon
// Modified by:
// Created:     07/08/2002
// RCS-ID:      $Id$
// Copyright:   (c) 2002-2004, 2006-2007 Mattia Barbon
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

bool wxPli_match_arguments_offset( pTHX_ const wxPliPrototype& prototype,
                                   int required,
                                   bool allow_more, size_t offset );

bool wxPli_match_arguments_skipfirst( pTHX_ const wxPliPrototype& prototype,
                                      int required /* = -1 */,
                                      bool allow_more /* = false */ )
{
    return wxPli_match_arguments_offset( aTHX_ prototype, required,
                                         allow_more, 1 );
}

bool wxPli_match_arguments( pTHX_ const wxPliPrototype& prototype,
                            int required /* = -1 */,
                            bool allow_more /* = false */ )
{
    return wxPli_match_arguments_offset( aTHX_ prototype, required,
                                         allow_more, 0 );
}

static inline bool IsGV( SV* sv ) { return SvTYPE( sv ) == SVt_PVGV; }

bool wxPli_match_arguments_offset( pTHX_ const wxPliPrototype& prototype,
                                   int required,
                                   bool allow_more, size_t offset )
{
    dXSARGS; // restore the mark we implicitly popped in dMARK!
    int argc = items - int(offset);

    if( required != -1 )
    {
        if(  allow_more && argc <  required )
            { PUSHMARK(MARK); return false; }
        if( !allow_more && argc != required )
            { PUSHMARK(MARK); return false; }
    }
    else if( argc < int(prototype.count) )
        { PUSHMARK(MARK); return false; }

    size_t max = wxMin( prototype.count, size_t(argc) ) + offset;
    for( size_t i = offset; i < max; ++i )
    {
        unsigned char p = prototype.args[i - offset];
        // everything is a string or a boolean
        if( p == wxPliOvlstr ||
            p == wxPliOvlbool )
            continue;

        SV* t = ST(i);

        // want a number
        if( p == wxPliOvlnum )
        {
            if( my_looks_like_number( aTHX_ t ) ) continue;
            else { PUSHMARK(MARK); return false; }
        }
        // want an object/package name, accept undef, too
        const char* cstr =
          p > wxPliOvlzzz   ? prototype.tnames[p - wxPliOvlzzz] :
          p == wxPliOvlwpos ? "Wx::Position" :
          p == wxPliOvlwpoi ? "Wx::Point" :
          p == wxPliOvlwsiz ? "Wx::Size"  :
                              NULL;
        if(    !IsGV( t )
            && (    !SvOK( t )
                 || (    cstr != NULL
                      && sv_isobject( t )
                      && sv_derived_from( t, CHAR_P cstr )
                      )
                 )
            )
            continue;
        // want an array reference
        if( p == wxPliOvlarr && wxPli_avref_2_av( t ) ) continue;
        // want a wxPoint/wxSize, accept an array reference, too
        if( ( p == wxPliOvlwpoi || p == wxPliOvlwsiz || p == wxPliOvlwpos )
            && wxPli_avref_2_av( t ) ) continue;
        // want an input/output stream, accept any reference
        if( ( p == wxPliOvlwist || p == wxPliOvlwost ) &&
            ( SvROK( t ) || IsGV( t ) ) ) continue;

        // type clash: return false
        PUSHMARK(MARK);
        return false;
    }

    PUSHMARK(MARK);
    return true;
}

void wxPli_set_ovl_constant( const char* name, const wxPliPrototype* value )
{
    dTHX;
    char buffer[1024];
    strcpy( buffer, "Wx::_" );
    strcat( buffer, name );

    SV* sv = get_sv( buffer, 1 );
    sv_setiv( sv, PTR2IV( value ) );
}
