{def $valid_node = $block.valid_nodes[0]}
{*def $image = false()}
{if valid_node|has_attribute( 'image' ) }
  {set $image =  valid_node|attribute( 'image' )}
{else}
  {def $related = fetch( 'content', 'related_objects', hash( 'object_id', valid_node.contentobject_id ))}
  {foreach $related as $rel}
    {if $rel.class_identifier|eq( 'image' )}
      {set $image = $rel|attribute( 'image' )}
    {/if}
  {/foreach}
{/if*}

<div class="content-view-block block-view-{$block.view}">

  {node_view_gui content_node=$valid_node view="main_story_item"}

</div>

{undef}