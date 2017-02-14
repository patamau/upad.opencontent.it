{* Banner - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}

  {def $size = "original"
       $alternative_text = $node.object.data_map.name.content}

  {if is_set( $node.object.data_map.image.content[$size].alternative_text )}
      {set $alternative_text = $node.object.data_map.image.content[$size].alternative_text}
  {/if}

  {if eq( $node.object.data_map.image_map.content, true() )}
      <img usemap="#banner_map" src={$node.object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$node.object.data_map.image.content[$size].width}" height="{$node.object.data_map.image.content[$size].height}" />
      {$node.object.data_map.image_map.content}
  {else}
      {if $node.object.data_map.url.content}
          <a href={$node.object.data_map.url.content|ezurl}>
              <img src={$node.object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$node.object.data_map.image.content[$size].width}" height="{$node.object.data_map.image.content[$size].height}" />
          </a>
      {else}
          <img src={$node.object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$node.object.data_map.image.content[$size].width}" height="{$node.object.data_map.image.content[$size].height}" />
      {/if}
  {/if}
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>
