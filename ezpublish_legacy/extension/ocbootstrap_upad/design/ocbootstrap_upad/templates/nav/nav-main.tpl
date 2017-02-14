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
     $sub_menu_items_count = 0
     $sub_menu_items_limit = 0
     $sub_menu_items_offset = 0
     $count = 1
     $anchor_class = array()
     $anchor_data_toggle = ''
}

{set $top_menu_items=$top_menu_items|insert(0,$root_node)}



<!--main menu container-->
<div class="container">
    <section class="menu_wrap type_2 relative clearfix t_xs_align_c">
        <!--button for responsive menu-->
        <button id="menu_button" class="r_corners centered_db d_none tr_all_hover d_xs_block m_bottom_15">
            <span class="centered_db r_corners"></span>
            <span class="centered_db r_corners"></span>
            <span class="centered_db r_corners"></span>
        </button>
        <!--main menu-->
        {if $top_menu_items_count}
        <nav role="navigation" class="f_left f_xs_none d_xs_none t_xs_align_l">
            <ul class="horizontal_list main_menu clearfix">
                {foreach $top_menu_items as $key => $item}
                    {set $item_class = array()
                         $anchor_class = array()
                         $anchor_data_toggle = ''}
                         {if ne($item.node_id, $root_node.node_id)}
                            {set $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
                                                                               'sort_by', $item.sort_array,
                                                                                'class_filter_type', 'include',
                                                                                'class_filter_array', $sub_menu_class_filter ) )}
                         {/if}
                    {set $sub_menu_items_count = $sub_menu_items|count()}

                    {if $key|eq(0)}
                      {set $item_class = $item_class|append("firstli")}
                    {/if}
                    {if $top_menu_items_count|eq( $key|inc )}
                      {set $item_class = $item_class|append("lastli")}
                    {/if}
                    {if $item.node_id|eq( $current_node_id )}
                      {set $item_class = $item_class|append("current")}
                    {/if}
                    {if gt($sub_menu_items_count,0)}
                      {set $item_class = $item_class|append("dropdown")}
                    {/if}

                    <li id="node_id_{$item.node_id}" class=" relative f_xs_none m_xs_bottom_5 {$item_class|implode(" ")}">
                        {if eq( $item.class_identifier, 'link')}
                            <a class="tr_delay_hover color_light tt_uppercase" {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $item.node_id)|ezurl}{else}href={$item.data_map.location.content|ezurl}{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$item.data_map.location.data_text|wash}" rel={$item.url_alias|ezurl}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash()}{else}{$item.name|wash()}{/if}</a>
                        {else}
                            <a class="tr_delay_hover color_light tt_uppercase" href="{$item.url_alias|ezurl('no')}"><b>{$item.name|wash}</b></a>
                        {/if}

                        {if gt($sub_menu_items_count,0)}
                            {set $sub_menu_items_limit = ceil($sub_menu_items_count|div( 3 ))
                                 $count = 1}
                            <div class="sub_menu_wrap top_arrow d_xs_none tr_all_hover clearfix r_corners w_xs_auto submenu_{$item.node_id}">
                                <div class="f_left f_xs_none">
                                    <ul class="sub_menu first">
                                        {foreach $sub_menu_items as $subitem}
                                            {if eq( $subitem.class_identifier, 'link')}
                                                <li id="node_id_{$subitem.node_id}">
                                                    <a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem.node_id)|ezurl}{else}href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$subitem.data_map.location.data_text|wash}" class="menu-item-link" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a>
                                                </li>
                                            {else}
                                                <li id="node_id_{$subitem.node_id}">
                                                    <a href="{$subitem.url_alias|ezurl('no')}" class="color_dark tr_delay_hover">{$subitem.name|wash()}</a>
                                                </li>
                                            {/if}
                                            {if eq($count, $sub_menu_items_limit)}
                                                </ul>
                                                </div>
                                                <div class="f_left m_left_10 m_xs_left_0 f_xs_none">
                                                <ul class="sub_menu">
                                                {set $count=1}
                                            {else}
                                                {set $count=sum($count,1)}
                                            {/if}
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>
                            {*
                                <div class="sub_menu_wrap top_arrow d_xs_none tr_all_hover clearfix r_corners w_xs_auto">
                                    <div class="f_left f_xs_none">
                                        <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Dresses</b>
                                        <ul class="sub_menu first">
                                            <li><a href="#" class="color_dark tr_delay_hover">Evening Dresses</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Casual Dresses</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Party Dresses</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Maxi Dresses</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Midi Dresses</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Strapless Dresses</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Day Dresses</a></li>
                                        </ul>
                                    </div>
                                    <div class="f_left m_left_10 m_xs_left_0 f_xs_none">
                                        <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Accessories</b>
                                        <ul class="sub_menu">
                                            <li><a href="#" class="color_dark tr_delay_hover">Bags and Purces</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Belts</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Scarves</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Gloves</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Jewellery</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Sunglasses</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Hair Accessories</a></li>
                                        </ul>
                                    </div>
                                    <div class="f_left m_left_10 m_xs_left_0 f_xs_none">
                                        <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Tops</b>
                                        <ul class="sub_menu">
                                            <li><a href="#" class="color_dark tr_delay_hover">Evening Tops</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Long Sleeved</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Short Sleeved</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Sleeveless</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Tanks</a></li>
                                            <li><a href="#" class="color_dark tr_delay_hover">Tunics</a></li>
                                        </ul>
                                    </div>
                                    <img alt="" class="d_sm_none f_right m_bottom_10" src="images/woman_image_1.jpg">
                                </div>
                                *}

                        {/if}
                    </li>
                {/foreach}
                {*
                <li class="current relative f_xs_none m_xs_bottom_5">
                    <a href="index.html" class="tr_delay_hover color_light tt_uppercase"><b>Home</b></a>
                    <!--sub menu-->
                    <div class="sub_menu_wrap top_arrow d_xs_none type_2 tr_all_hover clearfix r_corners">
                        <ul class="sub_menu">
                            <li><a class="color_dark tr_delay_hover" href="index.html">Home Variant 1</a></li>
                            <li><a class="color_dark tr_delay_hover" href="index_layout_2.html">Home Variant 2</a></li>
                            <li><a class="color_dark tr_delay_hover" href="index_layout_wide.html">Home Variant 3</a></li>
                            <li><a class="color_dark tr_delay_hover" href="index_corporate.html">Home Variant 4</a></li>
                        </ul>
                    </div>
                </li>
                <li class="relative f_xs_none m_xs_bottom_5"><a href="#" class="tr_delay_hover color_light tt_uppercase"><b>Offerta formativa</b></a>
                    <!--sub menu-->
                    <div class="sub_menu_wrap top_arrow d_xs_none type_2 tr_all_hover clearfix r_corners">
                        <ul class="sub_menu">
                            <li><a class="color_dark tr_delay_hover" href="index_layout_wide.html">Revolution Slider</a></li>
                            <li><a class="color_dark tr_delay_hover" href="index.html">Camera Slider</a></li>
                            <li><a class="color_dark tr_delay_hover" href="index_layout_2.html">Flex Slider</a></li>
                        </ul>
                    </div>
                </li>
                <li class="relative f_xs_none m_xs_bottom_5"><a href="category_grid.html" class="tr_delay_hover color_light tt_uppercase"><b>In evidenza</b></a>
                    <!--sub menu-->
                    <div class="sub_menu_wrap top_arrow d_xs_none tr_all_hover clearfix r_corners w_xs_auto">
                        <div class="f_left f_xs_none">
                            <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Dresses</b>
                            <ul class="sub_menu first">
                                <li><a class="color_dark tr_delay_hover" href="#">Evening Dresses</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Casual Dresses</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Party Dresses</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Maxi Dresses</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Midi Dresses</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Strapless Dresses</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Day Dresses</a></li>
                            </ul>
                        </div>
                        <div class="f_left m_left_10 m_xs_left_0 f_xs_none">
                            <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Accessories</b>
                            <ul class="sub_menu">
                                <li><a class="color_dark tr_delay_hover" href="#">Bags and Purces</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Belts</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Scarves</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Gloves</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Jewellery</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Sunglasses</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Hair Accessories</a></li>
                            </ul>
                        </div>
                        <div class="f_left m_left_10 m_xs_left_0 f_xs_none">
                            <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Tops</b>
                            <ul class="sub_menu">
                                <li><a class="color_dark tr_delay_hover" href="#">Evening Tops</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Long Sleeved</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Short Sleeved</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Sleeveless</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Tanks</a></li>
                                <li><a class="color_dark tr_delay_hover" href="#">Tunics</a></li>
                            </ul>
                        </div>
                        <img src="{'woman_image_1.jpg'|ezimage('no')}" class="d_sm_none f_right m_bottom_10" alt="">
                    </div>
                </li>
                <li class="relative f_xs_none m_xs_bottom_5"><a href="#" class="tr_delay_hover color_light tt_uppercase"><b>News</b></a>
                    <!--sub menu-->
                    <div class="sub_menu_wrap top_arrow d_xs_none type_2 tr_all_hover clearfix r_corners">
                        <ul class="sub_menu">
                            <li><a class="color_dark tr_delay_hover" href="portfolio_two_columns.html">Portfolio 2 Columns</a></li>
                            <li><a class="color_dark tr_delay_hover" href="portfolio_three_columns.html">Portfolio 3 Columns</a></li>
                            <li><a class="color_dark tr_delay_hover" href="portfolio_four_columns.html">Portfolio 4 Columns</a></li>
                            <li><a class="color_dark tr_delay_hover" href="portfolio_masonry.html">Masonry Portfolio</a></li>
                            <li><a class="color_dark tr_delay_hover" href="portfolio_single_1.html">Single Portfolio Post v1</a></li>
                            <li><a class="color_dark tr_delay_hover" href="portfolio_single_2.html">Single Portfolio Post v2</a></li>
                        </ul>
                    </div>
                </li>
                <li class="relative f_xs_none m_xs_bottom_5"><a href="category_grid.html" class="tr_delay_hover color_light tt_uppercase"><b>Chi siamo</b></a>
                    <!--sub menu-->
                    <div class="sub_menu_wrap top_arrow d_xs_none type_2 tr_all_hover clearfix r_corners">
                        <ul class="sub_menu">
                            <li><a class="color_dark tr_delay_hover" href="category_grid.html">Grid View Category Page</a></li>
                            <li><a class="color_dark tr_delay_hover" href="category_list.html">List View Category Page</a></li>
                            <li><a class="color_dark tr_delay_hover" href="category_no_products.html">Category Page Without Products</a></li>
                            <li><a class="color_dark tr_delay_hover" href="product_page_sidebar.html">Product Page With Sidebar</a></li>
                            <li><a class="color_dark tr_delay_hover" href="full_width_product_page.html">Full Width Product Page</a></li>
                            <li><a class="color_dark tr_delay_hover" href="wishlist.html">Wishlist</a></li>
                            <li><a class="color_dark tr_delay_hover" href="compare_products.html">Compare Products</a></li>
                            <li><a class="color_dark tr_delay_hover" href="checkout.html">Checkout</a></li>
                            <li><a class="color_dark tr_delay_hover" href="manufacturers.html">Manufacturers</a></li>
                            <li><a class="color_dark tr_delay_hover" href="manufacturer_details.html">Manufacturer Page</a></li>
                            <li><a class="color_dark tr_delay_hover" href="orders_list.html">Orders List</a></li>
                            <li><a class="color_dark tr_delay_hover" href="order_details.html">Order Details</a></li>
                        </ul>
                    </div>
                </li>*}
            </ul>
        </nav>
        {/if}
        <ul class="f_right horizontal_list clearfix t_align_l t_xs_align_c site_settings d_xs_inline_b f_xs_none">
            <!--links-->
            <li class="relative d_sm_none d_xs_block">
                <span class="tooltip tr_all_hover r_corners color_dark f_size_small">Webz</span>
                <a role="button" href="http://webz.it/" target="_blank" class="button_type_17 color_light d_block bg_dark_color_1 r_corners tr_delay_hover box_s_none"><b>WEBZ</b></a>
            </li>
            <li class="relative m_left_5 d_sm_none d_xs_block">
                <span class="tooltip tr_all_hover r_corners color_dark f_size_small">RadioUPAD</span>
                <a role="button" href="http://radioupad.altervista.org/blog/" target="_blank" class="button_type_17 color_light d_block bg_dark_color_1 r_corners tr_delay_hover box_s_none"><b>RadioUPAD</b></a>
            </li>
            <li class="relative m_left_5 d_sm_none d_xs_block">
                <span class="tooltip tr_all_hover r_corners color_dark f_size_small">Studiare a..</span>
                <a role="button" href="http://www.inncampus.it/" target="_blank" class="button_type_17 color_light d_block bg_dark_color_1 r_corners tr_delay_hover box_s_none"><b>INNCAMPUS</b></a>
            </li>
            <!--like-->
            <li class="relative m_left_5 d_sm_none d_xs_block">
                <span class="tooltip tr_all_hover r_corners color_dark f_size_small">Facebook</span>
                <a role="button" href="https://www.facebook.com/upadbz" target="_blank" class="button_type_17 color_dark d_block bg_light_color_1 r_corners tr_delay_hover box_s_none"><i class="fa fa-facebook f_size_ex_large"></i></a>
            </li>
            <li class="relative m_left_5 d_sm_none d_xs_block">
                <span class="tooltip tr_all_hover r_corners color_dark f_size_small">Rss</span>
                <a role="button" href="#" class="button_type_17 color_dark d_block bg_light_color_1 r_corners tr_delay_hover box_s_none"><i class="fa fa-rss f_size_ex_large"></i></a>
            </li>
            <!--shopping cart-->
            {*
            <div class="sub_menu_wrap top_arrow d_xs_none tr_all_hover clearfix r_corners w_xs_auto">
                <div class="f_left f_xs_none">
                    <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Dresses</b>
                    <ul class="sub_menu first">
                        <li><a href="#" class="color_dark tr_delay_hover">Evening Dresses</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Casual Dresses</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Party Dresses</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Maxi Dresses</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Midi Dresses</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Strapless Dresses</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Day Dresses</a></li>
                    </ul>
                </div>
                <div class="f_left m_left_10 m_xs_left_0 f_xs_none">
                    <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Accessories</b>
                    <ul class="sub_menu">
                        <li><a href="#" class="color_dark tr_delay_hover">Bags and Purces</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Belts</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Scarves</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Gloves</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Jewellery</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Sunglasses</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Hair Accessories</a></li>
                    </ul>
                </div>
                <div class="f_left m_left_10 m_xs_left_0 f_xs_none">
                    <b class="color_dark m_left_20 m_bottom_5 m_top_5 d_inline_b">Tops</b>
                    <ul class="sub_menu">
                        <li><a href="#" class="color_dark tr_delay_hover">Evening Tops</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Long Sleeved</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Short Sleeved</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Sleeveless</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Tanks</a></li>
                        <li><a href="#" class="color_dark tr_delay_hover">Tunics</a></li>
                    </ul>
                </div>
                <img alt="" class="d_sm_none f_right m_bottom_10" src="images/woman_image_1.jpg">
            </div>
            *}
        </ul>
    </section>
</div>
