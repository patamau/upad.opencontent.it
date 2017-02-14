{def $parent_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'NewsNodeID', 'content.ini' ) ) )
     $nodes=fetch('content','list',
        hash(
            'parent_node_id', $parent_node.node_id,
            'sort_by', array( 'attribute', false(), 'article/publish_date' ),
            class_filter_type, "include",
            class_filter_array, array('article')))}

<section class="bg_light_color_1 call_to_action_1 m_bottom_50 m_xs_bottom_30">
    <div class="container">
        <!--news&events-->
        <div class="row clearfix m_bottom_45 m_sm_bottom_35">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <div class="clearfix">
                    <h2 class="color_dark tt_uppercase f_left m_bottom_25 f_mxs_none heading5">News ed Eventi</h2>
                    <div class="f_right clearfix nav_buttons_wrap f_mxs_none m_mxs_bottom_5">
                        <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left tr_delay_hover r_corners ne_prev"><i class="fa fa-angle-left"></i></button>
                        <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large t_align_c bg_light_color_1 f_left m_left_5 tr_delay_hover r_corners ne_next"><i class="fa fa-angle-right"></i></button>
                    </div>
                </div>
                <!--news&events carousel-->
                <div class="ne_carousel row">
                    {foreach $nodes as $key => $node}
                        <div class="col-lg-12 col-md-12 col-sm-12 m_bottom_25">
                            <!--image-->
                            {if $node.data_map.image.has_content}
                                <a class="d_block photoframe relative shadow wrapper r_corners f_left m_right_20 f_mxs_none m_mxs_bottom_10" href="{$node.url_alias|ezurl( 'no' )}">
                                    {attribute_view_gui image_class='articlethumbnail' attribute=$node.data_map.image css_class='tr_all_long_hover'}
                                </a>
                            {/if}
                            <!--post content-->
                            <div class="mini_post_content">
                                <h3 class="m_bottom_5"><a href="{$node.url_alias|ezurl( 'no' )}"><b>{$node.name|wash()}</b></a></h3>
                                <p class="f_size_medium m_bottom_10">{$node.data_map.publish_date.content.timestamp|datetime( 'custom', '%d %F %Y' )}</p>
                                <div class="abstract m_bottom_15">
                                    {attribute_view_gui attribute=$node.data_map.intro}
                                </div>
                                <a href="{$node.url_alias|ezurl( 'no' )}" class="button_type_4 bg_scheme_color r_corners tr_all_hover color_light">Leggi tutto</a>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</section>
{undef $parent_node $nodes}
