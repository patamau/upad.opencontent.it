{def $files = fetch( 'content', 'list',
                                  hash( 'parent_node_id', $ente.node_id,
                                        'sort_by', $ente.sort_array,
                                        'class_filter_type', 'include',
                                        'class_filter_array', array('file'),
                                        'depth', 2))
     $file = 0;
}


{if $files|count()}
    <figure class="widget shadow r_corners wrapper m_bottom_30">
        <figcaption>
            <h3 class="color_light">Area Download</h3>
        </figcaption>
        <div class="widget_content">
            {foreach $files as $key => $values}
                {set $file = $values|attribute( 'file' )}
                <div class="clearfix m_bottom_15">
                    <a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="color_dark d_block bt_link">
                        <i class="m_right_15 fa fa-file-text fa-2x"></i>
                        {$file.content.original_filename|wash( xhtml )}
                    </a>
                </div>
            {/foreach}
        </div>
    </figure>
{/if}
