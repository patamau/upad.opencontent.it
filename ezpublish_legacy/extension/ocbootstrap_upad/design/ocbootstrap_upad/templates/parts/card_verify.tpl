{set_defaults( hash(
  'subscriptions',array()
))}

{def $lastinvoice=0
$card_course='tessera'}

{foreach $subscriptions as $subscription}
	{def $cname = $subscription.data_map.course.content.name|wash()|downcase()}
	{if $cname|contains($card_course)} {*controllo il corso di riferimento*}
		{if eq($subscription.data_map.annullata.content, 0)} {*controllo lo stato annullato*}
            {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
                {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
                {if gt($invoice.date,$lastinvoice)}{set $lastinvoice=$invoice.date}{/if}
                {undef $invoice}
            {/foreach}
	    {/if}
    {/if}
    {undef $cname}
{/foreach}

<div>
<p>Data ultima ricevuta di tesseramento: {$lastinvoice|datetime(custom, '%d %m %Y')}</p>
{*Data odierna {currentdate()|datetime(custom, '%m %Y')}*}

{*la tessera è valida se l'hanno attuale è uguale a quello dell'ultimo pagamento*}
{if eq($lastinvoice|datetime('%Y'),currentdate()|datetime(custom, '%Y'))}
	<div>TESSERAMENTO VALIDO</div>
{else}
	<div>TESSERAMENTO SCADUTO</div>
{/if}

</div>

{undef $lastinvoice}

