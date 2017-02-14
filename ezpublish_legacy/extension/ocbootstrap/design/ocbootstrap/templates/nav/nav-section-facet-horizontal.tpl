<div class="navbar navbar-default nav-facets-horizontal" role="navigation">  
	{if $data.navigation|count}
    <form class="form-facets navbar-form navbar-left" role="search" action={concat('facet/proxy/', $node.node_id)|ezurl()}>
	  <div class="btn-group">
      <input id="searchfacet" data-content="Premi invio per cercare" type="text" class="form-control" placeholder="Cerca" name="query" value="{$data.query}">
      <span id="searchfacetclear" class="glyphicon glyphicon-remove-circle" style="position: absolute;right: 5px;top: 0;bottom: 0;height: 14px;margin: auto;font-size: 14px;cursor: pointer;color: #ccc;"></span>
    </div>
    {foreach $data.navigation as $name => $items}
        <select class="facet-select" data-placeholder="{$name|wash()}" name="{$name|wash()}">
          <option></option>
          {foreach $items as $item}
            <option {if $item.active}selected="selected"{/if} value="{$item.query}">{$item.name|wash()} {if $item.count|gt(0)}({$item.count}){/if}</option>              
          {/foreach}
        </select>		
		{/foreach}    
    <button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
  </form>
	{/if}	
</div>

{* attivare se non si vuole usare ajax
<script>{literal}
$(document).ready(function(){    
  $(".facet-select").chosen({allow_single_deselect:true,width:'200px'});
});
{/literal}</script>
*}