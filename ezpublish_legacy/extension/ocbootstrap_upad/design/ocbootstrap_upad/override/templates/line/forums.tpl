{* Forums - Line view *}

<div class="content-view-line class-{$node.class_identifier} media">    
  <div class="media-body">
        <h4><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h4>

       {section show=$node.data_map.description.content.is_empty|not}
        <div class="attribute-short">
        {attribute_view_gui attribute=$node.data_map.description}
        </div>
       {/section}

    </div>
</div>
