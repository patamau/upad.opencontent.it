{* Poll - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'intro' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'intro' )}
      </div>
    {/if}
    
    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' )}

    <form method="post" action={"content/action"|ezurl}>
      <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
      <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
      <input type="hidden" name="ViewMode" value="full" />

      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'question' )}
      </div>
      
      {if is_unset( $versionview_mode )}
        <input class="btn btn-primary btn-large" type="submit" name="ActionCollectInformation" value="{"Vote"|i18n("design/ocbootstrap/full/poll")}" />
      {/if}

    </form>

    <div class="attribute-link">
        <p><a href={concat( "/content/collectedinfo/", $node.node_id, "/" )|ezurl}>{"Result"|i18n("design/ocbootstrap/full/poll")}</a></p>
    </div>

  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>