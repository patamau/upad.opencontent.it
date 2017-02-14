{def $nodes=fetch('content','list',
                   hash(
                       'parent_node_id', 2,
                       'sort_by', $node.parent.sort_array,
                       class_filter_type, "include",
                       class_filter_array, array('area_tematica'),
                       'depth', 3))}

<div class="container">
    <div class="row clearfix">
        <section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">
            <div class="clearfix m_bottom_25 m_sm_bottom_20">
                <h2 class="tt_uppercase color_dark m_bottom_25">{$node.name|wash()}</h2>
                {include uri='design:atoms/image.tpl' item=$node image_class='original' css_class='r_corners m_bottom_40'}
            </div>
            {if $node|has_attribute( 'description' )}
                <div class="clearfix m_bottom_25 m_sm_bottom_20">
                    {attribute_view_gui attribute=$node|attribute( 'description' )}
                </div>
            {/if}
            <h2 class="tt_uppercase color_dark m_bottom_25">Argomenti</h2>

            <ul class="horizontal_list clearfix arguments_nav_list m_xs_right_0 t_mxs_align_c">
                {foreach $nodes as $key => $value}
                    <li class="relative f_mxs_none w_mxs_auto d_mxs_inline_b">
                        {*<span class="tooltip tr_all_hover r_corners color_dark f_size_small">{$value.name|wash()}</span>*}
                        <a class="d_block tr_all_hover color_dark r_corners bg_scheme_color" href="{$value.url_alias|ezurl( 'no' )}">
                            <span class="d_block wrapper">
                                {*<span class="d_block label">{$value.name|wash()}</span>*}
                                {attribute_view_gui image_class=original attribute=$value.data_map.icon}
                            </span>
                        </a>
                    </li>
                {/foreach}
            </ul>
        </section>

        <!-- sidebar -->
        {include uri='design:page_sidebar.tpl'}
    </div>
</div>

<!-- Partner -->
{include uri='design:parts/partner.tpl'}


{*<div class="content-view-full class-folder row">

  {include uri='design:nav/nav-section.tpl'}

  <div class="content-main">

    <h1>{$node.name|wash()}</h1>

    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
      {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}

	{if $node|has_attribute( 'tags' )}
    <div class="tags">
      {foreach $node.data_map.tags.content.keywords as $keyword}
		<span class="label label-primary">{$keyword}</span>
	  {/foreach}
    </div>
    {/if}

    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' )}

    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}

    {include uri='design:parts/children.tpl' view='line'}

  </div>

  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}
{*
</div>
*}
