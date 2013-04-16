%module{Wx};

/////////////////////////////////////////////////////////////////////////////
// Name:        wx/commandlinkbutton.h
// Purpose:     interface of wxCommandLinkButton
// Author:      wxWidgets team
// SVN-ID:      $Id$
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////


#if WXPERL_W_VERSION_GE( 2, 9, 2 )

#include <wx/commandlinkbutton.h>

%loadplugin{build::Wx::XSP::Overload};

%name{Wx::CommandLinkButton} class wxCommandLinkButton : public %name{Wx::Button} wxButton
{
public:
    
    %name{newDefault} wxCommandLinkButton() %Overload
        %postcall{% wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};
        
    %name{newFull} wxCommandLinkButton(wxWindow* parent, wxWindowID id,
                        const wxString& mainLabel = wxEmptyString,
                        const wxString& note = wxEmptyString,
                        const wxPoint& pos = wxDefaultPosition,
                        const wxSize& size = wxDefaultSize,
                        long style = 0,
                        const wxValidator& validator = wxDefaultValidatorPtr,
                        const wxString& name = wxButtonNameStr) %Overload
        %postcall{% wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};
    
    bool Create(wxWindow* parent, wxWindowID id,
                const wxString& mainLabel = wxEmptyString,
                const wxString& note = wxEmptyString,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxValidator& validator = wxDefaultValidatorPtr,
                const wxString& name = wxButtonNameStr);
    
    void SetMainLabelAndNote(const wxString& mainLabel, const wxString& note);

    virtual void SetLabel(const wxString& label);

    wxString GetLabel() const;

    void SetMainLabel(const wxString& mainLabel);

    void SetNote(const wxString& note);

    wxString GetMainLabel() const;

    wxString GetNote() const;
};

#endif
