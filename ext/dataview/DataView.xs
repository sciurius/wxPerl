/////////////////////////////////////////////////////////////////////////////
// Name:        ext/dataview/DataView.xs
// Purpose:     XS for Wx::DataViewCtrl
// Author:      Mattia Barbon
// Modified by:
// Created:     05/11/2007
// RCS-ID:      $Id$
// Copyright:   (c) 2007-2008 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/overload.h"

// re-include for client data
#include <wx/clntdata.h>
#include "cpp/helpers.h"

#define wxDefaultValidatorPtr (wxValidator*)&wxDefaultValidator

#undef THIS

#include "cpp/constants.h"
#include "cpp/overload.h"

#define wxNullIconPtr (wxIcon*) &wxNullIcon

// event macros
#define SEVT( NAME, ARGS )    wxPli_StdEvent( NAME, ARGS )
#define EVT( NAME, ARGS, ID ) wxPli_Event( NAME, ARGS, ID )

// !package: Wx::Event
// !tag:
// !parser: sub { $_[0] =~ m<^\s*S?EVT\(\s*(\w+)\s*\,> }

static wxPliEventDescription evts[] =
{
    { 0, 0, 0 }
};

MODULE=Wx__DataView

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewCtrl.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewModel.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewIndexListModel.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewColumn.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewEvent.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewItem.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewModelNotifier.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewRenderer.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewTreeStore.xsp |

INCLUDE: xspp -t ../../typemap.xsp -t typemap.xsp XS/DataViewTreeCtrl.xsp |

MODULE=Wx__DataView PACKAGE=Wx::DataView

void
SetEvents()
  CODE:
    wxPli_set_events( evts );

#include "cpp/ovl_const.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__DataView
