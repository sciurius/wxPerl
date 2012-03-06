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
    our $__wx_pgrid_present = defined(&Wx::wxPG_ATTR_AUTOCOMPLETE);
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
sub wxPG_ATTR_UNITS { return ( $__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_UNITS() : undef ; }
sub wxPG_ATTR_HINT { return ( $__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_HINT() : undef ; }
sub wxPG_ATTR_INLINE_HELP { return ( $__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_INLINE_HELP() : undef ; }
sub wxPG_ATTR_DEFAULT_VALUE { return ( $__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_DEFAULT_VALUE() : undef ; }
sub wxPG_ATTR_MIN { return ( $__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_MIN() : undef ; }
sub wxPG_ATTR_MAX { return ( $__wx_pgrid_present ) ? Wx::PropertyGrid::_get_wxPG_ATTR_MAX() : undef ; }

our @_wxpg_exported_constants = qw(
    wxPG_ATTR_UNITS wxPG_ATTR_HINT wxPG_ATTR_INLINE_HELP wxPG_ATTR_DEFAULT_VALUE wxPG_ATTR_MIN wxPG_ATTR_MAX
    wxPG_ATTR_AUTOCOMPLETE wxPG_BOOL_USE_CHECKBOX wxPG_BOOL_USE_DOUBLE_CLICK_CYCLING wxPG_FLOAT_PRECISION
    wxPG_STRING_PASSWORD wxPG_UINT_BASE wxPG_UINT_PREFIX wxPG_FILE_WILDCARD wxPG_FILE_SHOW_FULL_PATH
    wxPG_FILE_SHOW_RELATIVE_PATH wxPG_FILE_INITIAL_PATH wxPG_FILE_DIALOG_TITLE wxPG_DIR_DIALOG_MESSAGE
    wxPG_ARRAY_DELIMITER wxPG_DATE_FORMAT wxPG_DATE_PICKER_STYLE wxPG_ATTR_SPINCTRL_STEP wxPG_ATTR_SPINCTRL_WRAP
    wxPG_ATTR_MULTICHOICE_USERSTRINGMODE wxPG_COLOUR_ALLOW_CUSTOM wxPG_COLOUR_HAS_ALPHA wxPG_ITERATE_PROPERTIES
    wxPG_ITERATE_HIDDEN  wxPG_ITERATE_FIXED_CHILDREN  wxPG_ITERATE_CATEGORIES  wxPG_ITERATE_ALL_PARENTS
    wxPG_ITERATE_ALL_PARENTS_RECURSIVELY  wxPG_ITERATOR_FLAGS_ALL  wxPG_ITERATOR_MASK_OP_ITEM
    wxPG_ITERATOR_MASK_OP_PARENT  wxPG_ITERATE_VISIBLE  wxPG_ITERATE_ALL  wxPG_ITERATE_NORMAL  wxPG_ITERATE_DEFAULT
    wxPG_PROP_MODIFIED  wxPG_PROP_DISABLED  wxPG_PROP_HIDDEN  wxPG_PROP_CUSTOMIMAGE  wxPG_PROP_NOEDITOR
    wxPG_PROP_COLLAPSED  wxPG_PROP_INVALID_VALUE  wxPG_PROP_WAS_MODIFIED  wxPG_PROP_AGGREGATE
    wxPG_PROP_CHILDREN_ARE_COPIES  wxPG_PROP_PROPERTY  wxPG_PROP_CATEGORY  wxPG_PROP_MISC_PARENT  wxPG_PROP_READONLY
    wxPG_PROP_COMPOSED_VALUE  wxPG_PROP_USES_COMMON_VALUE  wxPG_PROP_AUTO_UNSPECIFIED  wxPG_PROP_CLASS_SPECIFIC_1
    wxPG_PROP_CLASS_SPECIFIC_2  wxPG_PROP_BEING_DELETED  wxPG_PROP_MAX  wxPG_PROP_PARENTAL_FLAGS  wxPG_AUTO_SORT
    wxPG_HIDE_CATEGORIES  wxPG_ALPHABETIC_MODE  wxPG_BOLD_MODIFIED  wxPG_SPLITTER_AUTO_CENTER  wxPG_TOOLTIPS
    wxPG_HIDE_MARGIN  wxPG_STATIC_SPLITTER  wxPG_STATIC_LAYOUT  wxPG_LIMITED_EDITING  wxPG_TOOLBAR  wxPG_DESCRIPTION
    wxPG_NO_INTERNAL_BORDER  wxPG_EX_INIT_NOCAT  wxPG_EX_NO_FLAT_TOOLBAR  wxPG_EX_MODE_BUTTONS  wxPG_EX_HELP_AS_TOOLTIPS
    wxPG_EX_NATIVE_DOUBLE_BUFFERING  wxPG_EX_AUTO_UNSPECIFIED_VALUES  wxPG_EX_WRITEONLY_BUILTIN_ATTRIBUTES
    wxPG_EX_HIDE_PAGE_BUTTONS  wxPG_EX_MULTIPLE_SELECTION  wxPG_EX_ENABLE_TLP_TRACKING  wxPG_EX_NO_TOOLBAR_DIVIDER
    wxPG_EX_TOOLBAR_SEPARATOR  wxPG_DEFAULT_STYLE  wxPGMAN_DEFAULT_STYLE  wxPG_VFB_STAY_IN_PROPERTY  wxPG_VFB_BEEP
    wxPG_VFB_MARK_CELL  wxPG_VFB_SHOW_MESSAGE  wxPG_VFB_SHOW_MESSAGEBOX  wxPG_VFB_SHOW_MESSAGE_ON_STATUSBAR
    wxPG_VFB_DEFAULT  wxPG_ACTION_INVALID  wxPG_ACTION_NEXT_PROPERTY  wxPG_ACTION_PREV_PROPERTY
    wxPG_ACTION_EXPAND_PROPERTY  wxPG_ACTION_COLLAPSE_PROPERTY  wxPG_ACTION_CANCEL_EDIT  wxPG_ACTION_EDIT
    wxPG_ACTION_PRESS_BUTTON  wxPG_ACTION_MAX  wxPGState_SelectionState  wxPGState_ExpandedState
    wxPGState_ScrollPosState  wxPGState_PageState  wxPGState_SplitterPosState  wxPGState_DescBoxState
    wxPGState_AllStates  wxPGRender_ChoicePopup  wxPGRender_Control  wxPGRender_Disabled
    wxPGRender_DontUseCellFgCol  wxPGRender_DontUseCellBgCol  wxPGRender_DontUseCellColours
);

if( $__wx_pgrid_present ) {
    push @Wx::EXPORT_OK, @_wxpg_exported_constants;
    $Wx::EXPORT_TAGS{'propertygrid'} = [ @_wxpg_exported_constants ];
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
package Wx::PGProperty;
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


1;
