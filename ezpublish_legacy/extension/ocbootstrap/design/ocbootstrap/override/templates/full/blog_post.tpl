{* Blog post - Full view *}
<div class="content-view-full class-{$node.class_identifier} row full-stack"> 
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>      
      {$node.name|wash()}
      <small>{$node.parent.name|wash()}</small>
    </h1>
    
    <div class="info">
      {include uri='design:parts/date.tpl'}    
      {include uri='design:parts/author.tpl'}
    </div>
    
    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' )}
	
    {if $node|has_attribute( 'body' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'body' )}
      </div>
    {/if}	  
	
    {if $node|has_attribute( 'tags' )}
      <div class="tags">
        {foreach $node.data_map.tags.content.keywords as $keyword}
		  <a href={concat( $node.parent.url_alias, "/(tag)/", $keyword|rawurlencode )|ezurl} title="{$keyword}">
			<span class="label label-primary">{$keyword}</span>
		  </a>	
		{/foreach}
      </div>
    {/if}
    
    {include uri='design:parts/social_buttons.tpl'}
    
    {if $node|has_attribute( 'comments' )}
      <div class="comments">
        {attribute_view_gui attribute=$node|attribute( 'comments' )}
      </div>
    {/if}

  </div>
    
  {include uri='design:parts/blog/content-related.tpl' used_node=$node.parent}

</div>
