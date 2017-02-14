{def $video_path = concat( '/content/download/', $node.data_map.file.contentobject_id, '/', $node.data_map.file.id, '/', $node.data_map.file.content.original_filename )|ezurl( 'no', 'full' )}

{ezcss_require( 'video.css' )}
{ezscript_require( 'video.js' )}

<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  <a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
	</h4>
	
	<p><a class="btn btn-sm center-block" href={$node.url_alias|ezurl}>{"View movie"|i18n("design/ocbootstrap/line/silverlight")}</a></p>

    <video id="video_{$node.contentobject_id}" class="video-js vjs-default-skin" controls preload="auto" width="100%" height="113" poster="" data-setup="">
	  <source src="{$video_path}" type="video/mp4" />
	</video>

    </div>
</div>

{undef $video_path}
