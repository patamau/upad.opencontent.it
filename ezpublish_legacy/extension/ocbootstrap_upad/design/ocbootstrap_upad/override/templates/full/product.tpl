{def $materiale_didattico=fetch('content','list',
        hash(
            'parent_node_id', $node.main_node_id,
            'sort_by', $node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('materiale_didattico')))}

{def $materiale_didattico_count = $materiale_didattico|count()}

{def $ente = fetch( content, object, hash( object_id, $node.data_map.ente.content.relation_list[0].contentobject_id ) )
     $codice_area = fetch( content, object, hash( object_id, $node.data_map.codice_area.content.relation_list[0].contentobject_id ) ) }

{* Product - Full view *}
<div class="container">
    <div class="row clearfix">
        <section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">
            <div class="clearfix m_bottom_30 t_xs_align_c row">
                <div class="type_2 f_left f_sm_none d_xs_inline_b  relative m_bottom_5 m_sm_bottom_20 m_xs_right_0 w_mxs_full col-lg-7">
                    {*<div class="photoframe relative shadow r_corners d_inline_b m_bottom_20 d_xs_block">
                        <!--<img alt="" class="tr_all_hover" data-zoom-image="images/preview_zoom_1.jpg" src="images/quick_view_img_7.jpg" id="zoom_image">-->
                        {include uri='design:atoms/image.tpl' item=$node image_class='productimage' css_class='tr_all_hover'}
                    </div>*}
                    {if $node|has_attribute( 'image' )}
                        <div class="photoframe type_2 shadow r_corners f_left f_sm_none d_xs_inline_b product_single_preview relative m_right_30 m_bottom_5 m_sm_bottom_20 m_xs_right_0 w_mxs_full">
                            <!--<img alt="" class="tr_all_hover" data-zoom-image="images/preview_zoom_1.jpg" src="images/quick_view_img_7.jpg" id="zoom_image">-->
                            {*include uri='design:atoms/image.tpl' item=$node image_class='productimage' css_class='tr_all_hover'*}
                            {attribute_view_gui image_class='productimage' attribute=$node.data_map.image css_class='tr_all_hover'}
                        </div>
                    {/if}
                    <h2 class="color_dark fw_medium m_bottom_20 t_align_c">{attribute_view_gui attribute=$node.data_map.price}</h2>
                    <div class="fw_medium m_bottom_20 t_align_c">
                        <a class="tr_delay_hover r_corners button_type_12 bg_scheme_color color_light f_size_large d_inline_middle" href="{'Informazioni-per-l-iscrizione'|ezurl(no))}">Informazioni per l'iscrizione</a>
                        {*if $materiale_didattico_count|gt(0)}
                            <form method="post" action={"ocpurchasebyteller/multiadd"|ezurl}>
                                <button type="submit" name="ActionAddToBasket" class="tr_delay_hover r_corners button_type_12 bg_scheme_color color_light f_size_large f_left">
                                    <i class="fa fa-shopping-cart m_right_10"></i>Acquista il corso ed il materiale didattico
                                </button>
                                {if $node.data_map.prenotabile.content}
                                    <a href="{concat("Prenota/(corso)/", $node.node_id)|ezurl('no')}" class="tr_delay_hover r_corners button_type_12 bg_dark_color bg_cs_hover color_light f_size_large f_right">
                                        <i class="fa fa-ticket  m_right_10"></i>Prenota il corso
                                    </a>
                                {/if}
                                <br class="d_sm_none">
                                <input type="hidden" name="ContentNodeID" value="{$node.main_node_id}" />
                                <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                                <input type="hidden" name="ViewMode" value="full" />
                                <input type="hidden" name="Quantity" value="1" />
                            </form>
                        {else}
                            <form method="post" action={"content/action"|ezurl}>
                                <button type="submit" name="ActionAddToBasket" class="tr_delay_hover r_corners button_type_12 bg_scheme_color color_light f_size_large f_left">
                                    <i class="fa fa-shopping-cart m_right_10"></i>Acquista il corso
                                </button>
                                {if $node.data_map.prenotabile.content}
                                    <a href="{concat("Prenota/(corso)/", $node.node_id)|ezurl('no')}" class="tr_delay_hover r_corners button_type_12 bg_dark_color bg_cs_hover color_light f_size_large f_right">
                                        <i class="fa fa-ticket  m_right_10"></i>Prenota il corso
                                    </a>
                                {/if}
                                <br class="d_sm_none">
                                <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                                <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                                <input type="hidden" name="ViewMode" value="full" />
                                <input type="hidden" name="Quantity" value="1" />
                            </form>
                        {/if*}
                    </div>
                    <br class="clearfix">
                    <div class="fw_medium m_bottom_20 t_align_c m_top_20">
                        {*<p class="d_inline_middle">Condividi:</p>*}
                        <div class="d_inline_middle m_left_5 addthis_widget_container">
                            <!-- AddThis Button BEGIN -->
                            {*<div class="addthis_toolbox addthis_default_style addthis_32x32_style">
                            <a class="addthis_button_facebook addthis_button_preferred_1 at300b" title="Facebook" href="#"><span class=" at300bs at15nc at15t_facebook"><span class="at_a11y">Share on facebook</span></span></a>
                            <a class="addthis_button_twitter addthis_button_preferred_2 at300b" title="Tweet" href="#"><span class=" at300bs at15nc at15t_twitter"><span class="at_a11y">Share on twitter</span></span></a>
                            <a class="addthis_button_email addthis_button_preferred_3 at300b" target="_blank" title="E-mail" href="#"><span class=" at300bs at15nc at15t_email"><span class="at_a11y">Share on email</span></span></a>
                            <a class="addthis_button_print addthis_button_preferred_4 at300b" title="Stampa" href="#"><span class=" at300bs at15nc at15t_print"><span class="at_a11y">Share on print</span></span></a>
                            <a class="addthis_button_compact at300m" href="#"><span class=" at300bs at15nc at15t_compact"><span class="at_a11y">More Sharing Services</span></span></a>
                            <a class="addthis_counter addthis_bubble_style"></a>
                            <div class="atclear"></div>
                            </div>*}
                            <!-- AddThis Button END -->
                            <div class="d_inline_middle m_left_5 addthis_widget_container">
                                <!-- AddThis Button BEGIN -->
                                <div class="addthis_toolbox addthis_default_style addthis_32x32_style">
                                <a class="addthis_button_preferred_1"></a>
                                <a class="addthis_button_preferred_2"></a>
                                <a class="addthis_button_preferred_3"></a>
                                <a class="addthis_button_preferred_4"></a>
                                <a class="addthis_button_compact"></a>
                                <a class="addthis_counter addthis_bubble_style"></a>
                                </div>
                                <!-- AddThis Button END -->
                            </div>
                        </div>
                    </div>

                </div>
                <div class="p_top_10 t_xs_align_l col-lg-5">
                    <!--description-->
                    <h2 class="color_dark fw_medium m_bottom_10">{$node.data_map.title.content|wash()}</h2>
                    <p>{$node.data_map.short_title.content|wash()}</p>

                    <hr class="m_bottom_20 divider_type_3">

                    <h5 class="fw_medium m_bottom_10 color_dark">Presentazione</h5>
                    <div class="m_bottom_20 description">
                        {attribute_view_gui attribute=$node|attribute( 'description' )}
                    </div>

                    <hr class="m_bottom_20 divider_type_3">

                    <h5 class="fw_medium m_bottom_10 color_dark">Date di svolgimento</h5>
                    <table class="description_table m_bottom_5">
                        <tbody>

                            <tr>
                                <td>Codice:</td>
                                <td><strong class="color_dark">{$codice_area.data_map.codice.content}-{$ente.data_map.codice.content}-{$node.data_map.anno.content}-{$node.data_map.codice.content}-{$node.data_map.edizione.content}</strong></td>
                            </tr>
                            <tr>
                                <td>Inizio:</td>
                                <td><strong class="color_dark">da {$node.data_map.data_inizio.content.timestamp|datetime( 'custom', '%l %d/%m/%Y' )} {if $node|has_attribute( 'data_fine' )}a {$node.data_map.data_fine.content.timestamp|datetime( 'custom', '%l %d/%m/%Y' )}{/if}</strong></td>
                            </tr>
                            <tr>
                                <td>Orario:</td>
                                <td><strong class="color_dark">{attribute_view_gui attribute=$node|attribute( 'orario' )}</strong></td>
                            </tr>
                            <tr>
                                <td>Numero lezioni:</td>
                                <td><strong class="color_dark">{attribute_view_gui attribute=$node|attribute( 'numero_lezioni' )}</strong></td>
                            </tr>
                        </tbody>
                    </table>

                    <hr class="m_bottom_20 divider_type_3">

                    <h5 class="fw_medium m_bottom_10 color_dark">Informazioni</h5>
                    <table class="description_table m_bottom_5">
                        <tbody>
                            <tr>
                                <td>Relatore:</td>
                                <td><strong class="color_dark">{attribute_view_gui attribute=$node|attribute( 'docente' )}</strong></td>
                            </tr>
                            <tr>
                                <td>Luogo:</td>
                                <td><strong class="color_dark">{attribute_view_gui attribute=$node|attribute( 'luogo' )}</strong></td>
                            </tr>
                            <tr>
                                <td>Ente:</td>
                                <td><strong class="color_dark">{attribute_view_gui attribute=$node|attribute( 'ente' )}</strong></td>
                            </tr>
                            <tr>
                                <td>Area Tematica:</td>
                                <td><strong class="color_dark">{attribute_view_gui attribute=$node|attribute( 'area_tematica' )}</strong></td>
                            </tr>
                            <tr>
                                <td>Destinatari:</td>
                                <td><strong class="color_dark">{attribute_view_gui attribute=$node|attribute( 'destinatari' )}</strong></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            {def $area_object_id = $node.data_map.area_tematica.content.relation_list[0].contentobject_id}
            {def $nodes =fetch( ezfind, search, hash(
                    'class_id', array( 'corso' ),
                    'filter', array( concat( 'submeta_area_tematica___id____si:',  $area_object_id ), concat('-meta_id_si:', $node.contentobject_id) ),
                    'limit', 9,
                    'sort_by', hash( 'published', 'desc' )
            ))}
            {if $nodes.SearchCount|gt(0)}
                <div class="clearfix">
                    <h2 class="color_dark tt_uppercase f_left m_bottom_15 f_mxs_none">Potrebbe interessarti anche:</h2>
                    <div class="f_right clearfix nav_buttons_wrap animate_fade f_mxs_none m_mxs_bottom_5">
                        <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left tr_delay_hover r_corners nc_prev"><i class="fa fa-angle-left"></i></button>
                        <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left m_left_5 tr_delay_hover r_corners nc_next"><i class="fa fa-angle-right"></i></button>
                    </div>
                </div>
                <!--offers carousel-->
                <div class="nc_carousel">
                    {foreach $nodes.SearchResult as $key => $value}
                        {if ne($node.main_node_id, $value.main_node_id)}
                            <figure class="r_corners photoframe shadow relative d_xs_inline_b tr_all_hover t_align_c">
                                <!--product preview-->
                                <a href="{$value.url_alias|ezurl( 'no' )}" class="d_block relative pp_wrap m_bottom_15">
                                    {if $value.data_map.novita.content}
                                        <!--new product-->
                                        <span class="hot_stripe type_2"><img src="{'temp/new_product.png'|ezimage( 'no' )}" alt=""></span>
                                    {/if}
                                    {* i sconto da sistemare}
                                    <!--sale product-->
                                    <span class="hot_stripe type_2"><img src="{'temp/sale_product.png'|ezimage( 'no' )}" alt=""></span>
                                    *}
                                    {if $value.data_map.ultimi_posti.content}
                                        <!--hot product-->
                                        <span class="hot_stripe type_3"><img src="{'temp/hot_product.png'|ezimage( 'no' )}" alt=""></span>
                                    {/if}
                                    {attribute_view_gui image_class='productcarousel' attribute=$value.data_map.image css_class='tr_all_hover'}
                                    {*<span role="button" data-popup="#quick_view_product" class="button_type_5 box_s_none color_light r_corners tr_all_hover d_xs_none">Quick View</span>*}
                                </a>
                                <!--description and price of product-->
                                <figcaption class="p_vr_0 m_bottom_15">
                                    <h5 class="fw_medium m_bottom_15">
                                        <a href="{$value.url_alias|ezurl( 'no' )}" class="color_dark">{$value.name|wash()}</a>
                                    </h5>
                                    <!--<button class="button_type_4 bg_scheme_color r_corners tr_all_hover color_light mw_0 m_bottom_15">Leggi tutto</button>-->
                                        <a class="button_type_4 bg_scheme_color r_corners tr_all_hover color_light mw_0 m_bottom_15" href="{$value.url_alias|ezurl( 'no' )}">Leggi tutto</a>
                                </figcaption>
                            </figure>
                        {/if}
                    {/foreach}
                </div>
            {/if}
           {undef $nodes}
        </section>
        <!-- sidebar -->
        {include uri='design:page_sidebar.tpl'}
    </div>
