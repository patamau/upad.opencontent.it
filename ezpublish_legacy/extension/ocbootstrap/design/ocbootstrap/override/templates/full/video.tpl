{def $video_path = concat( '/content/download/', $node.data_map.file.contentobject_id, '/', $node.data_map.file.id, '/', $node.data_map.file.content.original_filename )|ezurl( 'no', 'full' )}
{ezcss_require( 'video.css' )}
{ezscript_require( 'video.js' )}
<script>
    _V_.options.flash.swf = "{'flash/video-js.swf'|ezdesign( 'no' )}"
</script>

<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'intro' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'intro' )}
      </div>
    {/if}
    
     <div class="attribute-video">
      <video id="video_{$node.contentobject_id}" class="video-js vjs-default-skin" controls preload="auto" width="770" height="318" poster="" data-setup="{ldelim}{rdelim}">
        <source src="{$video_path}" type="video/mp4" />
      </video>
    </div>
     
    <div class="download">
      <p><a class="btn btn-mini btn-warning pull-right" href="{$video_path|ezurl( 'no' )}">{'Download'|i18n( 'design/ocbootstrap/full/video' )}</a></p>
    </div>
	
    {if $node|has_attribute( 'caption' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'caption' )}
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

</div>
{undef $video_path}