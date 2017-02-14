{def $parent_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'InEvidenzaNodeID', 'content.ini' ) ) )
     $nodes=fetch('content','list',
        hash(
            'parent_node_id', $parent_node.node_id,
            'sort_by', $parent_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('corso')))}

{if count($nodes)|gt(0)}
    <div class="row clearfix m_bottom_45 m_sm_bottom_35">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="clearfix m_bottom_25 m_sm_bottom_20">
                <h2 class="tt_uppercase color_dark f_left">In evidenza</h2>
                <div class="f_right clearfix nav_buttons_wrap">
                    <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large bg_light_color_1 f_left tr_delay_hover r_corners blog_prev"><i class="fa fa-angle-left"></i></button>
                    <button class="button_type_7 bg_cs_hover box_s_none f_size_ex_large bg_light_color_1 f_left m_left_5 tr_delay_hover r_corners blog_next"><i class="fa fa-angle-right"></i></button>
                </div>
            </div>
            <!--blog carousel-->
            <div class="blog_carousel">
                {foreach $nodes as $key => $node}
                    <div class="clearfix">
                        <!--image-->
                        {if $node.data_map.image.has_content}
                            <a href="{$node.url_alias|ezurl( 'no' )}" class="d_block photoframe relative shadow wrapper r_corners f_left m_right_20 f_mxs_none m_mxs_bottom_10">
                                {attribute_view_gui image_class='inevidenza' attribute=$node.data_map.image css_class='tr_all_long_hover'}
                            </a>
                        {/if}
                        <!--post content-->
                        <div class="mini_post_content">
                            <h3 class="m_bottom_5"><a href="{$node.url_alias|ezurl( 'no' )}"><b>{$node.data_map.title.content|wash()}</b></a></h3>
                            <p>{$node.data_map.short_title.content|wash()}</p>
                            <hr class="m_bottom_5 m_top_10 divider_type_3">
                            <p class="f_size_medium">dal {$node.data_map.data_inizio.content.timestamp|datetime( 'custom', '%d/%m/%Y' )} al {$node.data_map.data_fine.content.timestamp|datetime( 'custom', '%d/%m/%Y' )}</p>
                            <hr class="m_bottom_10 m_top_5 divider_type_3">
                            <div class="abstract m_bottom_15">
                                {attribute_view_gui attribute=$node.data_map.short_description}
                            </div>
                            <a class="button_type_4 bg_scheme_color r_corners tr_all_hover color_light" href="{$node.url_alias|ezurl( 'no' )}">Maggiori informazioni</a>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
{/if}
{undef $parent_node $nodes}