</div>

<!-- Partner -->
{include uri='design:parts/partner.tpl'}

{*
<div class="content-view-full class-{$node.class_identifier} row">

  {include uri='design:nav/nav-section.tpl'}

  <div class="content-main">

    <h1>{$node.name|wash()}</h1>

    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}

    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' )}

    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}

    {if $node|has_attribute( 'tags' )}
      <div class="tags">
        {attribute_view_gui attribute=$node|attribute( 'tags' )}
      </div>
    {/if}

    {if $node|has_attribute( 'star_rating' )}
      <div class="rating">
        {attribute_view_gui attribute=$node|attribute( 'star_rating' )}
      </div>
    {/if}

    {include uri='design:parts/social_buttons.tpl'}

    {if $node|has_attribute( 'comments' )}
      <div class="comments">
        {attribute_view_gui attribute=$node|attribute( 'comments' )}
      </div>
    {/if}

  </div>


</div>

*}
{*
<section class="content-view-full">
    <article class="class-product row">
        <div class="span8">
            {if $node.data_map.image.has_content}
                <div class="attribute-image full-head">
                    {attribute_view_gui attribute=$node.data_map.image image_class=productimage}

                    {if $node.data_map.caption.has_content}
                        <div class="attribute-caption">
                            {attribute_view_gui attribute=$node.data_map.caption}
                        </div>
                    {/if}
                </div>
            {/if}

            <div class="attribute-short">
               {attribute_view_gui attribute=$node.data_map.short_description}
            </div>

            <div class="attribute-long">
               {attribute_view_gui attribute=$node.data_map.description}
            </div>

            {def $product_category_attribute=ezini( 'VATSettings', 'ProductCategoryAttribute', 'shop.ini' )}
            {if and( $product_category_attribute, is_set( $node.data_map.$product_category_attribute ) )}
            <div class="attribute-long">
              <p>Category:&nbsp;{attribute_view_gui attribute=$node.data_map.$product_category_attribute}</p>
            </div>
            {/if}
            {undef $product_category_attribute}

           {def $related_purchase=fetch( 'shop', 'related_purchase', hash( 'contentobject_id', $node.object.id, 'limit', 10 ) )}
           {if $related_purchase}
            <div class="relatedorders">
                <h2>{'People who bought this also bought'|i18n( 'design/ocbootstrap/full/product' )}</h2>

                <ul>
                {foreach $related_purchase as $product}
                    <li>{content_view_gui view=text_linked content_object=$product}</li>
                {/foreach}
                </ul>
            </div>
           {/if}
           {undef $related_purchase}
        </div>
        <div class="span4">
            <aside>
                <section class="content-view-aside">
                    <div class="product-main">
                        <div class="attribute-header">
                            <h2>{$node.name|wash()}</h2>
                            <span class="subheadline">{attribute_view_gui attribute=$node.data_map.product_number}</span>
                        </div>
                        <article>
                            <form method="post" action={"content/action"|ezurl}>
                                <fieldset class="row">
                                    <div class="item-price span4">
                                    {if $node.data_map.price.has_discount}
                                        {$node.data_map.price.content.discount_price_inc_vat|l10n( 'currency' )} <span class="old-price">{$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}</span>
                                    {else}
                                        {$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}
                                    {/if}
                                    </div>
                                    <div class="span4">
                                        {attribute_view_gui attribute=$node.data_map.additional_options}
                                    </div>
                                    <div class="item-buying-action form-inline span4">
                                        <label>
                                            <span class="hidden">{'Amount'|i18n("design/ocbootstrap/full/product")}</span>
                                            <input type="text" name="Quantity" />
                                        </label>
                                        <button class="btn btn-warning" type="submit" name="ActionAddToBasket">
                                        {'Add to basket'|i18n("design/ocbootstrap/full/product")}
                                        </button>
                                    </div>
                                </fieldset>
                                <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                                <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                                <input type="hidden" name="ViewMode" value="full" />
                            </form>
                        </article>
                        <div class="attribute-socialize">
                            {include uri='design:parts/social_buttons.tpl'}
                        </div>
                    </div>
                </section>
            </aside>
        </div>
   </article>
</section>
*}
