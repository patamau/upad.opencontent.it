<div class="nav-main container">
  <div class="navbar navbar-default navbar-static-top {*navbar-inverse navbar-fixed-top*}" role="navigation">
    <!-- We use the fluid option here to avoid overriding the fixed width of a normal container within the narrow content columns. -->
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#nav-main-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        {*<a class="navbar-brand" href="#">Brand</a>*}
      </div>

      <div class="collapse navbar-collapse" id="nav-main-collapse">
        {def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )
             $top_menu_class_filter = ezini( 'MenuContentSettings', 'TopIdentifierList', 'app.ini' )
             $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                               'sort_by', $root_node.sort_array,
                                                               'class_filter_type', 'include',
                                                               'class_filter_array', $top_menu_class_filter ) )
             $top_menu_items_count = $top_menu_items|count()
             $item_class = array()
             $sub_menu_class_filter = ezini('MenuContentSettings','LeftIdentifierList','app.ini')
             $sub_menu_items = 0
             $anchor_class = array()
             $anchor_data_toggle = ''
        }

        {if $top_menu_items_count}
          <ul class="nav navbar-nav navbar-right">
          {foreach $top_menu_items as $key => $item}
            {set $item_class = array()
                 $anchor_class = array()
                 $anchor_data_toggle = ''
                 $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
                                                                    'sort_by', $item.sort_array,
                                                                     'class_filter_type', 'include',
                                                                     'class_filter_array', $sub_menu_class_filter ) )}

            {if $key|eq(0)}
              {set $item_class = $item_class|append("firstli")}
            {/if}
            {if $top_menu_items_count|eq( $key|inc )}
              {set $item_class = $item_class|append("lastli")}
            {/if}
            {if $item.node_id|eq( $current_node_id )}
              {set $item_class = $item_class|append("active")}
            {/if}
            {if gt($sub_menu_items|count(),0)}
              {set $item_class = $item_class|append("dropdown")}
            {/if}


            {if eq( $item.class_identifier, 'link')}
              <li id="node_id_{$item.node_id}"{if $item_class} class="{$item_class|implode(" ")}"{/if}>
                <a class="menu-item-link" {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $item.node_id)|ezurl}{else}href={$item.data_map.location.content|ezurl}{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$item.data_map.location.data_text|wash}" rel={$item.url_alias|ezurl}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash()}{else}{$item.name|wash()}{/if}</a>
            {else}
              <li id="node_id_{$item.node_id}"{if $item_class} class="{$item_class|implode(" ")}"{/if}>
              {if gt($sub_menu_items|count(),0)}
                {* dropdown *}
                <a class="nav-parent" href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$item.name|wash()}</a>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">{$item.name|wash()} <i class="fa fa-chevron-down"></i></a>
              {else}
                <a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$item.name|wash()}</a>
              {/if}
            {/if}

            {if gt($sub_menu_items|count(),0)}
              <ul class="nav dropdown-menu">
                <li><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{'Overview'|i18n('ocbootstrap')}</a></li>
                {foreach $sub_menu_items as $subitem}
                  {if eq( $subitem.class_identifier, 'link')}
                    <li id="node_id_{$subitem.node_id}"><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem.node_id)|ezurl}{else}href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$subitem.data_map.location.data_text|wash}" class="menu-item-link" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a></li>
                  {else}
                    <li id="node_id_{$subitem.node_id}"><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$subitem.name|wash()}</a></li>
                  {/if}
                {/foreach}
              </ul>

            {/if}
            </li>
          {/foreach}
          </ul>
        {/if}

{*
        <ul class="nav navbar-nav">
          <li class="active"><a href="#">Home</a></li>
          <li><a href="#">Link</a></li>
          <li><a href="#">Link</a></li>
        </ul>
*}
      </div><!-- /.navbar-collapse -->
    </div>
  </div>
</div>
