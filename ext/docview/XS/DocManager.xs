#############################################################################
## Name:        ext/docview/XS/DocManager.xs
## Purpose:     XS for wxDocument ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: DocManager.xs,v 1.12 2004/12/21 21:12:49 mbarbon Exp $
## Copyright:   (c) 2002-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################


MODULE=Wx PACKAGE=Wx::DocManager

wxDocManager*
wxDocManager::new( flags = wxDEFAULT_DOCMAN_FLAGS, initialize = true )
    long flags
    bool initialize
  CODE:
    RETVAL=new wxPliDocManager(CLASS, flags, initialize);
  OUTPUT:
    RETVAL

bool
wxDocManager::Clear( force )
    bool force

bool
wxDocManager::Initialize()

wxFileHistory*
wxDocManager::OnCreateFileHistory()

wxFileHistory*
wxDocManager::GetFileHistory()

void
wxDocManager::SetMaxDocsOpen(n)
    int n

int
wxDocManager::GetMaxDocsOpen()

SV*
wxDocManager::GetDocuments()
  CODE:
    AV* arrDocs = wxPli_objlist_2_av( aTHX_ THIS->GetDocuments() );
    RETVAL = newRV_noinc( (SV*)arrDocs  );
  OUTPUT: RETVAL

void
wxDocManager::GetTemplates()
  PPCODE:
    wxNode* tmplnode;
    const wxList& tmpllist = THIS->GetTemplates();

    EXTEND( SP, tmpllist.GetCount() );

    for( tmplnode = tmpllist.GetFirst(); tmplnode;
         tmplnode = tmplnode->GetNext() )
    {
       SV* pltmpl
           = wxPli_object_2_sv( aTHX_ sv_newmortal(), tmplnode->GetData() ); 
       PUSHs( pltmpl );
    } 

wxString
wxDocManager::GetLastDirectory()

void
wxDocManager::SetLastDirectory( dir )
    wxString dir

void
wxDocManager::OnFileClose( event )
    wxCommandEvent* event
  CODE:
    THIS->OnFileClose( *event );

void
wxDocManager::OnFileCloseAll( event )
    wxCommandEvent* event
  CODE:
    THIS->OnFileCloseAll( *event );

void
wxDocManager::OnFileNew( event )
    wxCommandEvent* event
  CODE:
    THIS->OnFileNew( *event );

void
wxDocManager::OnFileOpen( event )
    wxCommandEvent* event
  CODE:
    THIS->OnFileOpen( *event );

void
wxDocManager::OnFileRevert( event )
    wxCommandEvent* event
  CODE:
    THIS->OnFileRevert( *event );

void
wxDocManager::OnFileSave( event )
    wxCommandEvent* event
  CODE:
    THIS->OnFileSave( *event );

void
wxDocManager::OnFileSaveAs( event )
    wxCommandEvent* event
  CODE:
    THIS->OnFileSaveAs( *event );

void
wxDocManager::OnPrint( event )
    wxCommandEvent* event
  CODE:
    THIS->OnPrint( *event );

#if WXPERL_W_VERSION_LE( 2, 5, 2 )

void
wxDocManager::OnPrintSetup( event )
    wxCommandEvent* event
  CODE:
    THIS->OnPrintSetup( *event );

#endif

void
wxDocManager::OnPreview( event )
    wxCommandEvent* event
  CODE:
    THIS->OnPreview( *event );

void
wxDocManager::OnUndo( event )
    wxCommandEvent* event
  CODE:
    THIS->OnUndo( *event );

void
wxDocManager::OnRedo( event )
    wxCommandEvent* event
  CODE:
    THIS->OnRedo( *event );

