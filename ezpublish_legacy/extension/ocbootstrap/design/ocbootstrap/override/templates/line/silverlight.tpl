<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  <a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
	</h4>
	
	<p><a class="btn btn-sm center-block" href={$node.url_alias|ezurl}>{"View movie"|i18n("design/ocbootstrap/line/silverlight")}</a></p>

    {if $node|has_abstract()}
      {$node|abstract()}
    {/if}

    </div>
</div>