{if $node.data_map.image.content[$image_class]}
  {def $image = $node.data_map.image.content[$image_class]}
  <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" />
  {undef $image}
{/if}
<div class="carousel-caption">
  <h3><a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a></h3>
  {if $node.data_map.abstract.has_content}
    {attribute_view_gui attribute=$node.data_map.abstract}
  {/if}
</div>