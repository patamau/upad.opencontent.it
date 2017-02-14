{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}
  <div class="content-view-block carousel-container">
    {include uri='design:atoms/carousel.tpl'
    items=$valid_nodes
    root_node=$valid_nodes[0].parent
    title=$block.name
    autoplay=1
    controls=true()
    indicators= true()
    interval=10000
    }
  </div>
{/if}

{undef $valid_nodes}