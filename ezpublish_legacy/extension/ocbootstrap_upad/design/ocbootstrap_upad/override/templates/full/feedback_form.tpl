{* Feedback form - Full view *}
{def $trat_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'TrattamentoDatiNodeID', 'content.ini' ) ) )}
<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                <h2 class="tt_uppercase color_dark m_bottom_25">{$node.name|wash()}</h2>

                {if $node|has_attribute( 'description' )}
                  <div class="description">
                    {attribute_view_gui attribute=$node|attribute( 'description' )}
                  </div>
                {/if}

                {include name=Validation uri='design:content/collectedinfo_validation.tpl'
                         class='alert_box r_corners warning m_bottom_20'
                         validation=$validation collection_attributes=$collection_attributes}

                <form method="post" action={"content/action"|ezurl} role="form" class="form-inline">

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


                  <div class="row attribute-sender-first-name m_bottom_15">
                      <div class="col-md-4">
                          {$node.data_map.first_name.contentclass_attribute.name}
                      </div>
                      <div class="col-md-8">
                          {attribute_view_gui attribute=$node.data_map.first_name css_class='form-control'}
                      </div>
                  </div>

                  <div class="row attribute-sender-last-name m_bottom_15">
                      <div class="col-md-4">
                          {$node.data_map.last_name.contentclass_attribute.name}
                      </div>
                      <div class="col-md-8">
                          {attribute_view_gui attribute=$node.data_map.last_name css_class='form-control'}
                      </div>
                  </div>
                  <div class="row attribute-sender-email m_bottom_15">
                      <div class="col-md-4">
                          {$node.data_map.email.contentclass_attribute.name}
                      </div>
                      <div class="col-md-8">
                          {attribute_view_gui attribute=$node.data_map.email css_class='form-control'}
                      </div>
                  </div>
                  <div class="row attribute-sender-email m_bottom_15">
                      <div class="col-md-4">
                          {$node.data_map.phone.contentclass_attribute.name}
                      </div>
                      <div class="col-md-8">
                          {attribute_view_gui attribute=$node.data_map.phone css_class='form-control'}
                      </div>
                  </div>
                  <div class="row attribute-sender-subject m_bottom_15">
                      <div class="col-md-4">
                          {$node.data_map.subject.contentclass_attribute.name}
                      </div>
                      <div class="col-md-8">
                          {attribute_view_gui attribute=$node.data_map.subject css_class='form-control'}
                      </div>
                  </div>
                  <div class="row attribute-sender-message m_bottom_15">
                      <div class="col-md-4">
                          {$node.data_map.message.contentclass_attribute.name}
                      </div>
                      <div class="col-md-8">
                          {attribute_view_gui attribute=$node.data_map.message css_class='form-control'}
                      </div>
                  </div>
                  <div class="row attribute-sender-message m_bottom_15">
                        <div class="col-md-4">
                            <label>Trattamento dei dati</label>
                        </div>
                        <div class="col-md-8">
                            <textarea disabled="disabled" class="form-control" rows="5" cols="70">{$trat_node.object.data_map.body.content.output.output_text|striptags|trim()}</textarea>
                        </div>
                    </div>
                  <div class="row attribute-sender-subject m_bottom_15">
                      <div class="col-md-4">
                          {$node.data_map.trattamento_dati.contentclass_attribute.name}
                      </div>
                      <div class="col-md-8">
                          {attribute_view_gui attribute=$node.data_map.trattamento_dati css_class='form-control'}
                      </div>
                  </div>
                  <div class="row content-action">
                    <div class="col-md-12">
                      <input type="submit" class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" name="ActionCollectInformation" value="{"Send form"|i18n("design/ocbootstrap/full/feedback_form")}" />
                      <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                      <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                      <input type="hidden" name="ViewMode" value="full" />
                    </div>
                  </div>
                </form>
            </div>
        </section>
  </div>
</div>
