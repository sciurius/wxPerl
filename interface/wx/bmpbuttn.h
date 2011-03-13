%module{Wx};

/////////////////////////////////////////////////////////////////////////////
// Name:        bmpbuttn.h
// Purpose:     interface of wxBitmapButton
// Author:      wxWidgets team
// RCS-ID:      $Id$
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#include <wx/bmpbuttn.h>

%loadplugin{build::Wx::XSP::Overload};

/**
    @class wxBitmapButton

    A bitmap button is a control that contains a bitmap.

    Notice that since wxWidgets 2.9.1 bitmap display is supported by the base
    wxButton class itself and the only tiny advantage of using this class is
    that it allows to specify the bitmap in its constructor, unlike wxButton.
    Please see the base class documentation for more information about images
    support in wxButton.

    @beginStyleTable
    @style{wxBU_LEFT}
           Left-justifies the bitmap label.
    @style{wxBU_TOP}
           Aligns the bitmap label to the top of the button.
    @style{wxBU_RIGHT}
           Right-justifies the bitmap label.
    @style{wxBU_BOTTOM}
           Aligns the bitmap label to the bottom of the button.
    @endStyleTable

    Note that the wxBU_EXACTFIT style supported by wxButton is not used by this
    class as bitmap buttons don't have any minimal standard size by default.

    @beginEventEmissionTable{wxCommandEvent}
    @event{EVT_BUTTON(id, func)}
           Process a @c wxEVT_COMMAND_BUTTON_CLICKED event, when the button is clicked.
    @endEventTable

    @library{wxcore}
    @category{ctrl}
    @appearance{bitmapbutton.png}

    @see wxButton
*/
%name{Wx::BitmapButton} class wxBitmapButton : public %name{Wx::Button} wxButton
{
public:
    /**
        Default ctor.
    */
    %name{newDefault} wxBitmapButton() %Overload
        %postcall{% wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};

    /**
        Constructor, creating and showing a button.

        @param parent
            Parent window. Must not be @NULL.
        @param id
            Button identifier. The value wxID_ANY indicates a default value.
        @param bitmap
            Bitmap to be displayed.
        @param pos
            Button position.
            If ::wxDefaultPosition is specified then a default position is chosen.
        @param size
            Button size. 
            If ::wxDefaultSize is specified then the button is sized appropriately 
            for the bitmap.
        @param style
            Window style. See wxBitmapButton.
        @param validator
            Window validator.
        @param name
            Window name.

        @remarks The bitmap parameter is normally the only bitmap you need to provide,
                 and wxWidgets will draw the button correctly in its different states.
                 If you want more control, call any of the functions SetBitmapPressed(),
                 SetBitmapFocus(), SetBitmapDisabled().

        @see Create(), wxValidator
    */
    %name{newFull}
    wxBitmapButton(wxWindow* parent, wxWindowID id,
                   const wxBitmap& bitmap,
                   const wxPoint& pos = wxDefaultPosition,
                   const wxSize& size = wxDefaultSize,
                   long style = wxBU_AUTODRAW,
                   const wxValidator& validator = wxDefaultValidatorPtr,
                   const wxString& name = wxButtonNameStr) %Overload
        %postcall{% wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};

    /**
        Button creation function for two-step creation.
        For more details, see wxBitmapButton().
    */
    bool Create(wxWindow* parent, wxWindowID id,
                const wxBitmap& bitmap,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = wxBU_AUTODRAW,
                const wxValidator& validator = wxDefaultValidatorPtr,
                const wxString& name = wxButtonNameStr);

    //@{
    /**
        Returns the bitmap for the disabled state, which may be invalid.

        @return A reference to the disabled state bitmap.

        @see SetBitmapDisabled()
    */
    const wxBitmap& GetBitmapDisabled() const;
    // wxBitmap& GetBitmapDisabled(); TODO add %Skip annotation
    //@}

    //@{
    /**
        Returns the bitmap for the focused state, which may be invalid.

        @return A reference to the focused state bitmap.

        @see SetBitmapFocus()
    */
    const wxBitmap& GetBitmapFocus() const;
    // wxBitmap& GetBitmapFocus(); TODO add %Skip annotation
    //@}

#if WXPERL_W_VERSION_GE( 2, 7, 0 )
    //@{
    /**
        Returns the bitmap used when the mouse is over the button, which may be invalid.

        @see SetBitmapHover()
    */
    const wxBitmap& GetBitmapHover() const;
    // wxBitmap& GetBitmapHover(); TODO add %Skip annotation
    //@}
#endif

    //@{
    /**
        Returns the label bitmap (the one passed to the constructor), always valid.

        @return A reference to the button's label bitmap.

        @see SetBitmapLabel()
    */
    const wxBitmap& GetBitmapLabel() const;
    // wxBitmap& GetBitmapLabel(); TODO add %Skip annotation
    //@}

    /**
        Returns the bitmap for the selected state.

        @return A reference to the selected state bitmap.

        @see SetBitmapSelected()
    */
    const wxBitmap& GetBitmapSelected() const;

    /**
        Sets the bitmap for the disabled button appearance.

        @param bitmap
            The bitmap to set.

        @see GetBitmapDisabled(), SetBitmapLabel(),
             SetBitmapSelected(), SetBitmapFocus()
    */
    virtual void SetBitmapDisabled(const wxBitmap& bitmap);

    /**
        Sets the bitmap for the button appearance when it has the keyboard focus.

        @param bitmap
            The bitmap to set.

        @see GetBitmapFocus(), SetBitmapLabel(),
             SetBitmapSelected(), SetBitmapDisabled()
    */
    virtual void SetBitmapFocus(const wxBitmap& bitmap);

#if WXPERL_W_VERSION_GE( 2, 7, 0 )
    /**
        Sets the bitmap to be shown when the mouse is over the button.

        @since 2.7.0

        The hover bitmap is currently only supported in wxMSW.

        @see GetBitmapHover()
    */
    virtual void SetBitmapHover(const wxBitmap& bitmap);
#endif

    /**
        Sets the bitmap label for the button.

        @param bitmap
            The bitmap label to set.

        @remarks This is the bitmap used for the unselected state, and for all
                 other states if no other bitmaps are provided.

        @see GetBitmapLabel()
    */
    virtual void SetBitmapLabel(const wxBitmap& bitmap);

    /**
        Sets the bitmap for the selected (depressed) button appearance.

        @param bitmap
            The bitmap to set.
    */
    virtual void SetBitmapSelected(const wxBitmap& bitmap);
};

