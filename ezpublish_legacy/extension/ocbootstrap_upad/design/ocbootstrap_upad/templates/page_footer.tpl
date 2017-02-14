{def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )
     $top_menu_class_filter = ezini( 'MenuContentSettings', 'TopIdentifierList', 'app.ini' )
     $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                       'sort_by', $root_node.sort_array,
                                                       'class_filter_type', 'include',
                                                       'class_filter_array', $top_menu_class_filter ))
     $footer_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'FooterNodeID', 'content.ini' )))
}
<footer id="footer" class="type_2">
    <div class="footer_top_part">
        <div class="container">
            <div class="row clearfix">
                <div class="col-lg-3 col-md-3 col-sm-3 m_xs_bottom_30">
                    <h3 class="color_light_2 m_bottom_20">UPAD</h3>
                    {attribute_view_gui attribute=$footer_node.data_map.intro}
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3">
                    <h3 class="tt_uppercase color_light_2 m_bottom_20">Contatti</h3>
                    <ul class="c_info_list">
                        <li class="m_bottom_10">
                            <div class="clearfix m_bottom_15">
                                <i class="fa fa-map-marker f_left"></i>
                                <p class="contact_e">Sede principale<br> Via Firenze 51, 39100, Bolzano</p>
                            </div>
                        </li>
                        <li class="m_bottom_10">
                            <div class="clearfix m_bottom_10">
                                <i class="fa fa-phone f_left"></i>
                                <p class="contact_e">0471 921023 – 0471 933108</p>
                            </div>
                        </li>
                        <li class="m_bottom_10">
                            <div class="clearfix m_bottom_10">
                                <i class="fa fa-envelope f_left"></i>
                                <a class="contact_e color_light" href="mailto:info@upad.it">info@upad.it</a>
                            </div>
                        </li>
                        <li>
                            <div class="clearfix">
                                <i class="fa fa-clock-o f_left"></i>
                                <p class="contact_e">Lunedì / Venerdì: <br>9.00 / 12.00<br> 15.15 / 18.00</p>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 m_xs_bottom_30">
                    <h3 class="tt_uppercase color_light_2 m_bottom_20">Menù</h3>
                    <ul class="vertical_list">
                        {foreach $top_menu_items as $key => $item}
                            <li><a class="color_light tr_delay_hover" href="{$item.url_alias|ezurl('no')}">{$item.name|wash}<i class="fa fa-angle-right"></i></a></li>
                        {/foreach}
                    </ul>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 m_xs_bottom_30">
                    <h3 class="color_light_2 m_bottom_20">FLASH NEWS</h3>
                    {attribute_view_gui attribute=$footer_node.data_map.body}
                </div>
                {*
                <div class="col-lg-3 col-md-3 col-sm-3 m_xs_bottom_30">
                    <h3 class="tt_uppercase color_light_2 m_bottom_20">Newsletter</h3>
                    <p class="f_size_medium m_bottom_15">Sign up to our newsletter and get exclusive deals you wont find anywhere else straight to your inbox!</p>
                    <form id="newsletter">
                        <input type="email" placeholder="Your email address" class="m_bottom_20 r_corners f_size_medium full_width" name="newsletter-email">
                        <button type="submit" class="button_type_8 r_corners bg_scheme_color color_light tr_all_hover">Subscribe</button>
                    <div class="message_container_subscribe d_none m_top_20"></div></form>
                </div>
                *}
            </div>
        </div>
    </div>
    <!--copyright part-->
    <div class="footer_bottom_part">
        <div class="container clearfix t_mxs_align_c">
            <p class="f_left f_mxs_none m_mxs_bottom_10">&copy; 2014 <span class="color_light">UPAD</span></p>
            <ul class="f_left horizontal_list clearfix users_nav m_left_10">
                <li><a class="color_light_2" href="{'/Contatti'|ezurl( 'no' )}">Contatti</a></li>
                <li><a class="color_light_2" href="#">Link utili</a></li>
                <li><a class="color_light_2" href="{'/content/view/sitemap/2'|ezurl( 'no' )}">Mappa del sito</a></li>
                <li><a class="color_light_2" href="{'/Privacy'|ezurl( 'no' )}">Privacy</a></li>
                <li><a class="color_light_2" href="{'/Note-legali'|ezurl( 'no' )}">Note legali</a></li>
                <li><a class="color_light_2" href="{'/Condizioni-di-vendita'|ezurl( 'no' )}">Condizioni di vendita</a></li>
                <li><a class="color_light_2" href="{'/Regolamento'|ezurl( 'no' )}">Regolamento</a></li>
            </ul>
            <ul class="f_right horizontal_list clearfix social_icons">
                <li class="facebook m_bottom_5 relative">
                    <span class="tooltip tr_all_hover r_corners color_dark f_size_small">Facebook</span>
                    <a href="https://it-it.facebook.com/FondazioneUpad" target="_blank" class="r_corners t_align_c tr_delay_hover f_size_ex_large">
                        <i class="fa fa-facebook"></i>
                    </a>
                </li>
                <li class="rss m_left_5 m_bottom_5 relative">
                    <span class="tooltip tr_all_hover r_corners color_dark f_size_small">Rss</span>
                    <a href="#" class="r_corners f_size_ex_large t_align_c tr_delay_hover">
                        <i class="fa fa-rss"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</footer>


<!-- Footer area: START -->
{*def $footer_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'FooterSettings', 'NodeID', 'content.ini' ) ) )}
<footer>
    {if $footer_node}
    <div class="container">
        <div class="row">
            <div class="span4">
                {include uri='design:footer/address.tpl' node=$footer_node}
            </div>
            <div class="span4 nav-collapse">
                {include uri='design:footer/latest_news.tpl'}
            </div>
            <div class="span4 nav-collapse">
                {include uri='design:footer/links.tpl' node=$footer_node}
            </div>
        </div>
    </div>
    {/if}
</footer>
<!-- Footer area: END -->
{undef $footer_node*}
