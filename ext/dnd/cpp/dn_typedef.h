////////////////////////////////////////////////////////////////////////////
// Name:        ext/dnd/cpp/dn_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     12/08/2001
// RCS-ID:      $Id: dn_typedef.h,v 1.4 2004/10/19 20:28:08 mbarbon Exp $
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_DND_TYPEDEF_H
#define _WXPERL_DND_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name;

#define FD_TD_NAME( name, cls ) \
  class wx##cls; \
  typedef wx##cls Wx_##name;

FD_TD( BitmapDataObject );
FD_TD( Clipboard );
FD_TD( CustomDataObject );
FD_TD( DataFormat );
FD_TD( DataObject );
FD_TD( DataObjectComposite );
FD_TD( DataObjectSimple );
FD_TD( DropFilesEvent );
FD_TD( DropSource );
// FD_TD( DropTarget );
FD_TD( FileDataObject );
FD_TD( FileDropTarget );
FD_TD( PlDataObjectSimple );
FD_TD( PlBitmapDataObject );
FD_TD( PlFileDataObject );
FD_TD( PlTextDataObject );
FD_TD( TextDataObject );
FD_TD( TextDropTarget );
FD_TD( URLDataObject );

#undef FD_TD

#endif
  // _WXPERL_DND_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //

