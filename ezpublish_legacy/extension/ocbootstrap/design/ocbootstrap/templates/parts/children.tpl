{set_defaults( hash(
  'page_limit', 10,
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

{def $children_count = fetch( content, concat( $fetch_type, '_count' ), hash( 'parent_node_id', $parent_node.node_id )|merge( $params ) )}
{if $children_count}
  <div class="content-view-children">  
	{foreach fetch( content, $fetch_type, hash( 'parent_node_id', $parent_node.node_id,
											'offset', $view_parameters.offset,
											'sort_by', $parent_node.sort_array,											
											'limit', $page_limit )|merge( $params ) ) as $child }
	  {node_view_gui view=$view content_node=$child}
	  {delimiter}{$delimiter}{/delimiter}
	{/foreach}
  </div>

  {include name=navigator
		   uri='design:navigator/google.tpl'
		   page_uri=$node.url_alias
		   item_count=$children_count
		   view_parameters=$view_parameters
		   item_limit=$page_limit}

{/if}