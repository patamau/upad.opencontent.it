{*select province*}
{default attribute_base=ContentObjectAttribute}
{if and(is_numeric($attribute.content.provinces.value), ne($attribute.content.provinces.value,0))}
  {def $valueProvince=$attribute.content.provinces.value}
{else}
  {def $valueProvince=$attribute.content.provinces.default}
{/if}

<select name="{$attribute_base}_data_int_{$attribute.id}" class="form-control" id="province_{$attribute.id}">
<option value="">Seleziona provincia...</option>

{section loop=$attribute.content.provinces.options}
    <option value="{$item.val|wash(xhtml)}" data-sigla="{$item.sigla}"{if eq($valueProvince, $item.val)} selected="selected"{/if}>{$item.label|wash(xhtml)}</option>
{/section}
</select>

<p>&nbsp;</p>

{*select comuni*}
{if and(is_numeric($attribute.content.cities.value), ne($attribute.content.cities.value,0))}
  {def $valueComuni=$attribute.content.cities.value}
{else}
  {def $valueComuni=$attribute.content.cities.default}
{/if}

<select name="{$attribute_base}_data_int_{$attribute.id}_city" class="form-control ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}_city" id="city_{$attribute.id}">
<option value="">Seleziona comune...</option>

{section loop=$attribute.content.cities.options}
    <option value="{$item.val|wash(xhtml)}" data-sigla="{$item.sigla}"{if eq($valueComuni, $item.val)} selected="selected"{/if}>{$item.label|wash(xhtml)}</option>
{/section}
</select>
{/default}

{ezscript_require( array( 'ezjsc::jqueryio' ) )}
{literal}
<script type="text/javascript">
    $( document ).ready(function() {

        if($('#province_{/literal}{$attribute.id}{literal}').length > 0) {
            $('#province_{/literal}{$attribute.id}{literal}').change(function(){
                var sigla = $(this).find('option:selected').attr('data-sigla');
                $.ez( 'ocuserregistertools::searchCities', {arg1: sigla}, function( data )
                {
                    if ( data.error_text )
                        alert('error');
                    else
                        $('#city_{/literal}{$attribute.id}{literal}').html(data.content);
                });
            });
        }

        if ($('.ezcca-{/literal}{$attribute.object.content_class.identifier}{literal}_{/literal}{$attribute.contentclass_attribute.data_text1}{literal}').length > 0) {
            $('#city_{/literal}{$attribute.id}{literal}').change(function(){
                $.ez( 'ocuserregistertools::searchCap', {arg1: $(this).val()}, function( data )
                {
                    if ( data.error_text )
                        alert('error');
                    else
                        $('.ezcca-{/literal}{$attribute.object.content_class.identifier}{literal}_{/literal}{$attribute.contentclass_attribute.data_text1}{literal}').val(data.content);
                });
            });
        }
    });
</script>
{/literal}

{undef $valueProvince $valueComuni}
