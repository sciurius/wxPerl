#############################################################################
## Name:        XS/Stream.xs
## Purpose:     XS for Wx::*Stream wrappers (using tie)
## Author:      Mattia Barbon
## Modified by:
## Created:     30/03/2001
## RCS-ID:      $Id: Stream.xs,v 1.12 2004/10/19 20:28:05 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/wfstream.h>

MODULE=Wx PACKAGE=Wx::Stream

SV*
TIEHANDLE( package, var )
    const char* package
    void* var
  CODE:
    RETVAL = newSViv( 0 ); // as usual: XSUBpp mortalizes it for us...
    sv_setref_pv( RETVAL, CHAR_P package, var );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::InputStream

size_t
Wx_InputStream::READ( buf, len, offset = 0 )
    SV* buf
    IV len
    IV offset
  PREINIT:
    IV maxlen;
  CODE:
    if( THIS->Eof() ) { SvOK_off( buf ); XSRETURN_IV( 0 ); }

    maxlen = SvPOK( buf ) ? SvCUR( buf ) : 0;

    if( offset < 0 )
    {
        if( abs( offset ) > maxlen )
        {
            XSRETURN_IV( 0 );
        }
        offset = maxlen + offset;
    }

    char* buffer = SvGROW( buf, (UV)offset + len + 1 );
    SvPOK_on( buf );
    if( offset > maxlen )
        Zero( buffer + maxlen, offset - maxlen, char );
    buffer += offset;
    RETVAL = THIS->Read( buffer, len ).LastRead();
    SvCUR_set( buf, offset + RETVAL );
  OUTPUT:
    RETVAL

SV*
Wx_InputStream::GETC()
  CODE:
    char value = THIS->GetC();
    RETVAL = newSVpvn( &value, 1 );
  OUTPUT:
    RETVAL

SV*
Wx_InputStream::SEEK( position, whence )
    off_t position
    int whence
  PREINIT:
    static wxSeekMode s_whence[] = { wxFromStart, wxFromCurrent, wxFromEnd };
  CODE:
    if( whence < 0 || whence > 2 )
        RETVAL = &PL_sv_undef;
    off_t offset = THIS->SeekI( position, s_whence[whence] );
    RETVAL = newSViv( offset );
  OUTPUT:
    RETVAL

SV*
Wx_InputStream::TELL()
  CODE:
    off_t offset = THIS->TellI();
    RETVAL = newSViv( offset );
  OUTPUT:
    RETVAL

SV*
Wx_InputStream::READLINE()
  PREINIT:
    char c;
    wxString val;
  CODE:
    if( THIS->Eof() ) { XSRETURN_UNDEF; }

    while( THIS->CanRead() && THIS->Read( &c, 1 ).LastRead() != 0 ) {
        val.Append( c );
        if( c == '\n' ) break;
    }
    RETVAL = newSViv( 0 );
    WXSTRING_OUTPUT( val, RETVAL );
  OUTPUT: RETVAL

MODULE=Wx PACKAGE=Wx::OutputStream

size_t
Wx_OutputStream::WRITE( buf, len = -1, offset = 0 )
    SV* buf
    IV len
    IV offset
  PREINIT:
    IV maxlen = sv_len( buf );
    const char* buffer = SvPV_nolen( buf );
  CODE:
    if( abs( offset ) > maxlen )
        RETVAL = 0;
    else
    {
        if( offset >=0 )
        {
            buffer += offset;
            maxlen -= offset;
        }
        else
        {
            buffer += maxlen + offset;
            maxlen = -offset;
        }

        len = ( len >= maxlen ) ? maxlen : len;

        RETVAL = THIS->Write( buffer, len ).LastWrite();
    }
  OUTPUT:
    RETVAL

SV*
Wx_OutputStream::SEEK( position, whence )
    off_t position
    int whence
  PREINIT:
    static wxSeekMode s_whence[] = { wxFromStart, wxFromCurrent, wxFromEnd };
  CODE:
    if( whence < 0 || whence > 2 )
        RETVAL = &PL_sv_undef;
    off_t offset = THIS->SeekO( position, s_whence[whence] );
    RETVAL = newSViv( offset );
  OUTPUT:
    RETVAL

SV*
Wx_OutputStream::TELL()
  CODE:
    off_t offset = THIS->TellO();
    RETVAL = newSViv( offset );
  OUTPUT:
    RETVAL
