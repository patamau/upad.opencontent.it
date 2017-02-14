{ezscript_require( array('plugins/select2/select2.js') )}
{ezcss_require( array('plugins/select2/select2.css') )}

{def $current_user = fetch( 'user', 'current_user' )
     $content_object = $current_node.object
     $can_edit_languages = $content_object.can_edit_languages
     $can_manage_location = fetch( 'content', 'access', hash( 'access', 'manage_locations', 'contentobject', $current_node ) )
     $can_create_languages = $content_object.can_create_languages
     $is_container = $content_object.content_class.is_container
     $odf_display_classes = ezini( 'WebsiteToolbarSettings', 'ODFDisplayClasses', 'websitetoolbar.ini' )
     $odf_hide_container_classes = ezini( 'WebsiteToolbarSettings', 'HideODFContainerClasses', 'websitetoolbar.ini' )
     $website_toolbar_access = fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) )
     $odf_import_access = fetch( 'user', 'has_access_to', hash( 'module', 'ezodf', 'function', 'import' ) )
     $odf_export_access = fetch( 'user', 'has_access_to', hash( 'module', 'ezodf', 'function', 'export' ) )
     $content_object_language_code = ''
     $policies = fetch( 'user', 'user_role', hash( 'user_id', $current_user.contentobject_id ) )
     $available_for_current_class = false()
     $custom_templates = ezini( 'CustomTemplateSettings', 'CustomTemplateList', 'websitetoolbar.ini' )
     $include_in_view = ezini( 'CustomTemplateSettings', 'IncludeInView', 'websitetoolbar.ini' )
     $node_hint = ': '|append( $current_node.name|wash(), ' [', $content_object.content_class.name|wash(), ']' ) }

     {foreach $policies as $policy}
        {if and( eq( $policy.moduleName, 'websitetoolbar' ),
                    eq( $policy.functionName, 'use' ),
                        is_array( $policy.limitation ) )}
            {if $policy.limitation[0].values_as_array|contains( $content_object.content_class.id )}
                {set $available_for_current_class = true()}
            {/if}
        {elseif or( and( eq( $policy.moduleName, '*' ),
                             eq( $policy.functionName, '*' ),
                                 eq( $policy.limitation, '*' ) ),
                    and( eq( $policy.moduleName, 'websitetoolbar' ),
                             eq( $policy.functionName, '*' ),
                                 eq( $policy.limitation, '*' ) ),
                    and( eq( $policy.moduleName, 'websitetoolbar' ),
                             eq( $policy.functionName, 'use' ),
                                 eq( $policy.limitation, '*' ) ) )}
            {set $available_for_current_class = true()}
        {/if}
     {/foreach}

{if and( $website_toolbar_access, $available_for_current_class )}


<form method="post" action="{"content/action"|ezurl(no)}" class="pull-right" style="margin:0 20px">
<div class="btn-group">
    
    <a class="btn btn-sm" href={concat( "websitetoolbar/sort/", $current_node.node_id )|ezurl()} title="{'Sorting'|i18n( 'design/standard/parts/website_toolbar' )}">
        <i class="icon-sort-by-alphabet "></i>
    </a>
    
    
    {* Custom templates inclusion *}
    {foreach $custom_templates as $custom_template}
        {if is_set( $include_in_view[$custom_template] )}
            {def $views = $include_in_view[$custom_template]|explode( ';' )}
            {if $views|contains( 'full' )}
                {include uri=concat( 'design:parts/websitetoolbar/', $custom_template, '.tpl' )}
            {/if}
            {undef $views}
        {/if}
    {/foreach}
    
</div>

{if and( $content_object.can_create, $is_container )}
        
        {def $can_create_class_list = ezcreateclasslistgroups( $content_object.can_create_class_list )}
        {if $can_create_class_list|count()}  
        <select name="ClassID" class='select2 placeholder form-control' style="width:200px" placeholder="Seleziona classe">            
            {foreach $can_create_class_list as $group}
              <optgroup label="{$group.group_name}">
              {foreach $group.items as $class}
                  <option value="{$class.id}">{$class.name|wash}</option>
              {/foreach}
              </optgroup>
            {/foreach}
        </select>
        {/if}    
        <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
        <input class="btn btn-primary" type="submit" name="NewButton" value="{'Create here'|i18n('design/standard/parts/website_toolbar')}" />
{/if}
   

  <input type="hidden" name="HasMainAssignment" value="1" />
  <input type="hidden" name="ContentObjectID" value="{$content_object.id}" />
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ContentNodeID" value="{$current_node.node_id}" />  
  {def $avail_languages = $content_object.available_languages
       $default_language = $content_object.default_language}
  {if and( $avail_languages|count|ge( 1 ), $avail_languages|contains( $default_language ) )}
    {set $content_object_language_code = $default_language}
  {else}
    {set $content_object_language_code = ''}
  {/if}
  <input type="hidden" name="ContentObjectLanguageCode" value="{$content_object_language_code}" />


</form>

{/if}