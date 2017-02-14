{set scope=global persistent_variable=hash('top_menu', false(),
                                           'show_path', false() )}

<div class="content-view-full class-{$node.class_identifier} row wide">
  
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}
    
    {include name=Validation uri='design:content/collectedinfo_validation.tpl'
             class='message-warning'
             validation=$validation collection_attributes=$collection_attributes}

             
    <form method="post" action={"content/action"|ezurl}>
      <div class="row attribute-sender-first-name">
          <div class="col-md-4">
              {$node.data_map.first_name.contentclass_attribute.name}
          </div>
          <div class="col-md-8">
              {attribute_view_gui attribute=$node.data_map.first_name}
          </div>
      </div>
      <div class="row attribute-sender-last-name">
          <div class="col-md-4">
              {$node.data_map.last_name.contentclass_attribute.name}
          </div>
          <div class="col-md-8">
              {attribute_view_gui attribute=$node.data_map.last_name}
          </div>
      </div>
      <div class="row attribute-sender-email">
          <div class="col-md-4">
              {$node.data_map.email.contentclass_attribute.name}
          </div>
          <div class="col-md-8">
              {attribute_view_gui attribute=$node.data_map.email}
          </div>
      </div>
      <div class="row attribute-sender-country">
          <div class="col-md-4">
              {$node.data_map.country.contentclass_attribute.name}
          </div>
          <div class="col-md-8">
              {attribute_view_gui attribute=$node.data_map.country}
          </div>
      </div>
      <div class="row attribute-sender-comment">
          <div class="col-md-4">
              {$node.data_map.comment.contentclass_attribute.name}
          </div>
          <div class="col-md-8">
              {attribute_view_gui attribute=$node.data_map.comment}
          </div>
      </div>
      <div class="row content-action">
        <div class="col-md-12">
          <input type="submit" class="btn btn-warning pull-right" name="ActionCollectInformation" value="{if $node.data_map.action_button_label.has_content}{$node.data_map.action_button_label.data_text|wash( xhtml )}{else}{"Submit"|i18n("design/ocbootstrap/full/call_to_action")}{/if}" />
          <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
          <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
          <input type="hidden" name="ViewMode" value="full" />
        </div>
      </div>
    </form>
	
  </div>
  
</div>