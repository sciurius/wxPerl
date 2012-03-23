/////////////////////////////////////////////////////////////////////////////
// Name:        propgrid_constants.cpp
// Purpose:     wxPropertyGrid constants
// Author:      Mark Dootson
// SVN ID:      $Id: tl_constants.cpp 3 2010-02-17 06:08:51Z mark.dootson $
// Copyright:   (c) 2012 Mattia barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////


#include <cpp/constants.h>

// TODO:
// this is grim, but I'm not sure how
// to handle class level enumerations.

#define wxPGState_SelectionState   0x01
#define wxPGState_ExpandedState   0x02
#define wxPGState_ScrollPosState   0x04
#define wxPGState_PageState   0x08
#define wxPGState_SplitterPosState   0x10
#define wxPGState_DescBoxState   0x20
#define wxPGState_AllStates   0x3F

#define wxPGRender_ChoicePopup  0x00020000
#define wxPGRender_Control  0x00040000
#define wxPGRender_Disabled  0x00080000
#define wxPGRender_DontUseCellFgCol  0x00100000
#define wxPGRender_DontUseCellBgCol  0x00200000
#define wxPGRender_DontUseCellColours  wxPGRender_DontUseCellFgCol

double propertygrid_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: propgrid
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'P':
        r( wxPG_ITERATE_PROPERTIES );
        r( wxPG_ITERATE_HIDDEN );
        r( wxPG_ITERATE_FIXED_CHILDREN );
        r( wxPG_ITERATE_CATEGORIES );
        r( wxPG_ITERATE_ALL_PARENTS );
        r( wxPG_ITERATE_ALL_PARENTS_RECURSIVELY );
        r( wxPG_ITERATOR_FLAGS_ALL );
        r( wxPG_ITERATOR_MASK_OP_ITEM );
        r( wxPG_ITERATOR_MASK_OP_PARENT );
        r( wxPG_ITERATE_VISIBLE );
        r( wxPG_ITERATE_ALL );
        r( wxPG_ITERATE_NORMAL );
        r( wxPG_ITERATE_DEFAULT );
        r( wxPG_PROP_MODIFIED );
        r( wxPG_PROP_DISABLED );
        r( wxPG_PROP_HIDDEN );
        r( wxPG_PROP_CUSTOMIMAGE );
        r( wxPG_PROP_NOEDITOR );
        r( wxPG_PROP_COLLAPSED );
        r( wxPG_PROP_INVALID_VALUE );
        r( wxPG_PROP_WAS_MODIFIED );
        r( wxPG_PROP_AGGREGATE );
        r( wxPG_PROP_CHILDREN_ARE_COPIES );
        r( wxPG_PROP_PROPERTY );
        r( wxPG_PROP_CATEGORY );
        r( wxPG_PROP_MISC_PARENT );
        r( wxPG_PROP_READONLY );
        r( wxPG_PROP_COMPOSED_VALUE );
        r( wxPG_PROP_USES_COMMON_VALUE );
        r( wxPG_PROP_AUTO_UNSPECIFIED );
        r( wxPG_PROP_CLASS_SPECIFIC_1 );
        r( wxPG_PROP_CLASS_SPECIFIC_2 );
        r( wxPG_PROP_BEING_DELETED );
        r( wxPG_PROP_MAX );
        r( wxPG_PROP_PARENTAL_FLAGS );
        r( wxPG_AUTO_SORT );
        r( wxPG_HIDE_CATEGORIES );
        r( wxPG_ALPHABETIC_MODE );
        r( wxPG_BOLD_MODIFIED );
        r( wxPG_SPLITTER_AUTO_CENTER );
        r( wxPG_TOOLTIPS );
        r( wxPG_HIDE_MARGIN );
        r( wxPG_STATIC_SPLITTER );
        r( wxPG_STATIC_LAYOUT );
        r( wxPG_LIMITED_EDITING );
        r( wxPG_TOOLBAR );
        r( wxPG_DESCRIPTION );
        r( wxPG_NO_INTERNAL_BORDER );
        r( wxPG_EX_INIT_NOCAT );
        r( wxPG_EX_NO_FLAT_TOOLBAR );
        r( wxPG_EX_MODE_BUTTONS );
        r( wxPG_EX_HELP_AS_TOOLTIPS );
        r( wxPG_EX_NATIVE_DOUBLE_BUFFERING );
        r( wxPG_EX_AUTO_UNSPECIFIED_VALUES );
        r( wxPG_EX_WRITEONLY_BUILTIN_ATTRIBUTES );
        r( wxPG_EX_HIDE_PAGE_BUTTONS );
        r( wxPG_EX_MULTIPLE_SELECTION );
        r( wxPG_EX_ENABLE_TLP_TRACKING );
        r( wxPG_EX_NO_TOOLBAR_DIVIDER );
        r( wxPG_EX_TOOLBAR_SEPARATOR );
        r( wxPG_DEFAULT_STYLE );
        r( wxPGMAN_DEFAULT_STYLE );
        r( wxPG_VFB_STAY_IN_PROPERTY );
        r( wxPG_VFB_BEEP );
        r( wxPG_VFB_MARK_CELL );
        r( wxPG_VFB_SHOW_MESSAGE );
        r( wxPG_VFB_SHOW_MESSAGEBOX );
        r( wxPG_VFB_SHOW_MESSAGE_ON_STATUSBAR );
        r( wxPG_VFB_DEFAULT );
        r( wxPG_ACTION_INVALID );
        r( wxPG_ACTION_NEXT_PROPERTY );
        r( wxPG_ACTION_PREV_PROPERTY );
        r( wxPG_ACTION_EXPAND_PROPERTY );
        r( wxPG_ACTION_COLLAPSE_PROPERTY );
        r( wxPG_ACTION_CANCEL_EDIT );
        r( wxPG_ACTION_EDIT );
        r( wxPG_ACTION_PRESS_BUTTON );
        r( wxPG_ACTION_MAX );
        r( wxPGState_SelectionState );
        r( wxPGState_ExpandedState );
        r( wxPGState_ScrollPosState );
        r( wxPGState_PageState );
        r( wxPGState_SplitterPosState );
        r( wxPGState_DescBoxState );
        r( wxPGState_AllStates );
        r( wxPGRender_ChoicePopup );
        r( wxPGRender_Control );
        r( wxPGRender_Disabled );
        r( wxPGRender_DontUseCellFgCol );
        r( wxPGRender_DontUseCellBgCol );
        r( wxPGRender_DontUseCellColours );
        
        r( wxPG_PROPERTY_VALIDATION_ERROR_MESSAGE );
        r( wxPG_PROPERTY_VALIDATION_SATURATE );
        r( wxPG_PROPERTY_VALIDATION_WRAP );
        
        // r( wxPG_LABEL );
        // r( wxPG_LABEL_STRING );
        // r( wxPG_NULL_BITMAP );
        // r( wxPG_COLOUR_BLACK );
        // r( wxPG_COLOUR );
        // r( wxPG_DEFAULT_IMAGE_SIZE );
        
        r( wxPG_INVALID_VALUE );
        
        r( wxPG_KEEP_STRUCTURE );
        r( wxPG_RECURSE );
        r( wxPG_INC_ATTRIBUTES );
        r( wxPG_RECURSE_STARTS );
        r( wxPG_FORCE );
        r( wxPG_SORT_TOP_LEVEL_ONLY );
        r( wxPG_DONT_RECURSE );
          
        r( wxPG_FULL_VALUE );
        r( wxPG_REPORT_ERROR );
        r( wxPG_PROPERTY_SPECIFIC );
        r( wxPG_EDITABLE_VALUE );
        r( wxPG_COMPOSITE_FRAGMENT );
        r( wxPG_UNEDITABLE_COMPOSITE_FRAGMENT );
        r( wxPG_VALUE_IS_CURRENT );
        r( wxPG_PROGRAMMATIC_VALUE );
        r( wxPG_SETVAL_REFRESH_EDITOR );
        r( wxPG_SETVAL_AGGREGATED );
        r( wxPG_SETVAL_FROM_PARENT );
        r( wxPG_SETVAL_BY_USER ); 
        r( wxPG_BASE_OCT );
        r( wxPG_BASE_DEC );
        r( wxPG_BASE_HEX );
        r( wxPG_BASE_HEXL );
        r( wxPG_PREFIX_NONE );
        r( wxPG_PREFIX_0x );
        r( wxPG_PREFIX_DOLLAR_SIGN );
        
        break;
    default:
        break;
    }

    
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants propertygrid_module( &propertygrid_constant );

