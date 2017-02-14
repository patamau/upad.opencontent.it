{if not( is_set($show_link) )}
    {def $show_link = false()}
{/if}
{if not( is_set($show_newline) )}
    {def $show_newline = false()}
{/if}
{section show=$attribute.content.relation_list}
{section var=Relations loop=$attribute.content.relation_list}
{if $Relations.item.in_trash|not()}
    {content_view_gui view=embed show_link=$show_link content_object=fetch( content, object, hash( object_id, $Relations.item.contentobject_id ) )}
    {if $show_newline}<br />{/if}
{/if}
{/section}
{/section}
