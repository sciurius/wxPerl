/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/array_helpers.h
// Purpose:     some helper functions/classes for array conversion
// Author:      Mattia Barbon
// Modified by:
// Created:     27/12/2009
// RCS-ID:      $Id: helpers.h 2589 2009-07-01 22:06:13Z mbarbon $
// Copyright:   (c) 2009 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef __CPP_ARRAY_HELPERS_H
#define __CPP_ARRAY_HELPERS_H

template<class F, class C>
int wxPli_av_2_arrayany( pTHX_ SV* avref, typename C::pointer_type array,
                         const F& convertf, const C& allocator )
{
    AV* av;

    if( !SvROK( avref ) ||
        ( SvTYPE( (SV*) ( av = (AV*) SvRV( avref ) ) ) != SVt_PVAV ) )
    {
        croak( "the value is not an array reference" );
        return 0;
    }

    int n = av_len( av ) + 1;
    typename C::value_type arr = allocator.create( n );

    for( int i = 0; i < n; ++i )
    {
        SV* t = *av_fetch( av, i, 0 );
        if( !convertf( aTHX_ arr[i], t ) )
        {
            allocator.free( arr );
            croak( "invalid conversion for array element" );
            return 0;
        }
    }

    allocator.assign( array, arr );

    return n;
}

// value conversion functions

class wxPli_convert_sv
{
public:
    bool operator()( pTHX_ SV*& dest, SV* src ) const
    {
        dest = src;
        return true;
    }
};

class wxPli_convert_uchar
{
public:
    bool operator()( pTHX_ unsigned char& dest, SV* src ) const
    {
        dest = (unsigned char) SvUV( src );
        return true;
    }
};

class wxPli_convert_int
{
public:
    bool operator()( pTHX_ int& dest, SV* src ) const
    {
        dest = (int) SvIV( src );
        return true;
    }
};

class wxPli_convert_wxstring
{
public:
    bool operator()( pTHX_ wxString& dest, SV* src ) const
    {
        WXSTRING_INPUT( dest, const char*, src );
        return true;
    }
};

// array adapters

// C-type arrays

template<class CType>
class wxPli_array_allocator
{
public:
    typedef CType** pointer_type;
    typedef CType* value_type;

    value_type create( size_t n ) const { return new CType[n]; }
    void assign( pointer_type lv, value_type rv ) const { *lv = rv; }
    void free( value_type rv ) const { delete[] rv; }
};


// wxWidgets' array types

template<class A, class V>
class wxPli_wxarray_allocator
{
public:
    typedef A* pointer_type;
    typedef A& value_type;

    wxPli_wxarray_allocator( pointer_type lv ) : m_value( lv ) { }

    value_type create( size_t n ) const
    {
        m_value->Alloc( n );
        for( size_t i = 0; i < n; ++i )
            m_value->Add( V() );
        return *m_value;
    }

    void assign( pointer_type, value_type ) const { }
    void free( value_type ) const { }

private:
    A* m_value;
};


// adapter for wxVector and std::vector

template<class A, class V>
class wxPli_vector_allocator
{
public:
    typedef A* pointer_type;
    typedef A& value_type;

    wxPli_vector_allocator( pointer_type lv ) : m_value( lv ) { }

    value_type create( size_t n ) const
    {
        m_value->reserve( n );
        for( size_t i = 0; i < n; ++i )
            m_value->push_back( V() );
        return *m_value;
    }

    void assign( pointer_type, value_type ) const { }
    void free( value_type ) const { }

private:
    A* m_value;
};

#endif // __CPP_ARRAY_HELPERS_H
