<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">Assegna corsi</h2>
                <form method="post" action={"ocpurchasebyteller/assign"|ezurl}>

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
                            </tr>
                        </thead>
                        <tbody>
                    {section name=ProductItem loop=$basket.items sequence=array(bgdark, bglight)}
                        <tr class="bglight">
                            <td colspan="6"><input type="hidden" name="ProductItemIDList[]" value="{$Basket:ProductItem:item.id}" />
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
                        </tr>
                        {section show=$Basket:ProductItem:item.item_object.option_list}
                            <tr>
                                <td colspan="6" style="padding: 0;">
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
                             <td colspan="6">
                                <hr size='2' />
                             </td>
                        </tr>
                        <tr>
                             <td colspan="4"></td>
                             <td>
                                <strong>{"Subtotal ex. VAT"|i18n("design/ocbootstrap/shop/basket")}</strong>:
                             </td>
                             <td>
                                <strong>{"Subtotal inc. VAT"|i18n("design/ocbootstrap/shop/basket")}</strong>:
                             </td>
                        </tr>
                        <tr>
                            <td colspan="4"></td>
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
                             <td colspan="4">
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
                             <td colspan="4">
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
                        {undef $currency $locale $symbol}

                    {section-else}
                        <div class="feedback">
                            <h2>{"You have no products in your basket."|i18n("design/ocbootstrap/shop/basket")}</h2>
                        </div>
                    {/section}
            </div>
        </section>

        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                
				<div class="row attribute-sender-last-name m_bottom_15">
                    <div class="col-md-4">Utente</div>
                    <div class="col-md-8">
						<input type="text" name="SearchUser" value="{if is_set($view_parameters.s)}{$view_parameters.s|wash()}{/if}" placeholder="Cerca utente" />
						<input class="btn btn-primary" type="submit" name="SearchUserButton" value="Cerca" />
						{foreach $users as $key => $value}
						<div class="radio">
						  <label>
							<input type="radio" name="userID" value="{$value.contentobject_id}" /> {$value.name} ({$value.data_map.codice_fiscale.content})
						  </label>
						</div>
						{/foreach}						
                    </div>
                </div>
				{include name=navigator
								uri='design:navigator/google.tpl'
								page_uri='ocpurchasebyteller/form'
								item_count=$users_count
								view_parameters=$view_parameters
								item_limit=$limit}

                <div class="row content-action">
                    <div class="col-md-12">
                        <a href={"shop/basket"|ezurl} class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light f_left">Torna indietro</a>
                        <input type="submit" class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light f_right" name="CheckoutButton" value="Assegna corsi" />
                        <input type="hidden" name="productObjectID" value="{$product[0].contentobject_id}" />
                    </div>
                </div>

            </form>
            </div>
        </section>
    </div>
</div>
