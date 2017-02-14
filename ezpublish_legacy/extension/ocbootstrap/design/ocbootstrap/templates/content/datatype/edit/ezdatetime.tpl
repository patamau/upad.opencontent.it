{def $base = ezini('eZJSCore', 'LocalScriptBasePath', 'ezjscore.ini')}

{ezscript_require( 'ezjsc::yui2' )}
{ezcss_require( concat( '/', $base.yui2, 'calendar/assets/calendar.css' ) )}

<script type="text/javascript">
(function() {ldelim}
    YUILoader.addModule({ldelim}
        name: 'datepicker',
        type: 'js',
        fullpath: '{"javascript/ezdatepicker.js"|ezdesign( 'no' )}',
        requires: ["calendar"],
        after: ["calendar"],
        skinnable: false
    {rdelim});

    YUILoader.require(["datepicker"]);

    // Load the files using the insert() method.
    var options = [];
    YUILoader.insert(options, "js");
{rdelim})();
</script>

{default attribute_base='ContentObjectAttribute' html_class='full' placeholder=false()}
<div class="clearfix">
    {if $placeholder}<label>{$placeholder}</label>{/if}

{if ne( $attribute_base, 'ContentObjectAttribute' )}
    {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{else}
    {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{/if}

<div class="form-inline date">
    <input placeholder="{'Day'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_day" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_datetime_day_{$attribute.id}" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.day}{/section}" />
    <input placeholder="{'Month'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_month"  class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_datetime_month_{$attribute.id}" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.month}{/section}" />
    <input placeholder="{'Year'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_year" class="year form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_datetime_year_{$attribute.id}" size="5" value="{section show=$attribute.content.is_valid}{$attribute.content.year}{/section}" />
</div>
<div class="form-inline time">
    <input placeholder="{'Hour'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_hour" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_datetime_hour_{$attribute.id}" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.hour}{/section}" />
    <input placeholder="{'Minute'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_minute" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_datetime_minute_{$attribute.id}" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.minute}{/section}" />
{if $attribute.contentclass_attribute.data_int2|eq(1)}
    <input placeholder="{'Second'|i18n( 'design/standard/content/datatype' )}" id="{$id_base}_second" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_datetime_second_{$attribute.id}" size="3" value="{if $attribute.content.is_valid}{$attribute.content.second}{/if}" />
{/if}
</div>
<span class="glyphicon glyphicon-calendar" id="{$attribute_base}_datetime_cal_{$attribute.id}" width="24" height="28" onclick="showDatePicker( '{$attribute_base}', '{$attribute.id}', 'datetime' );" style="cursor: pointer;"></span>
<div id="{$attribute_base}_datetime_cal_container_{$attribute.id}" style="display: none; position: absolute;"></div>




</div>
{/default}
