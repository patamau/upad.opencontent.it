{def $node_class = array()
	 $anchor_class = array()
	 $anchor_data_toggle = ''
	 $sub_menu_class_filter = ezini('MenuContentSettings','LeftIdentifierList','app.ini')
	 $current_path = cond( $current_node_id|gt(0), fetch(content,node,hash(node_id, $current_node_id)).path_string|explode( '/' ), array('null') )
	 $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
														'sort_by', $node.sort_array,
														 'class_filter_type', 'include',
														 'class_filter_array', $sub_menu_class_filter ) )}
{if $key|eq(0)}
  {set $node_class = $node_class|append("firstli")}
{/if}
{if $top_menu_items_count|eq( $key|inc )}
  {set $node_class = $node_class|append("lastli")}
   {if gt($sub_menu_items|count(),0)}
	{set $node_class = $node_class|append("navbar-right")}
   {/if}
{/if}
{if $node.node_id|eq( $current_node_id )}
  {set $node_class = $node_class|append("active")}
{elseif $current_path|contains( $node.node_id )}
  {set $node_class = $node_class|append("current")}
{/if}
{if gt($sub_menu_items|count(),0)}
  {set $node_class = $node_class|append("dropdown")}
{/if}

{if eq( $node.class_identifier, 'link')}
  <li id="node_id_{$node.node_id}"{if $node_class} class="{$node_class|implode(" ")}"{/if}>
	<a class="menu-item-link" {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $node.node_id)|ezurl}{else}href={$node.data_map.location.content|ezurl}{if and( is_set( $node.data_map.open_in_new_window ), $node.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$node.data_map.location.data_text|wash}" rel={$node.url_alias|ezurl}>{if $node.data_map.location.data_text}{$node.data_map.location.data_text|wash()}{else}{$node.name|wash()}{/if}</a>
{else}
  <li id="node_id_{$node.node_id}"{if $node_class} class="{$node_class|implode(" ")}"{/if}>
  {if gt($sub_menu_items|count(),0)}	
	<a href="#" class="dropdown-toggle" data-toggle="dropdown">{$node.name|wash()}  <i class="fa fa-chevron-down"></i></a>
  {else}
	<a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $node.node_id)|ezurl}{else}{$node.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$node.name|wash()}</a>
  {/if}
{/if}

{if gt($sub_menu_items|count(),0)}
  <ul class="nav dropdown-menu">
	<li><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $node.node_id)|ezurl}{else}{$node.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{'Overview'|i18n('ocbootstrap')}</a></li>
	{foreach $sub_menu_items as $subitem}
	  {def $subitem_class = array()}
	  
	  {if $subitem.node_id|eq( $current_node_id )}
		{set $subitem_class = $subitem_class|append("active")}
	  {elseif $current_path|contains( $subitem.node_id )}
		{set $subitem_class = $subitem_class|append("current")}
	  {/if}
	  
	  {if eq( $subitem.class_identifier, 'link')}
		<li id="node_id_{$subitem.node_id}" {if $subitem_class} class="{$subitem_class|implode(" ")}"{/if}><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem.node_id)|ezurl}{else}href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$subitem.data_map.location.data_text|wash}" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a></li>
	  {else}
		<li id="node_id_{$subitem.node_id}" {if $subitem_class} class="{$subitem_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$subitem.name|wash()}</a></li>
	  {/if}
	  {undef $subitem_class}
	{/foreach}
  </ul>

{/if}
</li>