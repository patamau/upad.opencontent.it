{def $is_ente = true()
     $ente = $node}
<div class="container ente ente_{$node.node_id}">
    <div class="row clearfix">
        <section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">
            <div class="clearfix m_bottom_25 m_sm_bottom_20">
                <h2 class="tt_uppercase color_dark m_bottom_25">{$node.name|wash()}</h2>
                <!--<img class="r_corners m_bottom_40" src="images/temp/offerta-formativa-lista.jpg" alt="">-->
                {include uri='design:atoms/image.tpl' item=$node image_class='original' css_class='r_corners m_bottom_40'}
            </div>
            {if $node|has_attribute( 'body' )}
                <div class="clearfix m_bottom_25 m_sm_bottom_20 description">
                    {attribute_view_gui attribute=$node|attribute( 'body' )}
                </div>
            {/if}

            {def $nodes=fetch('content','list',
                   hash(
                       'parent_node_id', $node.node_id,
                       'sort_by', $node.sort_array,
                       'depth', 2,
                       'limit', 9,
                       class_filter_type, "include",
                       class_filter_array, array('article')))}
            {if count($nodes)|gt(0)}
                <div class="clearfix">
                    <h2 class="color_dark tt_uppercase f_left m_bottom_15 f_mxs_none">News</h2>
                    <div class="f_right clearfix nav_buttons_wrap animate_fade f_mxs_none m_mxs_bottom_5">
                        <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left tr_delay_hover r_corners nc_prev"><i class="fa fa-angle-left"></i></button>
                        <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left m_left_5 tr_delay_hover r_corners nc_next"><i class="fa fa-angle-right"></i></button>
                    </div>
                </div>
                <!--offers carousel-->
                <div class="nc_carousel">
                    {foreach $nodes as $key => $value}
                        {if ne($node.node_id, $value.node_id)}
                            <figure class="r_corners photoframe shadow relative d_xs_inline_b tr_all_hover t_align_c">
                                <a href="{$value.url_alias|ezurl( 'no' )}" class="d_block relative pp_wrap m_bottom_15">
                                    {attribute_view_gui image_class='productcarousel' attribute=$value.data_map.image css_class='tr_all_hover'}
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
