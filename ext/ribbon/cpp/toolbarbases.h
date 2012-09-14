/////////////////////////////////////////////////////////////////////////////
// Name:        ribbongalleryitem.h
// Purpose:     wxRibbonGalleryItem declaration
// Author:      Mark Dootson
// SVN ID:      $Id:  $
// Copyright:   (c) 2012 Mattia barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////
//
// Declaration for these classes is in source CPP files so we need a
// declaration here. It is horrible and means we have to review every
// wxWidgets release.
//
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_RIBBON_BUTTON_TOOL_BASES_H_
#define _WXPERL_RIBBON_BUTTON_TOOL_BASES_H_

class wxRibbonButtonBarButtonSizeInfo
{
public:
    bool is_supported;
    wxSize size;
    wxRect normal_region;
    wxRect dropdown_region;
};

class wxRibbonButtonBarButtonInstance
{
public:
    wxPoint position;
    wxRibbonButtonBarButtonBase* base;
    wxRibbonButtonBarButtonState size;
};

class wxRibbonToolBarToolBase
{
public:
    wxString help_string;
    wxBitmap bitmap;
    wxBitmap bitmap_disabled;
    wxRect dropdown;
    wxPoint position;
    wxSize size;
    wxObject* client_data;
    int id;
    wxRibbonButtonKind kind;
    long state;
};

class wxRibbonButtonBarButtonBase
{
public:
    wxRibbonButtonBarButtonInstance NewInstance()
    {
        wxRibbonButtonBarButtonInstance i;
        i.base = this;
        return i;
    }

    wxRibbonButtonBarButtonState GetLargestSize()
    {
        if(sizes[wxRIBBON_BUTTONBAR_BUTTON_LARGE].is_supported)
            return wxRIBBON_BUTTONBAR_BUTTON_LARGE;
        if(sizes[wxRIBBON_BUTTONBAR_BUTTON_MEDIUM].is_supported)
            return wxRIBBON_BUTTONBAR_BUTTON_MEDIUM;
        wxASSERT(sizes[wxRIBBON_BUTTONBAR_BUTTON_SMALL].is_supported);
        return wxRIBBON_BUTTONBAR_BUTTON_SMALL;
    }

    bool GetSmallerSize(
        wxRibbonButtonBarButtonState* size, int n = 1)
    {
        for(; n > 0; --n)
        {
            switch(*size)
            {
            case wxRIBBON_BUTTONBAR_BUTTON_LARGE:
                if(sizes[wxRIBBON_BUTTONBAR_BUTTON_MEDIUM].is_supported)
                {
                    *size = wxRIBBON_BUTTONBAR_BUTTON_MEDIUM;
                    break;
                }
            case wxRIBBON_BUTTONBAR_BUTTON_MEDIUM:
                if(sizes[wxRIBBON_BUTTONBAR_BUTTON_SMALL].is_supported)
                {
                    *size = wxRIBBON_BUTTONBAR_BUTTON_SMALL;
                    break;
                }
            case wxRIBBON_BUTTONBAR_BUTTON_SMALL:
            default:
                return false;
            }
        }
        return true;
    }

    wxString label;
    wxString help_string;
    wxBitmap bitmap_large;
    wxBitmap bitmap_large_disabled;
    wxBitmap bitmap_small;
    wxBitmap bitmap_small_disabled;
    wxRibbonButtonBarButtonSizeInfo sizes[3];
    wxObject* client_data;
    int id;
    wxRibbonButtonKind kind;
    long state;
};

WX_DEFINE_ARRAY_PTR(wxRibbonToolBarToolBase*, wxArrayRibbonToolBarToolBase);

class wxRibbonToolBarToolGroup
{
public:
    // To identify the group as a wxRibbonToolBarToolBase*
    wxRibbonToolBarToolBase dummy_tool;

    wxArrayRibbonToolBarToolBase tools;
    wxPoint position;
    wxSize size;
};


#endif


