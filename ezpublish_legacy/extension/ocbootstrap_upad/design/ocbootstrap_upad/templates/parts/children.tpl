{set_defaults( hash(
  'page_limit', 6,
  'view', 'line',
  'delimiter', '',
  'exclude_classes', appini( 'ContentViewChildren', 'ExcludeClasses', array( 'image', 'video' ) ),
  'include_classes', array(),
  'type', 'exclude',
  'fetch_type', 'list',
  'parent_node', $node
))}

{if $type|eq( 'exclude' )}
{def $params = hash( 'class_filter_type', 'exclude', 'class_filter_array', $exclude_classes )}
{else}
{def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}
{/if}

<div class="clearfix m_bottom_25 m_sm_bottom_20">
    {if $node|has_attribute( 'short_name' )}
    <h2 class="tt_uppercase color_dark m_bottom_25">{$node.data_map.short_name.content|wash()}</h2>
    {/if}

    {def $children_count = fetch( content, concat( $fetch_type, '_count' ), hash( 'parent_node_id', $parent_node.node_id)|merge( $params ) )}
    {if $children_count}
        {include name=navigator
               uri='design:navigator/google.tpl'
               page_uri=$node.url_alias
               item_count=$children_count
               view_parameters=$view_parameters
               item_limit=$page_limit}
        <!--products list type-->
        <!--<section class="products_container list_type clearfix m_bottom_5 m_left_0 m_right_0">-->
          {foreach fetch( content, $fetch_type, hash( 'parent_node_id', $parent_node.node_id,
                                                  'offset', $view_parameters.offset,
                                                  'sort_by', $parent_node.sort_array,
                                                  'limit', $page_limit )|merge( $params ) ) as $child }
            {node_view_gui view=$view content_node=$child}
            {delimiter}{$delimiter}{/delimiter}
          {/foreach}
        <!--</section>-->
        {include name=navigator
               uri='design:navigator/google.tpl'
               page_uri=$node.url_alias
               item_count=$children_count
               view_parameters=$view_parameters
               item_limit=$page_limit}
    {/if}

</div>
