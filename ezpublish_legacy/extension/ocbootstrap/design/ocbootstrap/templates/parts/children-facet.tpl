{set_defaults( hash(
  'page_limit', 20,
  'view', 'line',
  'delimiter', ''
))}

<div class="facet-content">  
{if $data.count}

  {include name=navigator
		   uri='design:navigator/google.tpl'
		   page_uri=$data.base_uri
		   item_count=$data.count
		   view_parameters=$view_parameters
		   item_limit=$page_limit}

  <div class="content-view-children">  
	{foreach $data.contents as $child }
	  {node_view_gui view=$view content_node=$child}
	  {delimiter}{$delimiter}{/delimiter}
	{/foreach}
  </div>

  {include name=navigator
		   uri='design:navigator/google.tpl'
		   page_uri=$data.base_uri
		   item_count=$data.count
		   view_parameters=$view_parameters
		   item_limit=$page_limit}

{else}
  <em>Nessun risultato</em>
{/if}
</div>