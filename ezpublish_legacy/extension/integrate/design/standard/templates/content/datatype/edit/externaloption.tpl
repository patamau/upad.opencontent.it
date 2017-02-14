{default attribute_base=ContentObjectAttribute}
{if and(is_numeric($attribute.content.value), ne($attribute.content.value,0))}
  {def $value=$attribute.content.value}
{else}
  {def $value=$attribute.content.default}
{/if}

<select name="{$attribute_base}_data_int_{$attribute.id}" id="{$attribute.contentclass_attribute_identifier}" class="form-control">
<option value="">{$attribute.contentclass_attribute_name}...</option>

{section loop=$attribute.content.options}
<option value="{$item.val|wash(xhtml)}"{if eq($value, $item.val)} selected="selected"{/if}>{$item.label|wash(xhtml)}</option>

{/section}
</select>
{/default}
