
<a href={$href|ezurl(,'full')|explode('culturabz/')|implode()}
	{if $id} id="{$id}"{/if}
	{if $title} title="{$title}"{/if}
	{if $target} target="{$target}"{/if}
	{if $classification} class="{$classification|wash}"{/if}
	{if and(is_set( $hreflang ), $hreflang)} hreflang="{$hreflang|wash}"{/if}>
	{$content}
</a>