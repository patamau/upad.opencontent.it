{* Event Calendar - Full view *}
{set-block scope=root variable=cache_ttl}400{/set-block}
{def $view = $node.data_map.view.class_content.options[$node.data_map.view.value[0]].name|downcase()}
{if is_set( $view_parameters.view )}
    {set $view = $view_parameters.view}
{/if}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
	
	<h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'intro' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'intro' )}
      </div>
    {/if}
	
    {include uri=concat("design:calendar/",$view,".tpl")}
  </div>
  
</div>
