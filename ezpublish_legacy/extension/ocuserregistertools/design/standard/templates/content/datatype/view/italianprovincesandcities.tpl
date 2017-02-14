{def $province = ''
     $comune = ''}

{default attribute_base=ContentObjectAttribute}
{if and(is_numeric($attribute.content.provinces.value), ne($attribute.content.provinces.value,0))}
  {def $valueProvince=$attribute.content.provinces.value}
{else}
  {def $valueProvince=$attribute.content.provinces.default}
{/if}


{section loop=$attribute.content.provinces.options}
    {if eq($valueProvince, $item.val)}
        {set $province = $item.label|wash(xhtml)}
    {/if}
{/section}


{*select comuni*}
{if and(is_numeric($attribute.content.cities.value), ne($attribute.content.cities.value,0))}
  {def $valueComuni=$attribute.content.cities.value}
{else}
  {def $valueComuni=$attribute.content.cities.default}
{/if}


{section loop=$attribute.content.cities.options}
    {if eq($valueComuni, $item.val)}
        {set $comune = $item.label|wash(xhtml)}
    {/if}
{/section}

{/default}

{$comune} ({$province})

{undef $valueProvince $province $valueComuni $comune}
