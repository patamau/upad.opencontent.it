{default attribute_base=ContentObjectAttribute html_class='full' placeholder=false()}

{*<label>{$attribute.contentclass_attribute_name}</label>*}
<div class="entities-container block float-break">

	{ezscript_require( array( 'ezjsc::jquery', 'ezjsc::jqueryio', 'ezjsc::jqueryUI', 'opensemantic_edit.js' ) )}
	{ezcss_require( 'opensemantic_edit.css' )}
	
    {*
	<input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_disabled" 
		type="checkbox" name="{$attribute_base}_ezopensemanticentities_disabled_{$attribute.id}" value="1" {if $attribute.data_int}checked="checked" {/if}/> 
		{'Disabilita'|i18n('extension/opensemantic/datatype')}      
	*}
	<input id="object_{$attribute.contentobject_id}_{$attribute.version}_{$attribute.language_code}_{$attribute.id}" class="hide action-refreshFromEngine" type="submit" value="{'Aggiorna'|i18n('extension/opensemantic/datatype')}" name="CustomActionButton[{$attribute.contentclassattribute_id}_refresh]" />
    
    <div id="entities-{$attribute.contentclassattribute_id}" class="visible-entities">
    
        {def $entities = $attribute.content
             $keywords = $entities.keywords
             $geolocations = $entities.geolocations
             $people = $entities.people
             $organizations = $entities.organizations}
            
        {if $attribute.has_content|not()}
        <p><small>Al momento nessuna entit&agrave;</small></p>
        {/if}
        
        <ul class="nav nav-pills pill-entities">
            <li><button id="refreshButton" class="btn btn-info">Refresh</button></li>
			{if count($keywords)|gt(0)}
            <li>
                <a data-toggle="tab" href="#keywords-{$attribute.contentclassattribute_id}">
                    <span class="badge"><span class="glyphicon glyphicon-tags"></span> Keywords {count($keywords)}</span>
                </a>
            </li>
            {/if}
            {if count($geolocations)|gt(0)}
            <li>
                <a data-toggle="tab" href="#geolocations-{$attribute.contentclassattribute_id}">
                    <span class="badge"><span class="glyphicon glyphicon-map-marker"></span> Geolocations {count($geolocations)}</span>
                </a>
            </li>    
            {/if}
            {if count($people)|gt(0)}
            <li>
                <a data-toggle="tab" href="#people-{$attribute.contentclassattribute_id}">
                    <span class="badge"><span class="glyphicon glyphicon-user"></span> People {count($people)}</span>
                </a>
            </li>
            {/if}
            {if count($organizations)|gt(0)}
            <li>
                <a data-toggle="tab" href="#organizations-{$attribute.contentclassattribute_id}">
                    <span class="badge"><span class="glyphicon glyphicon-registration-mark"></span> Organizations {count($organizations)}</span>
                </a>
            </li>
            {/if}			
        </ul>
            
        <div class="tab-content">     
            {if count($keywords)|gt(0)}        
            <div id="keywords-{$attribute.contentclassattribute_id}" class="tab-pane">
            {foreach $keywords as $keyword}
                {keyword_edit_gui keyword=$keyword objectattribute_id=$attribute.id}
            {/foreach}       
            </div>
            {/if}
            
            {if count($geolocations)|gt(0)}
            <div id="geolocations-{$attribute.contentclassattribute_id}" class="tab-pane">
            {foreach $geolocations as $geolocation}
                {entity_edit_gui entity=$geolocation type='geolocation' objectattribute_id=$attribute.id}
            {/foreach}       
            </div>
            {/if}
            
            {if count($people)|gt(0)}
            <div id="people-{$attribute.contentclassattribute_id}" class="tab-pane">
            {foreach $people as $person}
                {entity_edit_gui entity=$person type='person' objectattribute_id=$attribute.id}
            {/foreach}       
            </div>
            {/if}
            
            {if count($organizations)|gt(0)}    	
            <div id="organizations-{$attribute.contentclassattribute_id}" class="tab-pane">
            {foreach $organizations as $organization}
                {entity_edit_gui entity=$organization type='organization' objectattribute_id=$attribute.id}
            {/foreach}       
            </div>
            {/if}
        </div>
        
    </div>

<script type="text/javascript">
{literal}
$(document).on( 'click', "#refreshButton", function(e){
  triggerOpenSemanticRefresh();
  e.preventDefault();
});
$(document).keypress(function(e) {
  if(e.which == 13) {
    triggerOpenSemanticRefresh();
  }
});
{/literal}
</script>    
    
</div>
{/default}