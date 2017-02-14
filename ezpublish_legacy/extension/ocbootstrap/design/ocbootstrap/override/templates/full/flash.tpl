{* Flash - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    	
    {if $node|has_attribute( 'file' )}
      <div class="content-media">
      {def $attribute=$node.data_map.file}
        <object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0"
                {section show=$attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/section} {section show=$attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/section} id="objectid{$node.object.id}">
          <param name="movie" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />
          <param name="quality" value="{$attribute.content.quality}" />
          <param name="play" value="{section show=$attribute.content.is_autoplay}true{/section}" />
          <param name="loop" value="{section show=$attribute.content.is_loop}true{/section}" />
          <embed src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
                 type="application/x-shockwave-flash"
                 quality="{$attribute.content.quality}" pluginspage="{$attribute.content.pluginspage}"
                 {section show=$attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/section} {section show=$attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/section} play="{section show=$attribute.content.is_autoplay}true{/section}"
                 loop="{section show=$attribute.content.is_loop}true{/section}" name="objectid{$node.object.id}">
          </embed>
          </object>
      </div>
    {/if}
    
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
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