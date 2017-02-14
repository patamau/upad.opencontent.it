{* Documentation page - Full view *}
{* Article - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    <div class="info">
      <span class="published">{'Created:'|i18n( 'design/ocbootstrap/full/wiki_page' )} {$node.object.published|l10n(shortdatetime)}</span>
      <span class="modified">{'Modified:'|i18n( 'design/ocbootstrap/full/wiki_page' )} {$node.object.modified|l10n(shortdatetime)}</span>
    </div>
    
    {if $node|has_attribute( 'body' )}
      {def $toc = eztoc( $node.object.data_map.body )}
      {if $toc}        
        <div class="col-md-4 pull-right well">
          <h2>{'Table of contents'|i18n( 'design/ocbootstrap/full/wiki_page' )}</h2>
            {$toc}
        </div>
      {/if}
    
    
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'body' )}
      </div>
    {/if}
    
    {include uri='design:parts/children.tpl' view='line'}
	
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
