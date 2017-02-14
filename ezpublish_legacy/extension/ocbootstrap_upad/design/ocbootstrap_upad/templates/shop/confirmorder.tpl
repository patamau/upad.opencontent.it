<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                <ul class="">
                    <li class="col-lg-4 col-md-4 col-sm-4">1. {"Shopping basket"|i18n("design/ocbootstrap/shop/basket")}</li>
                    <li class="col-lg-4 col-md-4 col-sm-4">2. {"Account information"|i18n("design/ocbootstrap/shop/basket")}</li>
                    <li class="f_size_large fw_medium scheme_color col-lg-4 col-md-4 col-sm-4">3. {"Confirm order"|i18n("design/ocbootstrap/shop/basket")}</li>
                </ul>
            </div>

            <div class=" clearfix">
                <form method="post" action={"/shop/confirmorder/"|ezurl}>
                    <h2 class="tt_uppercase color_dark m_bottom_25">{"Confirm order"|i18n("design/ocbootstrap/shop/confirmorder")}</h2>

                {shop_account_view_gui view=html order=$order}

                {def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
                     $locale = false()
                     $symbol = false()}

                {if $currency}
                    {set locale = $currency.locale
                         symbol = $currency.symbol}
                {/if}

                <h3 class="tt_uppercase color_dark m_bottom_25">{"Product items"|i18n("design/ocbootstrap/shop/confirmorder")}</h3>
                <table class="table_type_4 responsive_table full_width r_corners wraper shadow t_align_l t_xs_align_c m_bottom_30">
                    <thead>
                        <tr class="f_size_large">
                            <th>
                            {"Count"|i18n("design/ocbootstrap/shop/confirmorder")}
                            </th>
                            <th>
                            {"VAT"|i18n("design/ocbootstrap/shop/confirmorder")}
                            </th>
                            <th>
                            {"Price inc. VAT"|i18n("design/ocbootstrap/shop/confirmorder")}
                            </th>
                            <th>
                            {"Discount"|i18n("design/ocbootstrap/shop/confirmorder")}
                            </th>
                            <th>
                            {"Total price ex. VAT"|i18n("design/ocbootstrap/shop/confirmorder")}
                            </th>
                            <th>
                            {"Total price inc. VAT"|i18n("design/ocbootstrap/shop/confirmorder")}
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {section name=ProductItem loop=$order.product_items show=$order.product_items sequence=array(bglight,bgdark)}
                        <tr class="bglight">
                            <td colspan="6">    <input type="hidden" name="ProductItemIDList[]" value="{$ProductItem:item.id}" />
                            <a href={concat("/content/view/full/",$ProductItem:item.node_id,"/")|ezurl}>{$ProductItem:item.object_name}</a></td>
                        </tr>
                        <tr class="bgdark">
                            <td>
                            {$ProductItem:item.item_count}
                            </td>
                            <td>
                            {$ProductItem:item.vat_value} %
                            </td>
                            <td>
                            {$ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
                            </td>
                            <td>
                            {$ProductItem:item.discount_percent}%
                            </td>
                            <td>
                            {$ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
                            </td>
                            <td>
                            {$ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}
                            </td>
                        </tr>
                        {section show=$ProductItem:item.item_object.option_list}
                        <tr>
                          <td colspan="6" style="padding: 0;">
                             <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                        <td colspan="3">
                        {"Selected options"|i18n("design/ocbootstrap/shop/confirmorder")}
                        </td>
                        </tr>
                             {section name=Options loop=$ProductItem:item.item_object.option_list}
                              <tr>
                                <td width="33%">{$ProductItem:Options:item.name}</td>
                                <td width="33%">{$ProductItem:Options:item.value}</td>
                                <td width="33%">{$ProductItem:Options:item.price|l10n( 'currency', $locale, $symbol )}</td>
                              </tr>
                            {/section}
                             </table>
                           </td>
                        </tr>
                        {/section}

                        {/section}
                    </tbody>
                    </table>



                    <h3 class="tt_uppercase color_dark m_bottom_25">{"Order summary"|i18n("design/ocbootstrap/shop/confirmorder")}:</h3>
                    <table class="table_type_4 responsive_table full_width r_corners wraper shadow t_align_l t_xs_align_c m_bottom_30">
                        <thead>
                            <tr class="f_size_large">
                                <th>{"Summary"|i18n("design/ocbootstrap/shop/confirmorder")}</th>
                                <th>{"Total ex. VAT"|i18n("design/ocbootstrap/shop/confirmorder")}</th>
                                <th>{"Total inc. VAT"|i18n("design/ocbootstrap/shop/confirmorder")}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="bglight">
                                <td>
                                {"Subtotal of items"|i18n("design/ocbootstrap/shop/confirmorder")}:
                                </td>
                                <td>
                                {$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                                <td>
                                {$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                            </tr>

                            {section name=OrderItem loop=$order.order_items show=$order.order_items sequence=array(bgdark,bglight)}
                            <tr class="{$OrderItem:sequence}">
                                <td>
                                {$OrderItem:item.description}:
                                </td>
                                <td>
                                {$OrderItem:item.price_ex_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                                <td>
                                {$OrderItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                            </tr>
                            {/section}
                            <tr class="bgdark">
                                <td>
                                {"Order total"|i18n("design/ocbootstrap/shop/confirmorder")}:
                                </td>
                                <td>
                                {$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                                <td>
                                {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="form-group m_bottom_15">
                        <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light" type="submit" name="CancelButton" value="{'Cancel'|i18n('design/ocbootstrap/shop/confirmorder')}" /> &nbsp;
                        <input class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" type="submit" name="ConfirmOrderButton" value="{'Confirm'|i18n('design/ocbootstrap/shop/confirmorder')}" /> &nbsp;
                    </div>

                </form>
            </div>
        </section>
    </div>
</div>
