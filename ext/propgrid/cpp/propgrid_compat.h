/***** 3.2 compatibility for 3.3 *****/

#if WXPERL_W_VERSION_LT( 3, 3, 0 )

/* Define missing enum classes as int and add value macros. */

#define wxPGKeyboardAction int

#define wxPGSelectPropertyFlags int
#define wxPGSelectPropertyFlags_Null 0

#define wxPGPropValFormatFlags int
#define wxPGPropValFormatFlags_Null 0
#define wxPGPropValFormatFlags_FullValue 1

#define wxPGSetValueFlags int
#define wxPGSetValueFlags_RefreshEditor 1

#define wxPGPropertyValuesFlags int
#define wxPGPropertyValuesFlags_DontRecurse 0
#define wxPGPropertyValuesFlags_Recurse 0x20

#define wxPGFlags wxPGPropertyFlags

#else

/* Add value macros. */

#define wxPGSelectPropertyFlags_Null        wxPGSelectPropertyFlags::Null
#define wxPGPropValFormatFlags_Null         wxPGPropValFormatFlags::Null
#define wxPGPropValFormatFlags_FullValue    wxPGPropValFormatFlags::FullValue
#define wxPGPropertyValuesFlags_DontRecurse wxPGPropertyValuesFlags::DontRecurse
#define wxPGPropertyValuesFlags_Recurse     wxPGPropertyValuesFlags::Recurse
#define wxPGSetValueFlags_RefreshEditor     wxPGSetValueFlags::RefreshEditor 

#endif
