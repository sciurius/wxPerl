/////////////////////////////////////////////////////////////////////////////
// Name:        constants.h
// Purpose:     module to allow modularity in constant() function
// Author:      Mattia Barbon
// Modified by:
// Created:     17/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_CONSTANTS_H
#define _WXPERL_CONSTANTS_H

#include <wx/module.h>
#include <wx/list.h>

typedef double (*PL_CONST_FUNC)( const char*, int );

#define WX_PL_CONSTANT_INIT() \
  errno = 0;                \
  char fl = name[0];        \
                            \
  if( tolower( name[0] ) == 'w' && tolower( name[1] ) == 'x' ) \
    fl = toupper( name[2] );

#define WX_PL_CONSTANT_CLEANUP() \
  errno = EINVAL;                \
  return 0;

class wxPlConstantsModule;

WX_DECLARE_LIST( wxPlConstantsModule, wxPlConstantsModuleList );

// implementation for OnInit/OnExit in Constants.xs
class  WXPLDLL wxPlConstantsModule:public wxModule
{
    DECLARE_DYNAMIC_CLASS( wxPlConstantsModule );
public:
    wxPlConstantsModule();
    wxPlConstantsModule( PL_CONST_FUNC function );
//    ~wxPlConstantsModule();

    bool OnInit();
    void OnExit();
private:
    void AppendFunction();
    void RemoveFunction();
private:
    static bool& sm_initialized();
    static wxPlConstantsModuleList& sm_list();

    PL_CONST_FUNC m_function;
};

inline wxPlConstantsModule::wxPlConstantsModule()
    :m_function( 0 )
{
}

//inline wxPlConstantsModule::~wxPlConstantsModule() { RemoveFunction(); }

#endif
    // _WXPERL_CONSTANTS_H

// Local variables: //
// mode: c++ //
// End: //



