{set_defaults( hash( 'type', 'absolute' ) )}
{def  $root_node_id = cond( $type|eq( 'relative' ), $node.path_array[$node.depth], $node.path_array[2] )
$root_node = fetch( 'content', 'node', hash( 'node_id', $root_node_id ) )
$menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                     'sort_by', $root_node.sort_array,
                     'load_data_map', false(),
                     'class_filter_type', 'include',
                     'class_filter_array', appini( 'MenuContentSettings', 'LeftIdentifierList', array() ) ) )
$menu_items_count = $menu_items|count()
$current_node_in_path = first_set($node.path_array[3], 0  )
}

<div class="nav-section">
  {if $menu_items_count}
    <ul class="nav">
      {foreach $menu_items as $key => $item}

        {if eq( $item.class_identifier, 'link')}
          <li><a href={$item.data_map.location.content|ezurl}{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if} title="{$item.data_map.location.data_text|wash}" class="menu-item-link" rel={$item.url_alias|ezurl}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash()}{else}{$item.name|wash()}{/if}</a>
            {else}
          <li><a href="{$item.url_alias|ezurl('no')}">{$item.name|wash()}</a>
        {/if}
        {if $current_node_in_path|eq($item.node_id)}
          {def $sub_menu_items = fetch( 'content', 'list', hash(  'parent_node_id', $item.node_id,
                                        'sort_by', $item.sort_array,
                                        'load_data_map', false(),
                                        'class_filter_type', 'include',
                                        'class_filter_array', appini( 'MenuContentSettings', 'LeftIdentifierList', array() ) ) )
                                        $sub_menu_items_count = $sub_menu_items|count}
          {if $sub_menu_items_count}
            <ul class="nav-sub">
              {foreach $sub_menu_items as $subkey => $subitem}
                {if eq( $subitem.class_identifier, 'link')}
                  <li><a href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if} title="{$subitem.data_map.location.data_text|wash}" class="menu-item-link" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a></li>
                {else}
                  <li><a href="{$subitem.url_alias|ezurl( 'no' )}">{$subitem.name|wash()}</a></li>
                {/if}
              {/foreach}
            </ul>
          {/if}
          {undef $sub_menu_items $sub_menu_items_count}
        {/if}
        </li>
      {/foreach}
    </ul>
  {/if}
  {undef $root_node $menu_items $menu_items_count}
</div>