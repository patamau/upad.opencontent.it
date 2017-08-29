{def $pagedata = ezpagedata()
     $pagestyle = $pagedata.css_classes
     $locales = fetch( 'content', 'translation_list' )
     $current_node_id = $pagedata.node_id}
ID,Nome,Cognome,Data di nascita,Tessera,Scadenza{'\r\n'}{$module_result.content}