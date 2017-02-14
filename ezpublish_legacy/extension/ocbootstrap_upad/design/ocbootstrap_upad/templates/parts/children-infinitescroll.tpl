{developer_warning( '@todo @help gestire correttamente le misure e il responsive' )}
{set_defaults( hash(
  'page_limit', 10,
  'view', 'line',
  'delimiter', '',
  'exclude_classes', appini( 'ContentViewChildren', 'ExcludeClasses', array( 'image', 'video' ) ),
  'include_classes', array(),
  'type', 'exclude',
  'parent_node', $node
))}

{if $type|eq( 'exclude' )}
{def $params = hash( 'class_filter_type', 'exclude', 'class_filter_array', $exclude_classes )}
{else}
{def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}
{/if}

{def $children_count = fetch( 'content', 'tree_count', hash( 'parent_node_id', $parent_node.node_id )|merge( $params ) )}
{if $children_count}

  {def $offset = cond( is_set( $view_parameters.page ), $view_parameters.page|mul($page_limit), 0 )
	   $children = fetch( 'content', 'tree', hash( 'parent_node_id', $parent_node.node_id,
													'limit', $page_limit,
													'offset', $offset,
													'sort_by', array( 'published', false() ) )|merge( $params ) )}

  <div class="infinitescroll clearfix">
	{foreach $children as $item}
		<div class="infinitescroll-item" style="float: none; width: 250px; padding: 5px 10px">
		  {node_view_gui content_node=$item view=$view image_class=large}
		</div>
	{/foreach}

	<div class="sr-only">
	{include name=navigator
			 uri='design:navigator/google.tpl'
			 page_uri=$node.url_alias
			 item_count=$node.children_count
			 view_parameters=$view_parameters
			 item_limit=$page_limit}
	</div>	
  </div>

{ezscript_require( array( 'ezjsc::jquery', 'jquery.masonry.min.js', 'jquery.infinitescroll.min.js' ) )}
<script type="text/javascript">
var baseUrl = "{concat( $node.url_alias, '/(page)' )|ezurl(no,full)}/";
{literal}

$(function() {
	var $container = $('.infinitescroll');
    $container.imagesLoaded(function(){
      $container.masonry({
        itemSelector: '.infinitescroll-item',
        columnWidth: 250
      });
    });	
	$container.infinitescroll({
		navSelector  : "ul.pagination",
		nextSelector : "ul.pagination a.next:first",
		itemSelector : ".infinitescroll .infinitescroll-item",
		dataType     : "html",
		loading      : {img: "{/literal}{"images/loading.gif"|ezdesign(no)|ezroot(no,full)}{literal}", msgText: ''},
		pathParse    : function(p,c){var ret = [baseUrl, '']; return ret},
		debug        : false,
		state        : {currPage:0}
	  },
	  function( newElements ) {
		var $newElems = $( newElements );
		$container.masonry( 'appended', $newElems );
	  }
	);
});

{/literal}
</script>


{/if}

