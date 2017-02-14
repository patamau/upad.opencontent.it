<h2 class="block-title"><a href="{$node.url_alias|ezurl(no)}">{$node.name|wash()}</a></h2>
{*if $node.data_map.image.has_content }
  {attribute_view_gui attribute=$node.data_map.image image_class=appini( 'ContentViewBlock', 'DefaultImageClass', 'wide' ) fluid=true() href=$node.url_alias}
{/if*}
{if $node|has_abstract()}
  {$node|abstract()|oc_shorten(100)}
  <p class="goto"><a href="{$node.url_alias|ezurl(no)}">Leggi tutto</a></p>
{/if}