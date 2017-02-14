{def $rss_export = fetch( 'rss', 'export_by_node', hash( 'node_id', $node.node_id ) )}
{if $rss_export}
  <a href="{concat( '/rss/feed/', $rss_export.access_url )|ezurl( 'no' )}" title="{$rss_export.title|wash()}">
	<i class="fa fa-rss"></i>
  </a>	
{/if}
{undef $rss_export}