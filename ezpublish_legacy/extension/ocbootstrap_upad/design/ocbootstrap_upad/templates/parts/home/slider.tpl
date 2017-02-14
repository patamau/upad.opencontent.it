{def $slides_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'SliderNodeID', 'content.ini' ) ) )
     $banners=fetch('content','list',
        hash(
            'parent_node_id', $slides_node.node_id,
            'sort_by', $slides_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('banner')))}



<div class="clearfix m_bottom_45 m_sm_bottom_35 flexslider">
    <ul class="slides">
        {foreach $banners as $k => $v}
            <li>
                {*include uri='design:atoms/image.tpl' item=$v image_class='imagefull'*}
                {attribute_view_gui image_class=original attribute=$v.data_map.image}
                <section class="slide_caption t_align_c d_xs_none">
                    <div class="f_size_large color_light tt_uppercase slider_title_3 m_bottom_10">{$v.name|wash()}</div>
                    <hr class="slider_divider d_inline_b m_bottom_10">
                    {if ne($v.object.data_map.short_title.content, '')}
                        <div class="color_light slider_title_4 tt_uppercase t_align_c m_bottom_45 m_md_bottom_20">
                            <b>{attribute_view_gui attribute=$v.data_map.short_title}</b>
                        </div>
                    {/if}

                    {if ne($v.object.data_map.url.content, '')}
                        <a href="{$v.object.data_map.url.content}" role="button" class="d_sm_inline_b button_type_4 bg_scheme_color color_light r_corners tt_uppercase tr_all_hover">Leggi tutto</a>
                    {/if}
                </section>
            </li>
        {/foreach}
        {*
        <li>
                <img src="http://localhost/upad/ezpublish_legacy/extension/ocbootstrap_upad/design/ocbootstrap_upad/images/slide_04.jpg" alt="" data-custom-thumb="http://localhost/upad/ezpublish_legacy/extension/ocbootstrap_upad/design/ocbootstrap_upad/images/slide_01.jpg">
                <section class="slide_caption t_align_c d_xs_none">
                    <div class="f_size_large color_light tt_uppercase slider_title_3 m_bottom_10">Meet New Theme</div>
                    <hr class="slider_divider d_inline_b m_bottom_10">
                    <div class="color_light slider_title_4 tt_uppercase t_align_c m_bottom_45 m_md_bottom_20"><b>Attractive &amp; Elegant<br>HTML Theme</b></div>
                    <div class="color_light slider_title_2 m_bottom_45 m_sm_bottom_20">$<b>15.00</b></div>
                    <a href="#" role="button" class="d_sm_inline_b button_type_4 bg_scheme_color color_light r_corners tt_uppercase tr_all_hover">Buy Now</a>
                </section>
            </li>
        <li>
            <img src="http://localhost/upad/ezpublish_legacy/extension/ocbootstrap_upad/design/ocbootstrap_upad/images/slide_05.jpg" alt="" data-custom-thumb="http://localhost/upad/ezpublish_legacy/extension/ocbootstrap_upad/design/ocbootstrap_upad/images/slide_03.jpg">
            <section class="slide_caption_2 t_align_c d_xs_none">
                <div class="f_size_large tt_uppercase slider_title_3 scheme_color">New arrivals</div>
                <hr class="slider_divider type_2 m_bottom_5 d_inline_b">
                <div class="color_light slider_title_4 tt_uppercase t_align_c m_bottom_65 m_sm_bottom_20"><b><span class="scheme_color">Spring/Summer 2014</span><br><span class="color_dark">Ready-To-Wear</span></b></div>
                <a href="#" role="button" class="d_sm_inline_b button_type_4 bg_scheme_color color_light r_corners tt_uppercase tr_all_hover">View Collection</a>
            </section>
        </li>
        <li>
            <img src="http://localhost/upad/ezpublish_legacy/extension/ocbootstrap_upad/design/ocbootstrap_upad/images/slide_06.jpg" alt="" data-custom-thumb="http://localhost/upad/ezpublish_legacy/extension/ocbootstrap_upad/design/ocbootstrap_upad/images/slide_02.jpg">
            <section class="slide_caption_3 t_align_c d_xs_none">
                <img src="http://localhost/upad/ezpublish_legacy/extension/ocbootstrap_upad/design/ocbootstrap_upad/images/slider_layer_img.png" alt="" class="m_bottom_5">
                <div class="color_light slider_title tt_uppercase t_align_c m_bottom_60 m_sm_bottom_20"><b class="color_dark">up to 70% off</b></div>
                <a href="#" role="button" class="d_sm_inline_b button_type_4 bg_scheme_color color_light r_corners tt_uppercase tr_all_hover">Shop Now</a>
            </section>
        </li>
            *}
    </ul>
</div>

{undef $slides_node $banners}
