<div class="panel panel-default class-{$node.class_identifier}">
  <div class="panel-heading">
	{if is_set( $node.url_alias )}
	  <h3 class="panel-title"><a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
	{else}
	  <h3 class="panel-title">{$node.name|wash()}</h3>
	{/if}
  </div>
  <div class="panel-body">
    {attribute_view_gui attribute=$node|attribute( 'image' ) image_class='medium'}
	{$node|abstract()}
  </div>
</div>