void
wxDocManager::OnUpdateFileOpen( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileOpen( *event );

void
wxDocManager::OnUpdateFileClose( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileClose( *event );

void
wxDocManager::OnUpdateFileRevert( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileRevert( *event );

void
wxDocManager::OnUpdateFileNew( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileNew( *event );

void
wxDocManager::OnUpdateFileSave( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileSave( *event );

void
wxDocManager::OnUpdateFileSaveAs( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileSaveAs( *event );

void
wxDocManager::OnUpdateUndo( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateUndo( *event );

void
wxDocManager::OnUpdateRedo( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdateRedo( *event );

void
wxDocManager::OnUpdatePrint( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdatePrint( *event );

#if WXPERL_W_VERSION_LE( 2, 5, 2 )

void
wxDocManager::OnUpdatePrintSetup( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdatePrintSetup( *event );

#endif

void
wxDocManager::OnUpdatePreview( event )
    wxUpdateUIEvent* event
  CODE:
    THIS->OnUpdatePreview( *event );

wxView *
wxDocManager::GetCurrentView()

wxDocument *
wxDocManager::CreateDocument( path, flags = 0 )
    wxString path
    long flags


wxView *
wxDocManager::CreateView( doc, flags = 0 )
    wxDocument* doc
    long flags

void
wxDocManager::DeleteTemplate( temp, flags = 0 )
    wxDocTemplate* temp
    long flags

bool
wxDocManager::FlushDoc( doc )
    wxDocument* doc

wxDocument *
wxDocManager::GetCurrentDocument()

bool
wxDocManager::MakeDefaultName( name )
    wxString name

wxString
wxDocManager::MakeFrameTitle( doc )
    wxDocument* doc

wxDocTemplate *
wxDocManager::MatchTemplate( path )
    wxString path

void
wxDocManager::AddFileToHistory( file )
    wxString file

void
wxDocManager::RemoveFileFromHistory( i )
    int i


wxString
wxDocManager::GetHistoryFile( i )
    int i

void
wxDocManager::FileHistoryUseMenu( menu )
    wxMenu* menu

void
wxDocManager::FileHistoryRemoveMenu( menu )
    wxMenu* menu


#if wxUSE_CONFIG

## Need wxConfigBase& in typemap

##void
##wxDocManager::FileHistoryLoad( config )
##    wxConfigBase config
##  CODE:
##    THIS->FileHistoryLoad( config )
##
##void
##wxDocManager::FileHistorySave( config )
##    wxConfigBase config
##  CODE:
##    THIS->FileHistoryLoad( config )

#endif

void
wxDocManager::FileHistoryAddFilesToMenu( ... )
  CASE: items == 1
    CODE:
      THIS->FileHistoryAddFilesToMenu();
  CASE: items == 2
    INPUT:
      wxMenu* menu = NO_INIT
    CODE:
      THIS->FileHistoryAddFilesToMenu( menu );
  CASE:
    CODE:
      croak( "Usage: Wx::FileHistory::AddfilesToMenu(THIS [, menu ] )" );

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

size_t
wxDocManager::GetHistoryFilesCount()

#else

int
wxDocManager::GetNoHistoryFiles()

#endif

wxDocTemplate *
wxDocManager::FindTemplateForPath( path )
    wxString path

wxDocTemplate *
wxDocManager::SelectDocumentPath( templates, noTemplates, path, flags, save = false)
    AV* templates
    int noTemplates
    wxString path
    long flags
    bool save
  PREINIT:
    int tmpl_n;
    int i;
    wxDocTemplate **pltemplates;
    wxDocTemplate *thistemplate;
  CODE:
    tmpl_n = av_len(templates) + 1;
    pltemplates = new wxDocTemplate *[ tmpl_n ];
    for(i = 0; i < tmpl_n; i++)
    {
      SV** pltemplate = av_fetch( (AV*) templates, i, 0 );
      wxDocTemplate* thistemplate = (wxDocTemplate *)
                      wxPli_sv_2_object( aTHX_ *pltemplate, "Wx::DocTemplate" );
      pltemplates[i] = thistemplate;
    }
    RETVAL = THIS->SelectDocumentPath(pltemplates, noTemplates, path, flags, save);
    delete[] pltemplates;
  OUTPUT:
    RETVAL

wxDocTemplate *
wxDocManager::SelectDocumentType( templates, noTemplates, sort = false)
    AV* templates
    int noTemplates
    bool sort
  PREINIT:
    int tmpl_n;
    int i;
    wxDocTemplate **pltemplates;
    wxDocTemplate *thistemplate;
  CODE:
    tmpl_n = av_len(templates) + 1;
    pltemplates = new wxDocTemplate *[ tmpl_n ];
    for(i = 0; i < tmpl_n; i++)
    {
      SV** pltemplate = av_fetch( (AV*) templates, i, 0 );
      wxDocTemplate* thistemplate = (wxDocTemplate *)
                      wxPli_sv_2_object( aTHX_ *pltemplate, "Wx::DocTemplate" );
      pltemplates[i] = thistemplate;
    }
    RETVAL = THIS->SelectDocumentType(pltemplates, noTemplates, sort);
    delete[] pltemplates;
  OUTPUT:
    RETVAL



wxDocTemplate *
wxDocManager::SelectViewType( templates, noTemplates, sort = false)
    AV* templates
    int noTemplates
    bool sort
  PREINIT:
    int tmpl_n;
    int i;
    wxDocTemplate **pltemplates;
    wxDocTemplate *thistemplate;
  CODE:
    tmpl_n = av_len(templates) + 1;
    pltemplates = new wxDocTemplate *[ tmpl_n ];
    for(i = 0; i < tmpl_n; i++)
    {
      SV** pltemplate = av_fetch( (AV*) templates, i, 0 );
      wxDocTemplate* thistemplate = (wxDocTemplate *)
                      wxPli_sv_2_object( aTHX_ *pltemplate, "Wx::DocTemplate" );
      pltemplates[i] = thistemplate;
    }
    RETVAL = THIS->SelectViewType(pltemplates, noTemplates, sort);
    delete[] pltemplates;
  OUTPUT:
    RETVAL

void
wxDocManager::AssociateTemplate( temp )
    wxDocTemplate* temp

void
wxDocManager::DisassociateTemplate( temp )
    wxDocTemplate* temp

void
wxDocManager::AddDocument( doc )
    wxDocument* doc

void
wxDocManager::RemoveDocument( doc )
    wxDocument* doc

bool
wxDocManager::CloseDocuments( force = true )
    bool force

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxDocManager::ActivateView( view, activate = true )
    wxView* view
    bool activate

#else

void
wxDocManager::ActivateView( view, activate = true, deleting = false )
    wxView* view
    bool activate
    bool deleting

#endif