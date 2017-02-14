{set-block scope=root variable=cache_ttl}600{/set-block}
{* Event - Full view *}

<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    <div class="info">
      {include uri='design:parts/date.tpl'}    
      {include uri='design:parts/author.tpl'}
    </div>
    
    {if $node|has_attribute( 'text' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'text' )}
      </div>
    {/if}	 
    
  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}
  
</div>
