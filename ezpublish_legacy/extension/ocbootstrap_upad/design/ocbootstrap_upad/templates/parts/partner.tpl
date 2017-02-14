{def $slides_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'PartnerNodeID', 'content.ini' ) ) )
     $banners=fetch('content','tree',
        hash(
            'parent_node_id', $slides_node.node_id,
            'sort_by', $slides_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('banner')))}

    <div class="container m_bottom_10">
        <div class="clearfix">
            <div class="f_right clearfix nav_buttons_wrap f_mxs_none m_mxs_bottom_5">
                <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left tr_delay_hover r_corners partner_carousel_prev"><i class="fa fa-angle-left"></i></button>
                <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left m_left_5 tr_delay_hover r_corners partner_carousel_next"><i class="fa fa-angle-right"></i></button>
            </div>
        </div>
        <div class="row partner_carousel clearfix m_top_40 m_bottom_25">
            {foreach $banners as $k => $v}
                <figure>
                    <a href="{$v.object.data_map.url.content}" class="m_image_wrap d_block m_bottom_15 d_xs_inline_b d_mxs_block">
                        {attribute_view_gui image_class=original attribute=$v.data_map.image}
                    </a>
                </figure>
            {/foreach}
        </div>
    </div>
{undef $slides_node $banners}
