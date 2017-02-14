<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  <a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
	  <small>{attribute_view_gui attribute=$node.data_map.product_number}</small>
	</h4>

    {if $node|has_abstract()}
      {$node|abstract()}
    {/if}
	
	<form method="post" action={"content/action"|ezurl}>
		<fieldset class="row">
			<div class="col-xs-6">
				{attribute_view_gui attribute=$node.data_map.additional_options}
			</div>
			<div class="col-xs-6">
				<div class="item-price">
					{attribute_view_gui attribute=$node.data_map.price}
				</div>
				<div class="item-buying-action form-inline">
					<label>
						<span class="hidden">{'Amount'|i18n("design/ocbootstrap/line/product")}</span>
						<input class="col-xs-1" type="text" name="Quantity" />
					</label>
					<button class="btn btn-warning" type="submit" name="ActionAddToBasket">
						{'Buy'|i18n("design/ocbootstrap/line/product")}
					</button>
				</div>
			</div>
		</fieldset>
		<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
		<input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
		<input type="hidden" name="ViewMode" value="full" />
	</form>

  </div>
</div>