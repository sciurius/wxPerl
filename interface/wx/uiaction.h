%module{Wx};

/////////////////////////////////////////////////////////////////////////////
// Name:        uiaction.h
// Purpose:     interface of wxUIActionSimulator
// Author:      wxWidgets team
// RCS-ID:      $Id$
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#if WXPERL_W_VERSION_GE( 2, 9, 2 )

#include <wx/uiaction.h>

%loadplugin{build::Wx::XSP::Overload};

%name{Wx::UIActionSimulator} class wxUIActionSimulator
{

%{
static void
wxUIActionSimulator::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );
%}

public:
   
    wxUIActionSimulator();
    
    ~wxUIActionSimulator()
        %code%{  wxPli_thread_sv_unregister( aTHX_ "Wx::UIActionSimulator", THIS, ST(0) );
                 delete THIS;
               %};

    %name{MouseMoveCoords} bool MouseMove(long x, long y) %Overload;

    %name{MouseMovePoint} bool MouseMove(const wxPoint& point) %Overload;

    bool MouseDown(int button = wxMOUSE_BTN_LEFT);

    bool MouseUp(int button = wxMOUSE_BTN_LEFT);

    bool MouseClick(int button = wxMOUSE_BTN_LEFT);

    bool MouseDblClick(int button = wxMOUSE_BTN_LEFT);

    bool MouseDragDrop(long x1, long y1, long x2, long y2, int button = wxMOUSE_BTN_LEFT);

    bool KeyDown(int keycode, int modifiers = wxMOD_NONE);

    bool KeyUp(int keycode, int modifiers = wxMOD_NONE);

    bool Char(int keycode, int modifiers = wxMOD_NONE);

    bool Text(const wxString& text);
};

#endif
