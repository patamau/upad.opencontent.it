{if and( is_set($object.data_map.image), $object.data_map.image.has_content )}
    {attribute_view_gui attribute=$object.data_map.image image_class=avatar link_title=$object.name|wash() href=$object.main_node.url_alias|ezurl() img_css_class="img-responsive"}
{else}
    <a href="{$object.main_node.url_alias|ezurl(no)}" title="{$object.name|wash()}">
        <img src="{'avatar.jpg'|ezimage(no)}" width="23" height="23" alt="{$object.name|wash}" />
    </a>
{/if}
