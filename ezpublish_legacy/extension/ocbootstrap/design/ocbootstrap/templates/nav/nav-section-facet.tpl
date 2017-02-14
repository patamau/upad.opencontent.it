<div class="nav-facets">
	{if $data.navigation|count}
	<div class="row">
	  {foreach $data.navigation as $name => $items}
		<div class="facet-list">
      <h2>{$name|wash()}</h2>
		  {*<div class="list-group">*}
      <ul class="nav-sub">
        {foreach $items as $item}
          {*<a class="{if $item.active}active {/if}list-group-item" href="{$item.url|ezurl( 'no' )}" data-key={$name} data-value="{$item.name}">*}
          <li>
            {if $item.active}
            <a class="active bg-primary" href="{$item.url|ezurl( 'no' )}" data-key="{$name}" data-value="{$item.query}">
              <span class="glyphicon glyphicon-remove"></span>
              {$item.name|wash()}
              <span class="badge">{$item.count}</span>
            </a>
            {else}
            <a href="{$item.url|ezurl( 'no' )}" data-key="{$name}" data-value="{$item.query}">
              {$item.name|wash()}
              <span class="badge">{$item.count}</span>
            </a>
            {/if}
          </li>
			  {/foreach}
		  </ul>
		</div>
		{/foreach}
	</div>
	{/if}	
</div>