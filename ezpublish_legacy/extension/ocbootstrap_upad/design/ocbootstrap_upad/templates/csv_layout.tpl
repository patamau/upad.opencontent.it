{def $pagedata = ezpagedata()
     $pagestyle = $pagedata.css_classes
     $locales = fetch( 'content', 'translation_list' )
     $current_node_id = $pagedata.node_id}

{$module_result.content}