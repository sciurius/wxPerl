/////////////////////////////////////////////////////////////////////////////
// Name:        Controls.xs
// Purpose:     XS for Wx::Control and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2007 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#include <wx/defs.h>

#include <wx/imaglist.h>
#include <wx/event.h>
#include <wx/colour.h>
#include <wx/listctrl.h>
#include <wx/treectrl.h>
#include <wx/ctrlsub.h>

// re-include for client data
#include "cpp/helpers.h"

#define wxDefaultValidatorPtr (wxValidator*)&wxDefaultValidator
#define wxBLACKPtr (wxColour*)wxBLACK
#define wxNORMAL_FONTPtr (wxFont*)wxNORMAL_FONT
#define wxNullBitmapPtr (wxBitmap*) &wxNullBitmap
#define wxNullAnimationPtr (wxAnimation*) &wxNullAnimation

#undef THIS

#include "cpp/v_cback.h"

#include "cpp/controls.h"
#include "cpp/controls.cpp"
#include "cpp/overload.h"

WXPLI_BOOT_ONCE(Wx_Ctrl);
#define boot_Wx_Ctrl wxPli_boot_Wx_Ctrl

MODULE=Wx_Ctrl PACKAGE=Wx::Control

void
wxControl::Command( event )
    wxCommandEvent* event
  CODE:
    THIS->Command( *event );

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

wxString
wxControl::GetLabelText()

#endif

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/ControlWithItems.xsp |

INCLUDE: XS/BitmapButton.xs
INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/AnimationCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/EditableListBox.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/BookCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/Listbook.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/Choicebook.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/Toolbook.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/Treebook.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/HyperlinkCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/VListBox.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/SearchCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/ComboPopup.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/ComboCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/OwnerDrawnComboBox.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/CollapsiblePane.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/BitmapComboBox.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/DirCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/FileCtrl.xsp |

INCLUDE: XS/Button.xs
INCLUDE: XS/CheckBox.xs
INCLUDE: XS/CheckListBox.xs
INCLUDE: XS/Choice.xs
INCLUDE: XS/ComboBox.xs
INCLUDE: XS/Gauge.xs
INCLUDE: XS/ListBox.xs
INCLUDE: XS/ListCtrl.xs
INCLUDE: XS/Notebook.xs
INCLUDE: XS/RadioBox.xs
INCLUDE: XS/RadioButton.xs
INCLUDE: XS/ScrollBar.xs
INCLUDE: XS/Slider.xs
INCLUDE: XS/SpinButton.xs
INCLUDE: XS/SpinCtrl.xs
INCLUDE: XS/StaticBitmap.xs
INCLUDE: XS/StaticBox.xs
INCLUDE: XS/StaticLine.xs
INCLUDE: XS/StaticText.xs
INCLUDE: XS/ToggleButton.xs
INCLUDE: XS/TreeCtrl.xs

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/TextAttr.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/TextCtrl.xs |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/PickerCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/ColourPickerCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/FilePickerCtrl.xsp |

INCLUDE: perl script/wx_xspp.pl -t typemap.xsp XS/FontPickerCtrl.xsp |

MODULE=Wx_Ctrl PACKAGE=Wx::Control
