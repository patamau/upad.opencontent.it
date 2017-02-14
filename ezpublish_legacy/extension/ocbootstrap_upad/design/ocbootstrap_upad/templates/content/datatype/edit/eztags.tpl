{ezcss_require( array( 'tagssuggest.css', 'jqmodal.css', 'contentstructure-tree.css' ) )}
{ezscript_require( array( 'ezjsc::jquery', 'ezjsc::jqueryio', 'jquery-migrate-1.1.1.min.js', 'jqmodal.js', 'jquery.tagssuggest.js', 'tagssuggest-init.js' ) )}

{def $has_add_access = false()}
{def $root_tag = fetch( tags, tag, hash( tag_id, $attribute.contentclass_attribute.data_int1 ) )}

{def $user_limitations = user_limitations( 'tags', 'add' )}
{if $user_limitations['accessWord']|ne( 'no' )}
    {if is_unset( $user_limitations['simplifiedLimitations']['Tag'] )}
        {set $has_add_access = true()}
    {elseif $root_tag}
        {foreach $user_limitations['simplifiedLimitations']['Tag'] as $key => $value}
            {if $root_tag.path_string|contains( concat( '/', $value, '/' ) )}
                {set $has_add_access = true()}
                {break}
            {/if}
        {/foreach}
    {else}
        {set $has_add_access = true()}
        {set $root_tag = array()}
        {foreach $user_limitations['simplifiedLimitations']['Tag'] as $key => $value}
            {set $root_tag = $root_tag|append( fetch( tags, tag, hash( tag_id, $value ) ) )}
        {/foreach}
    {/if}
{/if}

{default attribute_base='ContentObjectAttribute' html_class='full' placeholder=false()}
<div class="tagssuggest clearfix{if $attribute.contentclass_attribute.data_int2} tagsfilter{/if}">
    {if $placeholder}<label>{$placeholder}</label>{/if}
    
    <div class="tags-list tags-listed no-results">
        <p class="loading">{'Loading'|i18n( 'extension/eztags/datatypes' )}...</p>
        <p class="no-results"><small>{'There are no selected tags'|i18n( 'extension/eztags/datatypes' )}.</small></p>
    </div>
{*
    <label>{'Suggested tags'|i18n( 'extension/eztags/datatypes' )}:</label>
    <div class="tags-list tags-suggested no-results">
        <p class="loading">{'Loading'|i18n( 'extension/eztags/datatypes' )}...</p>
        <p class="no-results">{'There are no tags to suggest'|i18n( 'extension/eztags/datatypes' )}.</p>
    </div>
*}

    {if $has_add_access}
        <div class="tagssuggestfieldwrap input-group">
            <input class="tagssuggestfield {$html_class}" type="text" name="suggest_{$attribute_base}_eztags_data_text_{$attribute.id}" value="" autocomplete="off" />
            <span class="input-group-btn">            
            <input type="button" value="+" name="AddTagButton" class="btn btn-info btn-sm button-add-tag button-disabled" disabled="disabled" />
          </span>
      </div>        
    {else}
    {/if}

    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier} tagnames" type="hidden" name="{$attribute_base}_eztags_data_text_{$attribute.id}" value="{$attribute.content.keyword_string|wash}"  />

    <input id="ezcoa2-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box tagpids" type="hidden" name="{$attribute_base}_eztags_data_text2_{$attribute.id}" value="{$attribute.content.parent_string|wash}"  />

    <input id="ezcoa3-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box tagids" type="hidden" name="{$attribute_base}_eztags_data_text3_{$attribute.id}" value="{$attribute.content.id_string|wash}"  />

    <input type="hidden" class="eztags_subtree_limit" name="eztags_subtree_limit-{$attribute.id}" value="{$attribute.contentclass_attribute.data_int1}" />
    <input type="hidden" class="eztags_hide_root_tag" name="eztags_hide_root_tag-{$attribute.id}" value="{$attribute.contentclass_attribute.data_int3}" />
    <input type="hidden" class="eztags_max_tags" name="eztags_max_tags-{$attribute.id}" value="{if $attribute.contentclass_attribute.data_int4|gt( 0 )}{$attribute.contentclass_attribute.data_int4}{else}0{/if}" />
</div>

{if $has_add_access}
    {include uri='design:ezjsctemplate/modal_dialog.tpl' attribute_id=$attribute.id root_tag=$root_tag}
{/if}
{/default}
