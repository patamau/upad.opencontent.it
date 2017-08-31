{def $pagedata = ezpagedata()
     $pagestyle = $pagedata.css_classes
     $locales = fetch( 'content', 'translation_list' )
     $current_node_id = $pagedata.node_id}
ID,Nome,Cognome,Data di nascita,Email,Tessera,Scadenza,Annullato{'\r\n'}{$module_result.content}