{set-block variable=$xhtml}
	{def $ente = $invoices[0].ente
	     $range = ''}
	
	{if $a}
	    {set $range = concat('dal ', $da, ' al ', $a)}
	{else}
	    {set $range = concat('del ', $da)}
	{/if}
	
	
	{foreach $invoices as $i}
	    {def $user = fetch( 'content', 'object', hash( 'object_id', $i.user_id ) )}
	
	    <div class="container">
	        {include uri="design:invoice/header.tpl" invoice=$i}
	        
	        {$i.text|explode( '%NUMBER%' )|implode( $i.invoice_id_string )|explode( '%DATE%' )|implode( $i.date|l10n( 'shortdate' ) )}
	        
	        {include uri="design:invoice/footer.tpl" invoice=$i}
	    </div>
	    {delimiter}<div class="page_breaker"></div>{/delimiter}
	
	{/foreach}
	{undef $ente}
{/set-block}
{set $xhtml = $xhtml|explode('& ')|implode('&amp; ')}
{$xhtml}


