/////////////////////////////////////////////////////////////////////////////
// Name:        pr_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:      4/ 5/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_PRINT_TYPEDEF_H
#define _WXPERL_PRINT_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

FD_TD( PrintData );
FD_TD( PageSetupDialogData );
FD_TD( PrintDialogData );
FD_TD( Printout );
FD_TD( PrinterDC );
FD_TD( PrintDialog );
FD_TD( PreviewControlBar );
FD_TD( PreviewCanvas );
FD_TD( PreviewFrame );

#if defined( __WXMSW__ )
FD_TD_NAME( Printer, WindowsPrinter );
FD_TD_NAME( PrintPreview, WindowsPrintPreview );
#else
FD_TD_NAME( Printer, PostScriptPrinter );
FD_TD_NAME( Printpreview, PostScriptPrintpreview );
#endif

#if defined( __WXMOTIF__ ) || defined( __WXGTK__ )
FD_TD_NAME( PageSetupDialog, GenericPageSetupDialog );
#else
FD_TD( PageSetupDialog );
#endif

#undef FD_TD

typedef int wxPaperQuality;

#endif
  // _WXPERL_PRINT_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //

