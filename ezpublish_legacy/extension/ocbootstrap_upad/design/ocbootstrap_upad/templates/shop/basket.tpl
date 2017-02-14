{def $current_user=fetch( 'user', 'current_user' )
     $access=fetch( 'user', 'has_access_to',
                    hash( 'module',   'ocpurchasebyteller',
                          'function', 'buy' ) )}

<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                <ul class="">
                    <li class="f_size_large fw_medium scheme_color col-lg-4 col-md-4 col-sm-4">1. {"Shopping basket"|i18n("design/ocbootstrap/shop/basket")}</li>
                    <li class="col-lg-4 col-md-4 col-sm-4">2. {"Account information"|i18n("design/ocbootstrap/shop/basket")}</li>
                    <li class="col-lg-4 col-md-4 col-sm-4">3. {"Confirm order"|i18n("design/ocbootstrap/shop/basket")}</li>
                </ul>
            </div>

            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">{"Basket"|i18n("design/ocbootstrap/shop/basket")}</h2>
                <form method="post" action={"/shop/basket/"|ezurl}>

                    {section show=$removed_items}
                        <div class="alert_box r_corners warning m_bottom_10">
                            <i class="fa fa-exclamation-circle"></i>
                            <h2>{"The following items were removed from your basket because the products were changed."|i18n("design/ocbootstrap/shop/basket",,)}</h2>
                            <ul>
                            {section name=RemovedItem loop=$removed_items}
                                <li> <a href={concat("/content/view/full/",$RemovedItem:item.contentobject.main_node_id,"/")|ezurl}>{$RemovedItem:item.contentobject.name|wash}</a></li>
                            {/section}
                            </ul>
                        </div>
                    {/section}

                        {if not( $vat_is_known )}
                            <div class="alert_box r_corners warning m_bottom_10">
                                <i class="fa fa-exclamation-circle"></i>
                                <h2>{'VAT is unknown'|i18n( 'design/ocbootstrap/shop/basket' )}</h2>
                                {'VAT percentage is not yet known for some of the items being purchased.'|i18n( 'design/ocbootstrap/shop/basket' )}<br/>
                                {'This probably means that some information about you is not yet available and will be obtained during checkout.'|i18n( 'design/ocbootstrap/shop/basket' )}
                            </div>
                        {/if}

                        {section show=$error}
                            <div class="alert_box r_corners error m_bottom_10">
								<i class="fa fa-exclamation-triangle"></i>
                                {section show=$error|eq(1)}
                                    <h2>{"Attempted to add object without price to basket."|i18n("design/ocbootstrap/shop/basket",,)}</h2>
                                {/section}
                                {section show=eq($error, "aborted")}
                                    <h2>{"Your payment was aborted."|i18n("design/ocbootstrap/shop/basket",,)}</h2>
                                {/section}
                                {section show=eq($error, "ente")}
                                    <h2>Non puoi aggiungere al carrello corsi di enti diversi</h2>
                                {/section}
								{section show=eq($error, "noempty")}
                                    <h2>Puoi acquistate un solo corso alla volta!</h2>
                                {/section}
                            </div>
                        {/section}

                        {def $currency = fetch( 'shop', 'currency', hash( 'code', $basket.productcollection.currency_code ) )
                             $locale = false()
                             $symbol = false()}
                        {if $currency}
                            {set locale = $currency.locale
                                 symbol = $currency.symbol}
                        {/if}

                        {section name=Basket show=$basket.items}

                        <table class="table_type_4 responsive_table full_width r_corners wraper shadow t_align_l t_xs_align_c m_bottom_30">
							<thead>
								<tr class="f_size_large">
                                    <th>
                                    {"Count"|i18n("design/ocbootstrap/shop/basket")}
                                    </th>
                                    <th>
                                    {"VAT"|i18n("design/ocbootstrap/shop/basket")}
                                    </th>
                                    <th>
                                    {"Price inc. VAT"|i18n("design/ocbootstrap/shop/basket")}
                                    </th>
                                    <th>
                                    {"Discount"|i18n("design/ocbootstrap/shop/basket")}
                                    </th>
                                    <th>
                                    {"Total price ex. VAT"|i18n("design/ocbootstrap/shop/basket")}
                                    </th>
                                    <th>
                                    {"Total price inc. VAT"|i18n("design/ocbootstrap/shop/basket")}
                                    </th>
                                    <th>&nbsp;
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                        {section name=ProductItem loop=$basket.items sequence=array(bgdark, bglight)}
                            <tr class="bglight">
                                <td colspan="7"><input type="hidden" name="ProductItemIDList[]" value="{$Basket:ProductItem:item.id}" />
                                {*{$Basket:ProductItem:item.id}-*}
                                <a href={concat("/content/view/full/",$Basket:ProductItem:item.node_id,"/")|ezurl}>{$Basket:ProductItem:item.object_name}</a></td>
                            </tr>
                            <tr class="bgdark">
                                <td>
                                <input type="text" readonly="readonly" name="ProductItemCountList[]" value="{$Basket:ProductItem:item.item_count}" size="5" />
                                </td>
                                <td>
                                {if ne( $Basket:ProductItem:item.vat_value, -1 )}
                                    {$Basket:ProductItem:item.vat_value} %
                                {else}
                                    {'Unknown'|i18n( 'design/ocbootstrap/shop/basket' )}
                                {/if}
                                </td>
                                <td>
                                    {$Basket:ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                                <td>
                                    {$Basket:ProductItem:item.discount_percent}%
                                </td>
                                <td>
                                    {$Basket:ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                                <td class="f_size_large fw_medium scheme_color">
                                    {$Basket:ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                                <td>
                                    <input type="checkbox" name="RemoveProductItemDeleteList[]" id="d_{$Basket:ProductItem:item.id}" value="{$Basket:ProductItem:item.id}" />
                                </td>
                            </tr>
                            <tr class="bglight">
                                <td colspan="6"><input class="tr_delay_hover r_corners button_type_16 f_size_medium bg_dark_color bg_cs_hover color_light m_xs_bottom_5" type="submit" name="StoreChangesButton" value="{'Update'|i18n('design/ocbootstrap/shop/basket')}" /></td>
                                <td colspan="1"><input class="tr_delay_hover r_corners button_type_16 f_size_medium bg_scheme_color color_light m_xs_bottom_5" type="submit" name="RemoveProductItemButton" value="{'Remove'|i18n('design/ocbootstrap/shop/basket')}" /> </td>
                            </tr>
                            {section show=$Basket:ProductItem:item.item_object.option_list}
                                <tr>
                                    <td colspan="7" style="padding: 0;">
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td colspan="3">
                                                    {"Selected options"|i18n("design/ocbootstrap/shop/basket")}
                                                </td>
                                            </tr>
                                            {section name=Options loop=$Basket:ProductItem:item.item_object.option_list sequence=array(bglight, bgdark)}
                                                <tr>
                                                    <td width="33%">{$Basket:ProductItem:Options:item.name}</td>
                                                    <td width="33%">{$Basket:ProductItem:Options:item.value}</td>
                                                    <td width="33%">{$Basket:ProductItem:Options:item.price|l10n( 'currency', $locale, $symbol )}</td>
                                                </tr>
                                            {/section}
                                        </table>
                                    </td>
                                </tr>
                            {/section}
                        {/section}

                        <tr>
                             <td colspan="7">
                                <hr size='2' />
                             </td>
                        </tr>
                        <tr>
                             <td colspan="5"></td>
                             <td>
                                <strong>{"Subtotal ex. VAT"|i18n("design/ocbootstrap/shop/basket")}</strong>:
                             </td>
                             <td>
                                <strong>{"Subtotal inc. VAT"|i18n("design/ocbootstrap/shop/basket")}</strong>:
                             </td>
                        </tr>
                        <tr>
                            <td colspan="5"></td>
                            <td class="fw_medium f_size_large color_dark">
                                {$basket.total_ex_vat|l10n( 'currency', $locale, $symbol )}
                            </td>
                            <td class="f_size_large fw_medium scheme_color">
                                {$basket.total_inc_vat|l10n( 'currency', $locale, $symbol )}
                            </td>
                        </tr>
                        {if is_set( $shipping_info )}
                        {* Show shipping type/cost. *}
                        <tr>
                             <td colspan="5">
                             <a href={$shipping_info.management_link|ezurl}>{'Shipping'|i18n( 'design/ocbootstrap/shop/basket' )}{if $shipping_info.description} ({$shipping_info.description}){/if}</a>:
                             </td>
                             <td>
                             {$shipping_info.cost|l10n( 'currency', $locale, $symbol )}:
                             </td>
                             <td>
                             {$shipping_info.cost|l10n( 'currency', $locale, $symbol )}:
                             </td>
                        </tr>
                        {* Show order total *}
                        <tr>
                             <td colspan="5">
                                <strong>{'Order total'|i18n( 'design/ocbootstrap/shop/basket' )}</strong>:
                             </td>
                             <td>
                                <strong>{$total_inc_shipping_ex_vat|l10n( 'currency', $locale, $symbol )}</strong>
                             </td>
                             <td class="f_size_large fw_medium scheme_color">
                                <strong>{$total_inc_shipping_inc_vat|l10n( 'currency', $locale, $symbol )}</strong>
                             </td>
                        </tr>
                        {/if}
                        </tbody>
                        </table>

                        <div class="buttonblock">
                            <input class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" type="submit" name="ContinueShoppingButton" value="{'Continue shopping'|i18n('design/ocbootstrap/shop/basket')}" />
                            {if $access}
                                <a href={"ocpurchasebyteller/form"|ezurl} class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light f_right">Assegna corsi presenti nel carrello</a>
								<input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light f_right" type="submit" name="CheckoutButton" value="{'Checkout'|i18n('design/ocbootstrap/shop/basket')}" />
                            {else}
                                <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light f_right" type="submit" name="CheckoutButton" value="{'Checkout'|i18n('design/ocbootstrap/shop/basket')}" />
                            {/if}
                        </div>

                        {undef $currency $locale $symbol}

                    {section-else}
                        <div class="feedback">
                            <h2>{"You have no products in your basket."|i18n("design/ocbootstrap/shop/basket")}</h2>
                        </div>
                    {/section}
                </form>
            </div>
        </section>
    </div>
</div>
