<div class="content-view-line class-{$node.class_identifier} media">

  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
    <h4 class="media-heading">
	  {if is_set( $node.url_alias )}
		<a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
	  {else}
		{$node.name|wash()}
	  {/if}
	</h4>	
    {if $node|has_abstract()}
	  {$node|abstract()}
	{/if}
  </div>
</div>
