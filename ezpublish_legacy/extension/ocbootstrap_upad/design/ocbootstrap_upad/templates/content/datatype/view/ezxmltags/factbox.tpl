<div class="panel panel-primary object-{if is_set($align)}{$align}{else}left{/if}" style="width: 33%">
    {if is_set($title)}
	  <div class="panel-heading">
		<h3 class="panel-title">{$title}</h3>
	  </div>
	{/if}
    <div class="panel-body">
        {$content}
    </div>
</div>