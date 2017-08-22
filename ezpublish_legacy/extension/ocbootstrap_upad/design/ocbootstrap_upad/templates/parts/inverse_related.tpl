{set_defaults( hash(
  'page_limit', 10,
  'view', 'line',
  'delimiter', '',
  'parent_node', $node
))}

<div class="clearfix m_bottom_25 m_sm_bottom_20">
    {if $node|has_attribute( 'short_name' )}
    <h2 class="tt_uppercase color_dark m_bottom_25">{$node.data_map.short_name.content|wash()}</h2>
    {/if}

    {def $reverse_related_objects_count = fetch( 'content', 'reverse_related_objects_count', hash( 'object_id', $node.object.id, 'all_relations', true(), 'group_by_attribute', true(), 'ignore_visibility', false()) )} 

    {if $reverse_related_objects_count}
        {include name=navigator
               uri='design:navigator/google.tpl'
               page_uri=$node.url_alias
               item_count=$reverse_related_objects_count
               view_parameters=$view_parameters
               item_limit=$page_limit}
        {def $reverse_related_objects_grouped = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.object.id, 'all_relations', true(), 'group_by_attribute', true(), 'sort_by', array( array( 'class_identifier', true() ), array( 'name', true() ) ), 'ignore_visibility', false(), 'limit', $page_limit, 'offset', $offset ) )}
        {def $reverse_related_objects_id_typed = fetch( 'content', 'reverse_related_objects_ids', hash( 'object_id', $node.object.id ) )}

        {def $attr = 0}
        {foreach $reverse_related_objects_grouped as $attribute_id => $related_objects_array }
            {if ne( $attribute_id, 0 )}
                {set $attr = fetch( 'content', 'class_attribute', hash( 'attribute_id', $attribute_id ) )}
            {/if}
            {foreach $related_objects_array as $object }
                {if or( $object.can_read, $object.can_view_embed )}
                    {*content_view_gui view=text_linked content_object=$object}
                    {$object.content_class.name|wash*}
                    {node_view_gui view=$view content_node=$object.main_node}
                {else}
                    <p><em>{'You are not allowed to view the related object'|i18n( 'design/admin/node/view/full' )}</p>
                {/if}

                {*if and( ne( $attribute_id, 0 ), $reverse_related_objects_id_typed['attribute']|contains( $object.id ) )}
                    {$relation_type_names['attribute']} ( {$attr.name} )
                {elseif eq( $attribute_id, 0 )}
                    {def $relation_name_array = array()}
                    {foreach $reverse_related_objects_id_typed as $relation_type => $relation_id_array}
                        {if ne( $relation_type, 'attribute' )}
                            {if $relation_id_array|contains( $object.id )}
                                {set $relation_name_array = $relation_name_array|append( $relation_type_names[$relation_type] )}
                            {/if}
                        {/if}
                    {/foreach}
                    {$relation_name_array|implode( $relation_name_delimiter )}
                    {undef $relation_name_array}
                {/if*}
            {/foreach}
        {/foreach}
        {include name=navigator
               uri='design:navigator/google.tpl'
               page_uri=$node.url_alias
               item_count=$reverse_related_objects_count
               view_parameters=$view_parameters
               item_limit=$page_limit}
        {undef $attr}
    {else}
        <p>{'The item being viewed is not used by any other objects.'|i18n( 'design/admin/node/view/full' )}</p>
    {/if}

</div>
