{def $nodes = fetch( 'content', 'list',
                            hash( 'parent_node_id', $ente.node_id,
                                  'sort_by', $ente.sort_array,
                                  'class_filter_type', 'include',
                                  'class_filter_array', array('folder'),
                                  'depth', 1))
}

<figure class="widget shadow r_corners wrapper m_bottom_30">
    <figcaption>
        <h3 class="color_light">{$ente.name|wash}</h3>
    </figcaption>
    <div class="widget_content">
        <!--Categories list-->
        <ul class="categories_list">
            {foreach $nodes as $key => $value}
                {*
                <li class="active">
                    <a class="f_size_large color_dark d_block" href="#">
                        <b>Fashion</b>
                    </a>
                </li>
                *}
                <li{if or(eq($node.node_id, $value.node_id), eq($node.parent.node_id, $value.node_id))} class="active"{/if}>
                    <a class="f_size_large color_dark d_block" href="{$value.url_alias|ezurl( 'no' )}">
                        {$value.name|wash}
                    </a>
                </li>
            {/foreach}

        </ul>
    </div>
</figure>

{undef $nodes}
