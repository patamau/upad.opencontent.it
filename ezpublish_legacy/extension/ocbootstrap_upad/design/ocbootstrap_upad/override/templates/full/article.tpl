{def $is_ente = false()
     $ente = 0}

{foreach $node.path as $p}
    {if eq($p.class_identifier, 'ente')}
        {set $is_ente = true()
             $ente = $p}
        {break}
    {/if}
{/foreach}

<div class="container{if $is_ente} ente ente_{$ente.node_id}{/if}">
    <div class="row clearfix">
        <section class="col-lg-9 col-md-9 col-sm-9 m_xs_bottom_30">
            <div class="clearfix m_bottom_30 t_xs_align_c">
               {if $node|has_attribute( 'image' )}
                    <div class="photoframe type_2 shadow r_corners f_left f_sm_none d_xs_inline_b product_single_preview relative m_right_30 m_bottom_5 m_sm_bottom_20 m_xs_right_0 w_mxs_full">
                        <!--<img alt="" class="tr_all_hover" data-zoom-image="images/preview_zoom_1.jpg" src="images/quick_view_img_7.jpg" id="zoom_image">-->
                        {include uri='design:atoms/image.tpl' item=$node image_class='productimage' css_class='tr_all_hover'}
                    </div>
               {/if}
                <div class="p_top_10 t_xs_align_l">
                    <!--description-->
                    <h2 class="color_dark fw_medium m_bottom_10">{attribute_view_gui attribute=$node|attribute( 'title' )}</h2>
                    <h4 class="color_dark fw_medium m_bottom_10">{attribute_view_gui attribute=$node|attribute( 'short_title' )}</h4>
                    <hr class="m_bottom_10 divider_type_3">
                    <div class="m_bottom_20 description">
                        {attribute_view_gui attribute=$node|attribute( 'body' )}
                    </div>

                    <p class="d_inline_middle">Share this:</p>
                    <div class="d_inline_middle m_left_5 addthis_widget_container">
                        <!-- AddThis Button BEGIN -->
                        <div class="addthis_toolbox addthis_default_style addthis_32x32_style">
                        <a class="addthis_button_facebook addthis_button_preferred_1 at300b" title="Facebook" href="#"><span class=" at300bs at15nc at15t_facebook"><span class="at_a11y">Share on facebook</span></span></a>
                        <a class="addthis_button_twitter addthis_button_preferred_2 at300b" title="Tweet" href="#"><span class=" at300bs at15nc at15t_twitter"><span class="at_a11y">Share on twitter</span></span></a>
                        <a class="addthis_button_email addthis_button_preferred_3 at300b" target="_blank" title="Email" href="#"><span class=" at300bs at15nc at15t_email"><span class="at_a11y">Share on email</span></span></a>
                        <a class="addthis_button_print addthis_button_preferred_4 at300b" title="Print" href="#"><span class=" at300bs at15nc at15t_print"><span class="at_a11y">Share on print</span></span></a>
                        <a class="addthis_button_compact at300m" href="#"><span class=" at300bs at15nc at15t_compact"><span class="at_a11y">More Sharing Services</span></span></a>
                        <a class="addthis_counter addthis_bubble_style"></a>
                        <div class="atclear"></div></div>
                        <!-- AddThis Button END -->
                    </div>
                </div>
            </div>
        </section>
        <!-- sidebar -->
        {include uri='design:page_sidebar.tpl'}
    </div>
</div>

<!-- Partner -->
{include uri='design:parts/partner.tpl'}


{* Article - Full view *}
{*
<div class="content-view-full class-{$node.class_identifier} row">

  {include uri='design:nav/nav-section.tpl'}

  <div class="content-main">

    <h1>{$node.name|wash()}</h1>

    {if $node|has_attribute( 'intro' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'intro' )}
      </div>
    {/if}

    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' )}

    {if $node|has_attribute( 'body' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'body' )}
      </div>
    {/if}

    {if $node|has_attribute( 'tags' )}
      <div class="tags">
        {attribute_view_gui attribute=$node|attribute( 'tags' )}
      </div>
    {/if}

    {if $node|has_attribute( 'star_rating' )}
      <div class="rating">
        {attribute_view_gui attribute=$node|attribute( 'star_rating' )}
      </div>
    {/if}

    {include uri='design:parts/social_buttons.tpl'}

    {if $node|has_attribute( 'comments' )}
      <div class="comments">
        {attribute_view_gui attribute=$node|attribute( 'comments' )}
      </div>
    {/if}

  </div>

  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

{*
</div>
*}
