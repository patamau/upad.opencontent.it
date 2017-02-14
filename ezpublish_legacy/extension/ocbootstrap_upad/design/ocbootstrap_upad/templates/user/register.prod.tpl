{def $trat_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'TrattamentoDatiNodeID', 'content.ini' ) ) )}


<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                <h2 class="tt_uppercase color_dark m_bottom_25">{"Register user"|i18n("design/ocbootstrap/user/register")}</h2>
                <form enctype="multipart/form-data"  action={"/user/register/"|ezurl} method="post" name="Register" class="form-signin">

                    {if and( and( is_set( $checkErrNodeId ), $checkErrNodeId ), eq( $checkErrNodeId, true() ) )}
                        <div class="alert_box r_corners warning m_bottom_10">
                            <i class="fa fa-exclamation-circle"></i>
                            <h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {$errMsg}</h2>
                        </div>
                    {/if}

                    {if $validation.processed}
                        {if $validation.attributes|count|gt(0)}
                            <div class="alert_box r_corners warning m_bottom_10">
                                <i class="fa fa-exclamation-circle"></i>
                                <p><strong>{"Input did not validate"|i18n("design/ocbootstrap/user/register")}</strong></p>
                                <ul>
                                    {foreach $validation.attributes as $attribute}
                                        <li>{$attribute.name}: {$attribute.description}</li>
                                    {/foreach}
                                </ul>
                            </div>
                        {else}
                            <div class="alert_box r_corners color_green success m_bottom_10">
								<i class="fa fa-smile-o"></i>
                                <p><strong>{"Input was stored successfully"|i18n("design/ocbootstrap/user/register")}</strong></p>
                            </div>
                        {/if}
                    {/if}

                {if count($content_attributes)|gt(0)}
                    <div class="row">
                        <div class='col-lg-6 col-md-6 col-sm-6 '>
                            {foreach $content_attributes as $attribute max 5}
                                <div class='form-group m_bottom_15'>
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                    {attribute_edit_gui attribute=$attribute html_class="form-control" placeholder=$attribute.contentclass_attribute.name}
                                </div>
                            {/foreach}
                        </div>

                        <div class='col-lg-6 col-md-6 col-sm-6 '>
                            {foreach $content_attributes as $attribute offset 5 max 7}
                                <div class='form-group m_bottom_15'>
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                    {attribute_edit_gui attribute=$attribute html_class="form-control" placeholder=$attribute.contentclass_attribute.name}
                                </div>
                            {/foreach}
                        </div>
                    </div>

                    <div class="row">
                        <div class='col-lg-12 col-md-12 col-sm-12'>
                            <div class='form-group m_bottom_15'>
                                <label>Trattamento dei dati</label>
                                <textarea disabled="disabled" class="form-control" rows="10">{$trat_node.object.data_map.body.content.output.output_text|striptags|trim()}</textarea>
                            </div>
                            {foreach $content_attributes as $attribute offset 12}
                                <div class='form-group m_bottom_15'>
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                    {attribute_edit_gui attribute=$attribute html_class="form-control" placeholder=$attribute.contentclass_attribute.name}
                                </div>
                            {/foreach}
                        </div>
                    </div>

                    <div class="form-group m_bottom_15">
                        <input type="hidden" name="UserID" value="{$content_attributes[0].contentobject_id}" />
                        <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light" type="submit" id="CancelButton" name="CancelButton" value="{'Discard'|i18n('design/ocbootstrap/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
                        {if and( is_set( $checkErrNodeId ), $checkErrNodeId )|not()}
                            <input class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" type="submit" id="PublishButton" name="PublishButton" value="{'Register'|i18n('design/ocbootstrap/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
                        {else}
                            <input class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" type="submit" id="PublishButton" name="PublishButton" disabled="disabled" value="{'Register'|i18n('design/ocbootstrap/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
                        {/if}
                    </div>
                {else}
                    <div class="alert alert-danger">
                        <p>{"Unable to register new user"|i18n("design/ocbootstrap/user/register")}</p>
                    </div>
                    <input class="btn btn-primary" type="submit" id="CancelButton" name="CancelButton" value="{'Back'|i18n('design/ocbootstrap/user/register')}" onclick="window.setTimeout( disableButtons, 1 ); return true;" />
                {/if}
                </form>
            </div>
        </section>
    </div>
</div>

{literal}
<script type="text/javascript">
    function disableButtons()
    {
        document.getElementById( 'PublishButton' ).disabled = true;
        document.getElementById( 'CancelButton' ).disabled = true;
    }
</script>
{/literal}
