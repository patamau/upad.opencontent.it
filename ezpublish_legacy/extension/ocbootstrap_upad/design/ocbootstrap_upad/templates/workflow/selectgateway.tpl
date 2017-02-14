<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                <h2 class="tt_uppercase color_dark m_bottom_25">Seleziona metodo di pagamento</h2>
                <form method="post" action={"shop/checkout"|ezurl} class="form-inline">
                    <ul class="list-unstyled">
                    {section name=Gateways loop=$event.selected_gateways}
                      <li>
                        <div class="checkbox">
                            <label>
                                <input type="radio" name="SelectedGateway" value="{$Gateways:item.value}"{run-once} checked="checked"{/run-once} /> {$Gateways:item.Name|wash}
                            </label>
                        </div>
                      </li>
                    {/section}
                    </ul>
                    <hr />
                    <div class="buttonblock">
                        <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light" type="submit" name="CancelButton"  value="{'Cancel'|i18n('design/standard/workflow')}" />
                        <input class="tr_delay_hover r_corners button_type_15 bg_dark_color color_light" type="submit" name="SelectButton"  value="{'Select'|i18n('design/standard/workflow')}" />
                    </div>
                </form>
            </div>
        </section>
    </div>
</div>
