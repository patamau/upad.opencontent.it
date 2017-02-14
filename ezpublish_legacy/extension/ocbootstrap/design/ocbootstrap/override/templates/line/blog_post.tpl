<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  <a href={$node.url_alias|ezurl}>{$node.name|wash()}</a>	  
	  <span class="label label-primary">
		<span class="glyphicon glyphicon-comment"></span>
		{fetch( 'comment', 'comment_count', hash( 'contentobject_id', $node.contentobject_id,
												  'language_id', $node.data_map.comments.language_id,
												  'status', '1' ) )}		  
	  </span>      
	  <small class="date">{$node.object.published|l10n( 'date' )}
	  {if $node.data_map.author.content.is_empty|not()}
         {attribute_view_gui attribute=$node.data_map.author}
	  {/if}
	  </small>
	</h4>

	{if $node.data_map.body.content.is_empty|not}
	 {attribute_view_gui attribute=$node.data_map.body}
	{/if}
	
		
	{foreach $node.data_map.tags.content.keywords as $keyword}
	  <a href={concat( $node.parent.url_alias, "/(tag)/", $keyword|rawurlencode )|ezurl} title="{$keyword}">
		<span class="label label-primary">{$keyword}</span>
	  </a>	
	{/foreach}

  </div>
</div>