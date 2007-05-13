#############################################################################
## Name:        XS/ClassInfo.xs
## Purpose:     XS for Wx::ClassInfo the CLASSINFO macro
## Author:      Mattia Barbon
## Modified by:
## Created:     20/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2001, 2004, 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%module{Wx};

%typemap{wxClassInfo*}{simple};
%typemap{const wxClassInfo*}{simple};
%typemap{wxPropertyInfo*}{simple};
%typemap{const wxPropertyInfo*}{simple};
%typemap{const wxTypeInfo*}{simple};
%typemap{wxPropertyAccessor*}{simple};
%typemap{wxTypeKind}{simple};
%typemap{wxPropertyInfoFlags}{simple};

%{

MODULE=Wx PACKAGE=Wx::ClassInfo

wxClassInfo*
FindClass( name )
    wxChar* name
  CODE:
    RETVAL = wxClassInfo::FindClass( name );
  OUTPUT: RETVAL

const wxChar*
wxClassInfo::GetBaseClassName1()

const wxChar*
wxClassInfo::GetBaseClassName2()

const wxChar*
wxClassInfo::GetClassName()

%}

#if wxUSE_EXTENDED_RTTI

%name{Wx::ClassInfo} class wxClassInfo
{
%{
void
wxClassInfo::GetParents()
  PPCODE:
    const wxClassInfo** parents = THIS->GetParents();
    while( *parents )
        XPUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                       *parents, "Wx::ClassInfo" ) );
%}

    const wxPropertyInfo* GetFirstProperty();
    const wxPropertyInfo* FindPropertyInfo( const wxChar* name );
    const wxPropertyInfo* FindPropertyInfoInThisClass( const wxChar* name );
##  void GetProperties( wxPropertyInfoMap &map ) const;
};

%name{Wx::PropertyInfo} class wxPropertyInfo
{
    const wxClassInfo*  GetDeclaringClass() const;
    const wxString&     GetName() const;
    wxPropertyInfoFlags GetFlags() const;
    const wxString&     GetHelpString() const;
    const wxString&     GetGroupString() const;
    const wxTypeInfo *  GetCollectionElementTypeInfo() const;
    const wxTypeInfo *  GetTypeInfo() const;
    wxPropertyAccessor* GetAccessor() const;
    wxPropertyInfo*     GetNext() const;
};

%name{Wx::TypeInfo} class wxTypeInfo
{
    wxTypeKind GetKind() const;
    const wxString& GetTypeName() const;
    bool IsDelegateType() const;
    bool IsCustomType() const;
    bool IsObjectType() const;
};

%name{Wx::PropertyAccessor} class wxPropertyAccessor
{
    bool HasSetter() const;
    bool HasCollectionGetter() const;
    bool HasGetter() const;
    bool HasAdder() const;
    const wxString& GetCollectionGetterName() const;
    const wxString&  GetGetterName() const;
    const wxString& GetSetterName() const;
    const wxString& GetAdderName() const;
};

#endif
