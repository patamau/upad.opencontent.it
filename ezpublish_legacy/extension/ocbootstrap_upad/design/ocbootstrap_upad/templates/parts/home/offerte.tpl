{*def $parent_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'OffertaFormativaNodeID', 'content.ini' ) ) )*}
{def  $nodes=fetch('content','list',
            hash(
                'parent_node_id', 2,
                'sort_by', array( 'published', false() ),
                'depth', 4,
                'main_node_only', true(),
                class_filter_type, "include",
                class_filter_array, array('corso'),
                'attribute_filter', array('or',
                                        array( 'corso/offerta_speciale', '=', 1),
                                        array( 'corso/ultimi_posti', '=', 1),
                                        array( 'corso/novita', '=', 1)
                                    )
                )
            )}

{if count($nodes)|gt(0)}
    <div class="row clearfix m_bottom_45 m_sm_bottom_35">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="clearfix">
                <h2 class="color_dark tt_uppercase f_left m_bottom_15 f_mxs_none heading5">Offerte Speciali</h2>
                <div class="f_right clearfix nav_buttons_wrap f_mxs_none m_mxs_bottom_5">
                    <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left tr_delay_hover r_corners nc_prev"><i class="fa fa-angle-left"></i></button>
                    <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left m_left_5 tr_delay_hover r_corners nc_next"><i class="fa fa-angle-right"></i></button>
                </div>
            </div>
            <!--offers carousel-->
            <div class="nc_carousel">
                {foreach $nodes as $key => $node}
                    <figure class="r_corners photoframe long tr_all_hover type_2 t_align_c shadow relative m_bottom_15">
                        <!--product preview-->
                        <a href="{$node.url_alias|ezurl( 'no' )}" class="d_block relative pp_wrap m_bottom_15">
                            {if $node.data_map.novita.content}
                                <!--new product-->
                                <span class="hot_stripe type_2"><img src="{'temp/new_product.png'|ezimage( 'no' )}" alt=""></span>
                            {/if}
                            {if $node.data_map.offerta_speciale.content}
                                <!--sale product-->
                                <span class="hot_stripe type_2"><img src="{'temp/sale_product.png'|ezimage( 'no' )}" alt=""></span>
                            {/if}
                            {if $node.data_map.ultimi_posti.content}
                                <!--hot product-->
                                <span class="hot_stripe type_3"><img src="{'temp/hot_product.png'|ezimage( 'no' )}" alt=""></span>
                            {/if}
                            {attribute_view_gui image_class='productcarousel' attribute=$node.data_map.image css_class='tr_all_hover'}
                            {*<span role="button" data-popup="#quick_view_product" class="button_type_5 box_s_none color_light r_corners tr_all_hover d_xs_none">Quick View</span>*}
                        </a>
                        <!--description and price of product-->
                        <figcaption class="p_vr_0 m_bottom_15">
                            <h5 class="fw_medium m_bottom_15">
                                <a href="{$node.url_alias|ezurl( 'no' )}" class="color_dark">{$node.data_map.title.content|wash()}</a>
                            </h5>
                            <!--<button class="button_type_4 bg_scheme_color r_corners tr_all_hover color_light mw_0 m_bottom_15">Leggi tutto</button>-->
                                <a class="button_type_4 bg_scheme_color r_corners tr_all_hover color_light mw_0 m_bottom_15" href="{$node.url_alias|ezurl( 'no' )}">Leggi tutto</a>
                        </figcaption>
                    </figure>
                {/foreach}
            </div>
        </div>
    </div>
{/if}
{undef $parent_node $nodes}
