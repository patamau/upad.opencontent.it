{def $banners_big_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'BannersBigNodeID', 'content.ini' ) ) )
     $banners_big=fetch('content','list',
        hash(
            'parent_node_id', $banners_big_node.node_id,
            'sort_by', $banners_big_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('banner')))

     $banners_small_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'BannersSmallNodeID', 'content.ini' ) ) )
     $banners_small=fetch('content','list',
        hash(
            'parent_node_id', $banners_small_node.node_id,
            'sort_by', $banners_small_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('banner')))

     $banners_small_class = ''
     $count = 1}


{*$value.object.data_map.url.content*}

<figure class="widget wrapper m_bottom_30">
    <ul class="clearfix">
        {foreach $banners_big as $key => $value}
            <li class="banner_full m_bottom_30">
                {*include uri='design:atoms/image.tpl' item=$value image_class='original'*}
                {attribute_view_gui image_class='bannerlarge' href=$value.object.data_map.url.content attribute=$value.data_map.image}
            </li>
        {/foreach}

        {if $is_ente|not}
            {foreach $banners_small as $key => $value}
                {set $banners_small_class = ''}
                {if eq($count|mod(1), 0)}
                    {set $banners_small_class = 'f_left'}
                {/if}
                {if eq($count|mod(2), 0)}
                    {set $banners_small_class = 'f_right t_align_r'}
                {/if}

                <li class="banner_half m_bottom_10 {$banners_small_class}">
                    {*include uri='design:atoms/image.tpl' item=$value image_class='original'*}
                    {attribute_view_gui image_class='bannersmall' href=$value.object.data_map.url.content attribute=$value.data_map.image}
                </li>
                {if eq($count|mod(2), 0)}
                    <li class="clearfix"></li>
                {/if}
                {set $count=sum($count,1)}
            {/foreach}
        {/if}
    </ul>
</figure>

{undef $banners_big_node $banners_big $banners_small_node $banners_small $banners_small_class $count}
