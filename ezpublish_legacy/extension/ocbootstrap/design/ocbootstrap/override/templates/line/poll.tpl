{set-block scope=root variable=cache_ttl}900{/set-block}

<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  <a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
	  <small>{"%count votes"|i18n( 'design/ocbootstrap/line/poll',, hash( '%count', fetch( content, collected_info_count, hash( object_id, $node.object.id ) ) ) )}</small>
	</h4>

    {if $node|has_abstract()}
      {$node|abstract()}
    {/if}
	
  	<p><a class="btn btn-primary center-block" href={$node.url_alias|ezurl}>{"Vote"|i18n("design/ocbootstrap/line/poll")}</a></p>
	

    </div>
</div>