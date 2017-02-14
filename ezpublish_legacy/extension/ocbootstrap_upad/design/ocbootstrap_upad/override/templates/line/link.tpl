<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
    <a href="{$node.data_map.location.content}" target="_blank">
      {$node.name|wash} <i class="fa fa-external-link"></i>
    </a>
	  <div class="pull-right">
		{include uri='design:parts/toolbar/node_toolbar.tpl' current_node=$node}
	  </div>
	</h4>
	{if $node.data_map.description.content.is_empty|not}
	 {attribute_view_gui attribute=$node.data_map.description}
	{/if}	 
  </div>
</div>