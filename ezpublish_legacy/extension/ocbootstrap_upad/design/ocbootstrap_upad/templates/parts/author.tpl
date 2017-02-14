{if $node|has_attribute( 'author' )}
  <span class="author">
    {attribute_view_gui attribute=$node|attribute( 'author' )}
  </span>
{else}
  <span class="author text-muted">
    {$node.object.owner.name|wash()}
  </span>
{/if}