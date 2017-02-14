<div class="content-view-embed">
    <div class="class-image">
        <div class="attribute-image">
            {if is_set( $link_parameters.href )}{attribute_view_gui attribute=$object.data_map.image alignment=cond($object_parameters.align|ne(''),$object_parameters.align,'center') image_class=$object_parameters.size href=$link_parameters.href|ezurl target=$link_parameters.target link_class=first_set( $link_parameters.class, '' ) link_id=first_set( $link_parameters['xhtml:id'], '' ) link_title=first_set( $link_parameters['xhtml:title'], '' )}{else}{attribute_view_gui attribute=$object.data_map.image image_class=$object_parameters.size alignment=cond($object_parameters.align|ne(''),$object_parameters.align,'center')}{/if}
        </div>
    {if $object.data_map.caption.has_content}
        {if is_set( $object.data_map.image.content[$object_parameters.size].width )}
            {def $image_width = $object.data_map.image.content[$object_parameters.size].width}
            {if is_set($object_parameters.margin_size)}
                {set $image_width = $image_width|sum(  $object_parameters.margin_size|mul( 2 ) )}
            {/if}
            {if is_set($object_parameters.border_size)}
                {set $image_width = $image_width|sum(  $object_parameters.border_size|mul( 2 ) )}
            {/if}
        <div class="attribute-caption" style="width: {$image_width}px">
            {else}
        <div class="attribute-caption">
        {/if}
            {attribute_view_gui attribute=$object.data_map.caption}
        </div>
    {/if}
    </div>
</div>
