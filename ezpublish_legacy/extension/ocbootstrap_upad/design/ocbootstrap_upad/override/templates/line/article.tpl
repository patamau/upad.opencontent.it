<article class="m_bottom_20 r_corners photoframe tr_all_hover type_2 shadow relative clearfix">
    <a class="d_block d_xs_inline_b f_xs_none wrapper shadow f_left m_right_20 m_bottom_10" href="{$node.url_alias|ezurl( 'no' )}">
        {include uri='design:atoms/image.tpl' item=$node image_class='articlethumbnail' css_class='tr_all_hover'}
    </a>
    <div class="mini_post_content">
        <h4 class="m_bottom_5"><a class="color_dark fw_medium" href="{$node.url_alias|ezurl( 'no' )}">{$node.name|wash}</a></h4>
        <h6 class="color_dark fw_medium m_bottom_10">{attribute_view_gui attribute=$node|attribute( 'short_title' )}</h6>
        <p class="f_size_medium m_bottom_10">{$node.data_map.publish_date.content.timestamp|datetime( 'custom', '%d %F %Y' )}</p>
        <hr class="m_bottom_15">
        <div class="m_bottom_10 abstract">
            {attribute_view_gui attribute=$node|attribute( 'intro' )}
        </div>
        <div class="f_right f_sm_none t_align_r t_sm_align_l">
            <a href="{$node.url_alias|ezurl( 'no' )}" class="button_type_18 bg_light_color_2 r_corners tr_all_hover color_dark mw_0 m_bottom_10 m_sm_bottom_0 d_sm_inline_middle"><i class="fa fa-info-circle m_right_5"></i> <span class="f_size_small">Maggiori informazioni</span></a>
        </div>
    </div>
</article>

{*
<div class="content-view-line class-{$node.class_identifier} media">
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  <a href={$node.url_alias|ezurl}>{$node.name|wash()}</a>
	  <span class="label label-primary">
		<span class="glyphicon glyphicon-comment"></span>
		{fetch( 'comment', 'comment_count', hash( 'contentobject_id', $node.contentobject_id,
												  'language_id', $node.data_map.comments.language_id,
												  'status', '1' ) )}
	  </span>
	  <small class="date">{$node.object.published|l10n( 'date' )}
	  {if $node.data_map.author.content.is_empty|not()}
         {attribute_view_gui attribute=$node.data_map.author}
	  {/if}
	  </small>
	</h4>

	{if $node.data_map.intro.content.is_empty|not}
	 {attribute_view_gui attribute=$node.data_map.intro}
	{/if}

  </div>
</div>
*}
