<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  <a href={$node.url_alias|ezurl}>{$node.name|wash()}</a>	  	  
	  <small class="date">
		{$node.object.data_map.from_time.content.timestamp|l10n( 'shortdatetime' )} - {$node.object.data_map.to_time.content.timestamp|l10n( 'shortdatetime' )}
	  </small>
	</h4>

	{if $node|has_abstract()}
	  <p>{$node|abstract()|oc_shorten(100)}</p>
	{/if}

  </div>
</div>