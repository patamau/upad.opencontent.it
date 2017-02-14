{* Feedback form - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
  
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

    <form method="post" action={"content/action"|ezurl} role="form">

      {* TODO: ricondurre ai form bootstrap --> override di content/datatype/collect
      <div class="form-group attribute-sender-first-name">
        <label>{$node.data_map.first_name.contentclass_attribute.name}</label>
        {attribute_view_gui attribute=$node.data_map.first_name}
      </div>
      <div class="form-group attribute-sender-last-name">
        <label>{$node.data_map.last_name.contentclass_attribute.name}</label>
        {attribute_view_gui attribute=$node.data_map.last_name}
      </div>
      <div class="form-group attribute-sender-email">
        <label>{$node.data_map.email.contentclass_attribute.name}</label>
        {attribute_view_gui attribute=$node.data_map.email html_class="form-control"}
      </div>
      <div class="form-group attribute-sender-country">
        <label>{$node.data_map.country.contentclass_attribute.name}</label>
        {attribute_view_gui attribute=$node.data_map.country}
      </div>
      <div class="form-group attribute-sender-subject">
        <label>{$node.data_map.subject.contentclass_attribute.name}</label>
        {attribute_view_gui attribute=$node.data_map.subject}
      </div>
      <div class="form-group attribute-sender-message">
        <label>{$node.data_map.message.contentclass_attribute.name}</label>
        {attribute_view_gui attribute=$node.data_map.message}
      </div>
      <div class="content-action">
        <input type="submit" class="btn btn-warning pull-right" name="ActionCollectInformation" value="{"Send form"|i18n("design/ocbootstrap/full/feedback_form")}" />
        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
        <input type="hidden" name="ViewMode" value="full" />
      </div>
      *}


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
      <div class="row attribute-sender-subject">
          <div class="col-md-4">
              {$node.data_map.subject.contentclass_attribute.name}
          </div>
          <div class="col-md-8">
              {attribute_view_gui attribute=$node.data_map.subject}
          </div>
      </div>
      <div class="row attribute-sender-message">
          <div class="col-md-4">
              {$node.data_map.message.contentclass_attribute.name}
          </div>
          <div class="col-md-8">
              {attribute_view_gui attribute=$node.data_map.message}
          </div>
      </div>
      <div class="row content-action">
        <div class="col-md-12">
          <input type="submit" class="btn btn-warning pull-right" name="ActionCollectInformation" value="{"Send form"|i18n("design/ocbootstrap/full/feedback_form")}" />
          <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
          <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
          <input type="hidden" name="ViewMode" value="full" />
        </div>
      </div>
    </form>
	
  </div>
  
</div>

