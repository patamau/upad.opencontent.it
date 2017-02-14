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
        <section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">
            <div class="clearfix m_bottom_25 m_sm_bottom_20">
                <h2 class="tt_uppercase color_dark m_bottom_25">{$node.name|wash()}</h2>
                <!--<img class="r_corners m_bottom_40" src="images/temp/offerta-formativa-lista.jpg" alt="">-->
                {include uri='design:atoms/image.tpl' item=$node image_class='original' css_class='r_corners m_bottom_40'}
            </div>
            {if $node|has_attribute( 'description' )}
                <div class="clearfix m_bottom_25 description">
                    {attribute_view_gui attribute=$node|attribute( 'description' )}
                </div>
            {/if}
            {include uri='design:parts/children.tpl' view='line'}
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
