<span style="display: inline-block;vertical-align: middle;width:22px">
{if and( is_set($object.data_map.image), $object.data_map.image.has_content )}
    {attribute_view_gui attribute=$object.data_map.image image_class=avatar href=false() img_css_class="img-responsive"}
{else}
    <img src="{'avatar.jpg'|ezimage(no)}" width="23" height="23" alt="{$object.name|wash}" />
{/if}
</span>