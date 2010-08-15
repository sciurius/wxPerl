/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/overload.cpp
// Purpose:     C++ implementation for a function to match a function's
//              argument list against a prototype
// Author:      Mattia Barbon
// Modified by:
// Created:     07/08/2002
// RCS-ID:      $Id$
// Copyright:   (c) 2002-2004, 2006-2007, 2010 Mattia Barbon
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
        const char* p = prototype.args[i - offset];
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
          p > wxPliOvlzzz   ? p :
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

static const char *overload_descriptions[] =
{
    NULL, "array", "boolean", "number", "string/scalar", "input stream",
    "output stream", "Wx::Point/array", "Wx::Position/array", "Wx::Size/array"
};

void wxPli_overload_error( pTHX_ const char* function,
                           wxPliPrototype* prototypes[] )
{
    dXSARGS; // restore the mark we implicitly popped in dMARK!
    SV* message = newSVpv( "Availble methods:\n", 0 );
    sv_2mortal( message );

    for( int j = 0; prototypes[j]; ++j )
    {
        wxPliPrototype* p = prototypes[j];

        sv_catpv( message, function );
        sv_catpv( message, "(" );

        for( int i = 0; i < p->count; ++i )
        {
            if( p->args[i] < wxPliOvlzzz )
                sv_catpv( message, overload_descriptions[wxUIntPtr(p->args[i])] );
            else
                sv_catpv( message, p->args[i] );

            if( i != p->count - 1 )
                sv_catpv( message, ", " );                
        }

        sv_catpv( message, ")\n" );
    }

    sv_catpvf( message, "unable to resolve overload for %s(", function );

    for( size_t i = 1; i < items; ++i )
    {
        SV* t = ST(i);
        const char* type;

        if( !SvOK( t ) )
            type = "undef";
        else if( sv_isobject( t ) )
            type = HvNAME( SvSTASH( SvRV( t ) ) );
        else if( SvROK( t ) )
        {
            SV* r = SvRV( t );

            if( SvTYPE( r ) == SVt_PVAV )
                type = "array";
            else if( SvTYPE( r ) == SVt_PVHV )
                type = "hash";
            else
                type = "reference";
        }
        else if( IsGV( t ) )
            type = "glob/handle";
        else if( my_looks_like_number( aTHX_ t ) )
            type = "number";
        else
            type = "scalar";

        sv_catpv( message, type );
        if( i != items - 1 )
            sv_catpv( message, ", " );                
    }

    sv_catpv( message, ")" );

    PUSHMARK(MARK); // probably not necessary

    require_pv( "Carp.pm" );
    const char* argv[2]; argv[0] = SvPV_nolen( message ); argv[1] = NULL;
    call_argv( "Carp::croak", G_VOID|G_DISCARD, (char**) argv ); \
}
