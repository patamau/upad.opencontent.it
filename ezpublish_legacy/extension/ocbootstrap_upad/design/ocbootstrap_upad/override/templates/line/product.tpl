{def $materiale_didattico=fetch('content','list',
        hash(
            'parent_node_id', $node.main_node_id,
            'sort_by', $node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('materiale_didattico')))}

{def $materiale_didattico_count = $materiale_didattico|count()}

<!--product item-->
<div class="product_item full_width list_type hit m_left_0 m_right_0">
    <figure class="r_corners photoframe tr_all_hover type_2 shadow relative clearfix">
        <!--product preview-->
        <a href="{$node.url_alias|ezurl( 'no' )}" class="d_block f_left relative pp_wrap m_right_30 m_xs_right_25">
            {include uri='design:atoms/image.tpl' item=$node image_class='productthumbnail' css_class='tr_all_hover'}
        </a>
        <!--description and price of product-->
        <figcaption>
            <div class="clearfix">
                <div class="f_left p_list_description f_sm_none w_sm_full m_xs_bottom_10">
                    <h4 class="fw_medium"><a href="{$node.url_alias|ezurl( 'no' )}" class="color_dark">{$node.data_map.title.content|wash()}</a></h4>
                    <p class="m_bottom_10 f_size_medium">
                        {$node.data_map.short_title.content|wash()}
                    </p>
                    <hr>
                    <div class="d_sm_none d_xs_block abstract">
                        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
                    </div>
                </div>
                <div class="f_right f_sm_none t_align_r t_sm_align_l">
                    <p class="scheme_color f_size_large m_bottom_30">
                        <span class="fw_medium">{attribute_view_gui attribute=$node.data_map.price}</span>
                    </p>
                    {*
                    {if $materiale_didattico_count|gt(0)}
                        <form method="post" action={"ocpurchasebyteller/multiadd"|ezurl}>
                            <button type="submit" name="ActionAddToBasket" class="button_type_18 bg_scheme_color r_corners tr_all_hover color_light mw_0 m_bottom_10 m_sm_bottom_0 d_inline_b">
                                <i class="fa fa-shopping-cart m_right_5"></i>
                                <span class="f_size_medium">Acquista il corso ed il materiale didattico</span>
                            </button>
                            <br class="d_sm_none">
                            <input type="hidden" name="ContentNodeID" value="{$node.main_node_id}" />
                            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                            <input type="hidden" name="ViewMode" value="full" />
                            <input type="hidden" name="Quantity" value="1" />
                        </form>
                    <form method="post" action={"content/action"|ezurl}>
                        <button type="submit" name="ActionAddToBasket" class="button_type_18 bg_scheme_color r_corners tr_all_hover color_light mw_0 m_bottom_10 m_sm_bottom_0 d_inline_b">
                            <i class="fa fa-shopping-cart m_right_5"></i>
                            <span class="f_size_medium">Acquista il corso</span>
                        </button>
                        <br class="d_sm_none">
                        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                        <input type="hidden" name="ViewMode" value="full" />
                        <input type="hidden" name="Quantity" value="1" />
                    </form>
                {/if}
                *}
                {if $node.data_map.prenotabile.content}
                    <a href="{concat("Prenota/(corso)/", $node.node_id)|ezurl('no')}" class="button_type_18 bg_dark_color_1 r_corners tr_all_hover color_light mw_0 m_bottom_10 m_sm_bottom_0 d_inline_b">
                        <i class="fa fa-ticket  m_right_5"></i> <span class="f_size_medium">Prenota il corso</span>
                    </a>
                    <br class="d_sm_none">
                {/if}
                <a href="{$node.url_alias|ezurl( 'no' )}" class="button_type_18 bg_light_color_2 r_corners tr_all_hover color_dark mw_0 m_bottom_10 m_sm_bottom_0 d_sm_inline_middle"><i class="fa fa-info-circle m_right_5"></i> <span class="f_size_small">Maggiori informazioni</span></a>
            </div>
        </div>
    </figcaption>
</figure>
</div>
{*
<div class="content-view-line class-{$node.class_identifier} media">
{if $node|has_attribute( 'image' )}
<a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
</a>
{/if}
<div class="media-body">
<h4>
  <a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
  <small>{attribute_view_gui attribute=$node.data_map.product_number}</small>
</h4>

{if $node|has_abstract()}
  {$node|abstract()}
{/if}

<form method="post" action={"content/action"|ezurl}>
    <fieldset class="row">
        <div class="col-xs-6">
            {attribute_view_gui attribute=$node.data_map.additional_options}
        </div>
        <div class="col-xs-6">
            <div class="item-price">
                {attribute_view_gui attribute=$node.data_map.price}
            </div>
            <div class="item-buying-action form-inline">
                <label>
                    <span class="hidden">{'Amount'|i18n("design/ocbootstrap/line/product")}</span>
                    <input class="col-xs-1" type="text" name="Quantity" />
                </label>
                <button class="btn btn-warning" type="submit" name="ActionAddToBasket">
                    {'Buy'|i18n("design/ocbootstrap/line/product")}
                </button>
            </div>
        </div>
    </fieldset>
    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
    <input type="hidden" name="ViewMode" value="full" />
</form>
</div>
</div>
*}
