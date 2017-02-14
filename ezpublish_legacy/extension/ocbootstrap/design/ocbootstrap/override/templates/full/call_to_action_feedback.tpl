{set scope=global persistent_variable=hash('top_menu', false(),
                                           'show_path', false() )}

<div class="content-view-full class-{$node.class_identifier} row wide">
  
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}	  
	
  </div>
  
</div>
