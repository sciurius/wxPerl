#############################################################################
## Name:        Config.xs
## Purpose:     XS for Wx::*Config*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/confbase.h>

MODULE=Wx PACKAGE=Wx::ConfigBase

void
Wx_ConfigBase::Destroy()
  CODE:
    delete THIS;

Wx_ConfigBase*
Create()
  CODE:
    RETVAL = wxConfigBase::Create();
  OUTPUT:
    RETVAL

void
DontCreateOnDemand()
  CODE:
    wxConfigBase::DontCreateOnDemand();

bool
Wx_ConfigBase::DeleteAll()

bool
Wx_ConfigBase::DeleteEntry( key, deleteGroupIfEmpty = TRUE )
    wxString key
    bool deleteGroupIfEmpty

bool
Wx_ConfigBase::DeleteGroup( key )
    wxString key

bool
Wx_ConfigBase::Exists( key )
    wxString key

bool
Wx_ConfigBase::Flush( currentOnly = FALSE )
    bool currentOnly

Wx_ConfigBase*
Get( createOnDemand = TRUE )
    bool createOnDemand
  CODE:
    RETVAL = wxConfigBase::Get( createOnDemand );
  OUTPUT:
    RETVAL

wxString
Wx_ConfigBase::GetAppName()

EntryType
Wx_ConfigBase::GetEntryType( name )
    wxString name

void
Wx_ConfigBase::GetFirstEntry()
  PREINIT:
    wxString name;
    long index;
    bool ret;
  PPCODE:
    ret = THIS->GetFirstEntry( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

void
Wx_ConfigBase::GetFirstGroup()
  PREINIT:
    wxString name;
    long index;
    bool ret;
  PPCODE:
    ret = THIS->GetFirstGroup( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

void
Wx_ConfigBase::GetNextEntry( index )
    long index
  PREINIT:
    wxString name;
    bool ret;
  PPCODE:
    ret = THIS->GetNextEntry( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

void
Wx_ConfigBase::GetNextGroup( index )
    long index
  PREINIT:
    wxString name;
    bool ret;
  PPCODE:
    ret = THIS->GetNextGroup( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

unsigned int
Wx_ConfigBase::GetNumberOfEntries( recursive = FALSE )
    bool recursive

unsigned int
Wx_ConfigBase::GetNumberOfGroups( recursive = FALSE )
    bool recursive

wxString
Wx_ConfigBase::GetPath()

wxString
Wx_ConfigBase::GetVendorName()

bool
Wx_ConfigBase::HasEntry( name )
    wxString name

bool
Wx_ConfigBase::HasGroup( name )
    wxString name

bool
Wx_ConfigBase::IsExpandingEnvVars()

bool
Wx_ConfigBase::IsRecordingDefaults()

wxString
Wx_ConfigBase::Read( key, def = wxEmptyString )
    wxString key
    wxString def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

long
Wx_ConfigBase::ReadInt( key, def = 0 )
    wxString key
    long def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

double
Wx_ConfigBase::ReadFloat( key, def = 0.0 )
    wxString key
    double def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

bool
Wx_ConfigBase::ReadBool( key, def = FALSE )
    wxString key
    bool def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

bool
Wx_ConfigBase::RenameEntry( oldName, newName )
     wxString oldName
     wxString newName

bool
Wx_ConfigBase::RenameGroup( oldName, newName )
     wxString oldName
     wxString newName

void
Set( config )
    Wx_ConfigBase* config
  CODE:
    wxConfigBase::Set( config );

void
Wx_ConfigBase::SetExpandEnvVars( doIt = TRUE )
    bool doIt

void
Wx_ConfigBase::SetPath( path )
    wxString path

void
Wx_ConfigBase::SetRecordDefaults( doIt = TRUE )
    bool doIt

void
Wx_ConfigBase::Write( key, value )
    wxString key
    wxString value
  CODE:
    THIS->Write( key, value );

void
Wx_ConfigBase::WriteInt( key, value )
    wxString key
    long value
  CODE:
    THIS->Write( key, value );

void
Wx_ConfigBase::WriteFloat( key, value )
    wxString key
    double value
  CODE:
    THIS->Write( key, value );

void
Wx_ConfigBase::WriteBool( key, value )
    wxString key
    bool value
  CODE:
    THIS->Write( key, value );

MODULE=Wx PACKAGE=Wx::RegConfig

#if defined(__WXMSW__)

#include <wx/msw/regconf.h>

Wx_ConfigBase*
Wx_RegConfig::new( appName = wxEmptyString, vendorName = wxEmptyString, localFilename = wxEmptyString, globalFilename = wxEmptyString, style = 0 )
    wxString appName
    wxString vendorName
    wxString localFilename
    wxString globalFilename
    long style

#endif

MODULE=Wx PACKAGE=Wx::FileConfig

#include <wx/fileconf.h>

Wx_ConfigBase*
Wx_FileConfig::new( appName = wxEmptyString, vendorName = wxEmptyString, localFilename = wxEmptyString, globalFilename = wxEmptyString, style = 0 )
    wxString appName
    wxString vendorName
    wxString localFilename
    wxString globalFilename
    long style


