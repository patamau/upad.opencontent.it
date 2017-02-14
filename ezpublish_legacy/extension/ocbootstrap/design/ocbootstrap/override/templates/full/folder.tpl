<div class="content-view-full class-folder row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>      

    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
      {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}
	
	{if $node|has_attribute( 'tags' )}
    <div class="tags">
      {foreach $node.data_map.tags.content.keywords as $keyword}	  
		<span class="label label-primary">{$keyword}</span>	 
	  {/foreach}
    </div>
    {/if}
    
    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' )}    
	
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}	  
	
    {include uri='design:parts/children.tpl' view='line'}

  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>
