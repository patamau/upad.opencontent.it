{default attribute_base='ContentObjectAttribute' html_class='full' placeholder=false()}
{if and( $attribute.has_content, $placeholder )}<label>{$placeholder}</label>{/if}
    {*<div class="checkbox">
        <label>
            <input type="checkbox" id="ignorecf">Ignora il Codice Fiscale
        </label>
    </div>*}
    <div class="form-inline" id="cf_container">
        <input {if $placeholder}placeholder="{$placeholder}"{/if} id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="{$html_class} ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_cf_data_text_{$attribute.id}" value="{$attribute.data_text|wash( xhtml )}" />
        <button id="calcola_{$attribute.id}" class="btn btn-default">Calcola</button>
    </div>
{/default}

{ezscript_require( array( 'ezjsc::jqueryio' ) )}
{literal}
<script type="text/javascript">
    $( document ).ready(function() {

        $('#calcola_' + {/literal}{$attribute.id}{literal}).click(function(e) {
            e.preventDefault();

            var name = $('.ezcca-{/literal}{$attribute.object.content_class.identifier}{literal}_{/literal}{$attribute.contentclass_attribute.data_text1}{literal}').val(),
                lastname = $('.ezcca-{/literal}{$attribute.object.content_class.identifier}{literal}_{/literal}{$attribute.contentclass_attribute.data_text2}{literal}').val(),
                day = $('.{/literal}{$attribute.contentclass_attribute.data_text3}{literal}_day').val(),
                month = $('.{/literal}{$attribute.contentclass_attribute.data_text3}{literal}_month').val(),
                year = $('.{/literal}{$attribute.contentclass_attribute.data_text3}{literal}_year').val(),
                gender = $('.ezcca-{/literal}{$attribute.object.content_class.identifier}{literal}_{/literal}{$attribute.contentclass_attribute.data_text4}{literal}').find('option:selected').text(),
                city = $('.ezcca-{/literal}{$attribute.object.content_class.identifier}{literal}_{/literal}{$attribute.contentclass_attribute.data_text5}{literal}_city').val(),
                date = {/literal}day+'/'+ month +'/'+ year{literal};
            $.ez( 'ocuserregistertools::calcolaCodiceFiscale', {'name': name, 'lastname': lastname, 'date': date, 'gender': gender, 'city': city,}, function( data )
            {
                if ( data.error_text )
                    alert('error');
                else
                    //alert(data.content);
                    $('#ezcoa-{/literal}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}{literal}').val(data.content);
            });
        });

        /*
        $('#ignorecf').click(function(e){
            if ($(this).is(':checked')) {
                $('#cf_container').addClass('hidden');
                randLetter = String.fromCharCode(65 + Math.floor(Math.random() * 26));
                console.log(randLetter + Date.now());
                $('#ezcoa-{/literal}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}{literal}').val(randLetter + Date.now());
            } else {
                $('#cf_container').removeClass('hidden');
                $('#ezcoa-{/literal}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}{literal}').val('');
            }
        });
        */

    });
</script>
{/literal}
