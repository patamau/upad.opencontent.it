{* Gallery - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'intro' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}
    
    {if fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                              'class_filter_type', 'include',
                                              'class_filter_array', array( 'image', 'video' ) ) )}
                                              
      {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                       'class_filter_type', 'include',
                                                       'class_filter_array', array( 'image', 'video' ),
                                                       'sort_by', $node.sort_array ) )}
      
      {include uri='design:atoms/gallery.tpl' items=$children}
    {/if}
	
    {if $node|has_attribute( 'body' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}	  

  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>