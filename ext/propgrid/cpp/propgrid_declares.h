#if wxUSE_DATEPICKCTRL

class wxPGDatePickerCtrlEditor : public wxPGEditor
{
    DECLARE_DYNAMIC_CLASS(wxPGDatePickerCtrlEditor)
public:
    
    virtual ~wxPGDatePickerCtrlEditor();

    wxString GetName() const;
    virtual wxPGWindowList CreateControls(wxPropertyGrid* propgrid,
                                          wxPGProperty* property,
                                          const wxPoint& pos,
                                          const wxSize& size) const;
    virtual void UpdateControl( wxPGProperty* property, wxWindow* wnd ) const;
    virtual bool OnEvent( wxPropertyGrid* propgrid, wxPGProperty* property,
        wxWindow* wnd, wxEvent& event ) const;
    virtual bool GetValueFromControl( wxVariant& variant, wxPGProperty* property, wxWindow* wnd ) const;
    virtual void SetValueToUnspecified( wxPGProperty* WXUNUSED(property), wxWindow* wnd ) const;
};

#endif // wxUSE_DATEPICKCTRL
