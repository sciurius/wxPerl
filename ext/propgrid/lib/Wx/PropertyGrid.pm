#############################################################################
## Name:        ext/propgrid/lib/Wx/PropertyGrid.pm
## Purpose:     Wx::PropertyGrid and related classes
## Author:      Mark Dootson
## Created:     01/03/2012
## SVN-ID:      $Id$
## Copyright:   (c) 2012 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################
BEGIN {
    package Wx::PropertyGrid;
    our $__wx_pgrid_present = Wx::_wx_optmod_propgrid();
}

package Wx::PropertyGrid;
use strict;

our $VERSION = '0.01';

our $__wx_pgrid_present;

if( $__wx_pgrid_present ) {
    Wx::load_dll( 'adv' );
    Wx::load_dll( 'propgrid' );
    Wx::wx_boot( 'Wx::PropertyGrid', $VERSION );
}

# Setup constants
# (cached strings - not constant at all)

package Wx;
sub wxPG_ATTR_UNITS { return ( $Wx::PropertyGrid::__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_UNITS() : undef ; }
sub wxPG_ATTR_HINT { return ( $Wx::PropertyGrid::__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_HINT() : undef ; }
sub wxPG_ATTR_INLINE_HELP { return ( $Wx::PropertyGrid::__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_INLINE_HELP() : undef ; }
sub wxPG_ATTR_DEFAULT_VALUE { return ( $Wx::PropertyGrid::__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_DEFAULT_VALUE() : undef ; }
sub wxPG_ATTR_MIN { return ( $Wx::PropertyGrid::__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_MIN() : undef ; }
sub wxPG_ATTR_MAX { return ( $Wx::PropertyGrid::__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_MAX() : undef ; }
package Wx::PropertyGrid;

our @_wxpg_extra_exported_constants = qw(
    wxPG_ATTR_UNITS 
    wxPG_ATTR_HINT 
    wxPG_ATTR_INLINE_HELP 
    wxPG_ATTR_DEFAULT_VALUE 
    wxPG_ATTR_MIN 
    wxPG_ATTR_MAX 
    wxPG_ATTR_AUTOCOMPLETE 
    wxPG_BOOL_USE_CHECKBOX 
    wxPG_BOOL_USE_DOUBLE_CLICK_CYCLING 
    wxPG_FLOAT_PRECISION 
    wxPG_STRING_PASSWORD 
    wxPG_UINT_BASE 
    wxPG_UINT_PREFIX 
    wxPG_FILE_WILDCARD 
    wxPG_FILE_SHOW_FULL_PATH 
    wxPG_FILE_SHOW_RELATIVE_PATH 
    wxPG_FILE_INITIAL_PATH 
    wxPG_FILE_DIALOG_TITLE 
    wxPG_DIR_DIALOG_MESSAGE 
    wxPG_ARRAY_DELIMITER 
    wxPG_DATE_FORMAT 
    wxPG_DATE_PICKER_STYLE 
    wxPG_ATTR_SPINCTRL_STEP 
    wxPG_ATTR_SPINCTRL_WRAP 
    wxPG_ATTR_MULTICHOICE_USERSTRINGMODE 
    wxPG_COLOUR_ALLOW_CUSTOM 
    wxPG_COLOUR_HAS_ALPHA 
);

#our @_wxpg_exported_constants = qw(
#    wxPG_ATTR_UNITS wxPG_ATTR_HINT wxPG_ATTR_INLINE_HELP wxPG_ATTR_DEFAULT_VALUE wxPG_ATTR_MIN wxPG_ATTR_MAX
#    wxPG_ATTR_AUTOCOMPLETE wxPG_BOOL_USE_CHECKBOX wxPG_BOOL_USE_DOUBLE_CLICK_CYCLING wxPG_FLOAT_PRECISION
#    wxPG_STRING_PASSWORD wxPG_UINT_BASE wxPG_UINT_PREFIX wxPG_FILE_WILDCARD wxPG_FILE_SHOW_FULL_PATH
#    wxPG_FILE_SHOW_RELATIVE_PATH wxPG_FILE_INITIAL_PATH wxPG_FILE_DIALOG_TITLE wxPG_DIR_DIALOG_MESSAGE
#    wxPG_ARRAY_DELIMITER wxPG_DATE_FORMAT wxPG_DATE_PICKER_STYLE wxPG_ATTR_SPINCTRL_STEP wxPG_ATTR_SPINCTRL_WRAP
#    wxPG_ATTR_MULTICHOICE_USERSTRINGMODE wxPG_COLOUR_ALLOW_CUSTOM wxPG_COLOUR_HAS_ALPHA wxPG_ITERATE_PROPERTIES
#    wxPG_ITERATE_HIDDEN  wxPG_ITERATE_FIXED_CHILDREN  wxPG_ITERATE_CATEGORIES  wxPG_ITERATE_ALL_PARENTS
#    wxPG_ITERATE_ALL_PARENTS_RECURSIVELY  wxPG_ITERATOR_FLAGS_ALL  wxPG_ITERATOR_MASK_OP_ITEM
#    wxPG_ITERATOR_MASK_OP_PARENT  wxPG_ITERATE_VISIBLE  wxPG_ITERATE_ALL  wxPG_ITERATE_NORMAL  wxPG_ITERATE_DEFAULT
#    wxPG_PROP_MODIFIED  wxPG_PROP_DISABLED  wxPG_PROP_HIDDEN  wxPG_PROP_CUSTOMIMAGE  wxPG_PROP_NOEDITOR
#    wxPG_PROP_COLLAPSED  wxPG_PROP_INVALID_VALUE  wxPG_PROP_WAS_MODIFIED  wxPG_PROP_AGGREGATE
#    wxPG_PROP_CHILDREN_ARE_COPIES  wxPG_PROP_PROPERTY  wxPG_PROP_CATEGORY  wxPG_PROP_MISC_PARENT  wxPG_PROP_READONLY
#    wxPG_PROP_COMPOSED_VALUE  wxPG_PROP_USES_COMMON_VALUE  wxPG_PROP_AUTO_UNSPECIFIED  wxPG_PROP_CLASS_SPECIFIC_1
#    wxPG_PROP_CLASS_SPECIFIC_2  wxPG_PROP_BEING_DELETED  wxPG_PROP_MAX  wxPG_PROP_PARENTAL_FLAGS  wxPG_AUTO_SORT
#    wxPG_HIDE_CATEGORIES  wxPG_ALPHABETIC_MODE  wxPG_BOLD_MODIFIED  wxPG_SPLITTER_AUTO_CENTER  wxPG_TOOLTIPS
#    wxPG_HIDE_MARGIN  wxPG_STATIC_SPLITTER  wxPG_STATIC_LAYOUT  wxPG_LIMITED_EDITING  wxPG_TOOLBAR  wxPG_DESCRIPTION
#    wxPG_NO_INTERNAL_BORDER  wxPG_EX_INIT_NOCAT  wxPG_EX_NO_FLAT_TOOLBAR  wxPG_EX_MODE_BUTTONS  wxPG_EX_HELP_AS_TOOLTIPS
#    wxPG_EX_NATIVE_DOUBLE_BUFFERING  wxPG_EX_AUTO_UNSPECIFIED_VALUES  wxPG_EX_WRITEONLY_BUILTIN_ATTRIBUTES
#    wxPG_EX_HIDE_PAGE_BUTTONS  wxPG_EX_MULTIPLE_SELECTION  wxPG_EX_ENABLE_TLP_TRACKING  wxPG_EX_NO_TOOLBAR_DIVIDER
#    wxPG_EX_TOOLBAR_SEPARATOR  wxPG_DEFAULT_STYLE  wxPGMAN_DEFAULT_STYLE  wxPG_VFB_STAY_IN_PROPERTY  wxPG_VFB_BEEP
#    wxPG_VFB_MARK_CELL  wxPG_VFB_SHOW_MESSAGE  wxPG_VFB_SHOW_MESSAGEBOX  wxPG_VFB_SHOW_MESSAGE_ON_STATUSBAR
#    wxPG_VFB_DEFAULT  wxPG_ACTION_INVALID  wxPG_ACTION_NEXT_PROPERTY  wxPG_ACTION_PREV_PROPERTY
#    wxPG_ACTION_EXPAND_PROPERTY  wxPG_ACTION_COLLAPSE_PROPERTY  wxPG_ACTION_CANCEL_EDIT  wxPG_ACTION_EDIT
#    wxPG_ACTION_PRESS_BUTTON  wxPG_ACTION_MAX  wxPGState_SelectionState  wxPGState_ExpandedState
#    wxPGState_ScrollPosState  wxPGState_PageState  wxPGState_SplitterPosState  wxPGState_DescBoxState
#    wxPGState_AllStates  wxPGRender_ChoicePopup  wxPGRender_Control  wxPGRender_Disabled
#    wxPGRender_DontUseCellFgCol  wxPGRender_DontUseCellBgCol  wxPGRender_DontUseCellColours
#    wxPG_LABEL wxPG_LABEL_STRING wxPG_NULL_BITMAP wxPG_COLOUR_BLACK wxPG_COLOUR wxPG_DEFAULT_IMAGE_SIZE wxPG_INVALID_VALUE
#    wxPG_KEEP_STRUCTURE wxPG_RECURSE wxPG_INC_ATTRIBUTES wxPG_RECURSE_STARTS wxPG_FORCE wxPG_SORT_TOP_LEVEL_ONLY wxPG_DONT_RECURSE
#    wxPG_FULL_VALUE wxPG_REPORT_ERROR wxPG_PROPERTY_SPECIFIC wxPG_EDITABLE_VALUE wxPG_COMPOSITE_FRAGMENT wxPG_UNEDITABLE_COMPOSITE_FRAGMENT
#    wxPG_VALUE_IS_CURRENT wxPG_PROGRAMMATIC_VALUE wxPG_SETVAL_REFRESH_EDITOR wxPG_SETVAL_AGGREGATED wxPG_SETVAL_FROM_PARENT
#    wxPG_SETVAL_BY_USER wxPG_BASE_OCT wxPG_BASE_DEC wxPG_BASE_HEX wxPG_BASE_HEXL wxPG_PREFIX_NONE wxPG_PREFIX_0x wxPG_PREFIX_DOLLAR_SIGN 
#);

#if( $__wx_pgrid_present ) {
#    push @Wx::EXPORT_OK, @_wxpg_exported_constants;
#    $Wx::EXPORT_TAGS{'propertygrid'} = [ @_wxpg_exported_constants ];
#}

if( $__wx_pgrid_present ) {
    push @{ $Wx::EXPORT_TAGS{'propgrid'} }, @_wxpg_extra_exported_constants;
}

#
# properly setup inheritance tree
#

no strict;

package Wx::PropertyGridIteratorBase;
package Wx::PropertyGridIterator; @ISA = qw( Wx::PropertyGridIteratorBase );
package Wx::PropertyGridManager; @ISA = qw( Wx::Panel );
package Wx::PlPropertyGridManager; @ISA = qw( Wx::PropertyGridManager );
package Wx::PropertyGridPage; @ISA = qw( Wx::EvtHandler );
package Wx::PropertyGrid; @ISA = qw( Wx::Control);
package Wx::PlPropertyGrid; @ISA = qw( Wx::PropertyGrid );

package Wx::PGPropArgCls;
package Wx::PGPropArg; @ISA = qw( Wx::PGPropArgCls );
package Wx::PGProperty; @ISA = qw( Wx::Object );
package Wx::PropertyCategory; @ISA = qw( Wx::PGProperty );
package Wx::PGCell; @ISA = qw( Wx::Object );

package Wx::ObjectRefData;

package Wx::PGCellRenderer; @ISA = qw( Wx::ObjectRefData );
package Wx::PGDefaultRenderer; @ISA = qw( Wx::PGCellRenderer );
package Wx::PGChoicesData; @ISA = qw( Wx::ObjectRefData );
package Wx::PGMultiButton; @ISA = qw( Wx::Window );
package Wx::PGEditor; @ISA = qw( Wx::Object );
package Wx::PlPGEditor; @ISA = qw( Wx::PGEditor );
package Wx::PGTextCtrlEditor;  @ISA = qw( Wx::PGEditor );
package Wx::PlPGTextCtrlEditor;  @ISA = qw( Wx::PGTextCtrlEditor );
package Wx::PGChoiceEditor;  @ISA = qw( Wx::PGEditor );
package Wx::PlPGChoiceEditor;  @ISA = qw( Wx::PGChoiceEditor );
package Wx::PGComboBoxEditor;  @ISA = qw( Wx::PGChoiceEditor );
package Wx::PlPGComboBoxEditor;  @ISA = qw( Wx::PGComboBoxEditor );
package Wx::PGChoiceAndButtonEditor;  @ISA = qw( Wx::PGChoiceEditor );
package Wx::PlPGChoiceAndButtonEditor;  @ISA = qw( Wx::PGChoiceAndButtonEditor );
package Wx::PGTextCtrlAndButtonEditor;  @ISA = qw( Wx::PGTextCtrlEditor );
package Wx::PlPGTextCtrlAndButtonEditor;  @ISA = qw( Wx::PGTextCtrlAndButtonEditor );
package Wx::PGCheckBoxEditor;  @ISA = qw( Wx::PGEditor );
package Wx::PlPGCheckBoxEditor;  @ISA = qw( Wx::PGCheckBoxEditor );

package Wx::PGInDialogValidator;

#package Wx::NumericPropertyValidator; @ISA = qw( Wx::TextValidator );

package Wx::StringProperty; @ISA = qw( Wx::PGProperty );
package Wx::IntProperty; @ISA = qw( Wx::PGProperty );
package Wx::UIntProperty; @ISA = qw( Wx::PGProperty );
package Wx::FloatProperty; @ISA = qw( Wx::PGProperty );
package Wx::BoolProperty; @ISA = qw( Wx::PGProperty );
package Wx::EnumProperty; @ISA = qw( Wx::PGProperty );
package Wx::EditEnumProperty; @ISA = qw( Wx::EnumProperty );
package Wx::FlagsProperty; @ISA = qw( Wx::PGProperty );
package Wx::FileProperty; @ISA = qw( Wx::PGProperty );
package Wx::LongStringProperty; @ISA = qw( Wx::PGProperty );
package Wx::DirProperty ; @ISA = qw( Wx::LongStringProperty );
package Wx::ArrayStringProperty; @ISA = qw( Wx::PGProperty );

package Wx::PGFileDialogAdapter; @ISA = qw( Wx::PGEditorDialogAdapter );  
package Wx::PGLongStringDialogAdapter; @ISA = qw( Wx::PGEditorDialogAdapter ); 

package Wx::PGArrayEditorDialog; @ISA = qw( Wx::Dialog );    
package Wx::PlPGArrayEditorDialog; @ISA = qw( Wx::PGArrayEditorDialog ); 
package Wx::PGArrayStringEditorDialog; @ISA = qw( Wx::PGArrayEditorDialog );

package Wx::ColourPropertyValue; @ISA = qw( Wx::Object );

package Wx::FontProperty; @ISA = qw( Wx::PGProperty );
package Wx::SystemColourProperty; @ISA = qw( Wx::EnumProperty );
package Wx::ColourProperty; @ISA = qw( Wx::SystemColourProperty );
package Wx::CursorProperty; @ISA = qw( Wx::EnumProperty );
package Wx::ImageFileProperty; @ISA = qw( Wx::FileProperty );

package Wx::MultiChoiceProperty; @ISA = qw( Wx::PGProperty );
package Wx::DateProperty; @ISA = qw( Wx::PGProperty );
package Wx::PGSpinCtrlEditor; @ISA = qw( Wx::PGTextCtrlEditor );


1;
