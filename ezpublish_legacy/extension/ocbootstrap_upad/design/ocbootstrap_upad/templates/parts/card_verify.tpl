
{* come verificare la validit� di una tessera:
1) dato il numero di tessera, risalire al proprietario: se ce ne sono pi� di uno, dare errore
fetch_user_by_card(card_id)
2) dato il proprietario, risalire ai pagamenti nei corsi "tessera": se non ce ne sono, tessera scaduta
check_payments(user_id)
3) dati i pagamenti "tessera", controllare la data del pagamento e confrontarla con quella attuale: se � in un anno precedente, tessera scaduta
check_card_expired(card_payments)
*}
{set_defaults( hash(
	'card_id','',
	'edit',false(),			
) )}
	
{if $card_id|ne('')}

	{*cerca gli utenti associati a quella card*}
	{def $users = fetch(
			'content', 'tree', hash(
					parent_node_id, 1,
					class_filter_type, 'include',
					class_filter_array, array( 'user' ),
					attribute_filter, array(
						array( 'user/card', 'like', $card_id)
					)
				)
			)
		$users_count = $users|count()
	}
	
	{if $users_count|gt(1)}
		<div class="error">TESSERA DUPLICATA ({$users_count})
			<div class="details">
				<ul>
				{foreach $users as $user}
					<li><a href="{concat( 'content/edit/', $user.contentobject_id, '/f/', $user.default_language )|ezurl('no')}">{$user.name}</a></li>
				{/foreach}
				</ul>
			</div>
		</div>
	{elseif $users_count|eq(0)}
		<div class="error">TESSERA NON ASSOCIATA</div>
	{else}
		{def $user=$users[0]}
		{*se ce ne sono pi� di uno allora non va bene, altrimenti dovrebbe essere quello specificato...*}
		{def $subscriptions = fetch(
			    'content', 'tree', hash(
					    parent_node_id, 1,
					    class_filter_type, 'include',
					    class_filter_array, array( 'subscription' ),
					    attribute_filter, array(
						    array( 'subscription/user', '=', $user.contentobject_id )
					    ),
					    sort_by, array(
					    	array( 'published', false() )
					    )
				    )
			    )
	    }
	    
	    {def $subdate=0
	    	$subcourse=false()
	    	$annullato=true()
			$card_course='tessera'}
	
		{foreach $subscriptions as $subscription}
			{def $cname = $subscription.data_map.course.content.name|wash()|downcase()}
			{* controllo il nome del corso con il corso di riferimento per la tessera *}
			{if $cname|contains($card_course)}
				{* imposto l'ultimo corso come riferimento, anche se e' stato annullato *}
				{if $subcourse|not()}
					{set $subcourse=$subscription.data_map.course}
					{set $subdate=$subscription.object.published}
				{/if}
				{* controllo lo stato annullato *}
				{if eq($subscription.data_map.annullata.content, 0)}
					{* questo ciclo esegue l'analisi dei pagamenti invece che dell'iscrizione *}
		            {*foreach $subscription.data_map.invoices.content.rows.sequential as $row}
		            	
		                {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
		                {if gt($invoice.date,$subdate)}
		                	{set $subdate=$invoice.date}
		                {/if}
		                {undef $invoice}
		            {/foreach*}
		            {if ge($subscription.object.published,$subdate)}
		            	{set $subdate=$subscription.object.published}
		            	{*overwrite the "last" course*}
		            	{set $subcourse=$subscription.data_map.course}
		            	{set $annullato=false()}
		            {/if}
			    {/if}
		    {/if}
		    {undef $cname}
		{/foreach}
		
		<div>
			{*Data odierna {currentdate()|datetime(custom, '%m %Y')}*}
			{*la tessera � valida se l'anno attuale � uguale a quello dell'ultimo pagamento*}
			{if and($annullato|not(), 
				eq($subdate|datetime(custom, '%Y'),currentdate()|datetime(custom, '%Y')))}
				<div class="valid">TESSERAMENTO VALIDO</div>
			{else}
				{if $subcourse}
					<div class="error">TESSERAMENTO SCADUTO</div>
				{else}
					<div class="error">TESSERAMENTO INVALIDO</div>
				{/if}	
			{/if}
			
			{if $subcourse}
				<p>
					{if $edit}
						{def $where=concat('courses/list/',$subcourse.data_int)|ezurl(no)}
						<a href="{$where}" target="edit_course" alt="Apri pagina di gestione del corso">
				    	{undef $where}
					{/if}
					{$subcourse.content.name}
					{if $edit}
						</a>
					{/if} 
					{$subdate|datetime(custom, '%d/%m/%Y')} 
					{if $annullato}
						<span class="error">[ANNULLATO]</span>
					{/if}
				</p>
			{/if}
			
			{* non serve aggiornare da qui e potrebbe essere fuorviante (?)
			<input class="btn btn-lg btn-success pull-right" type="button" value="Aggiorna" onclick="location.reload();"/>
			*}
		</div>
		{undef $subscriptions}
		{undef $card_course}
		{undef $subcourse}
		{undef $subdate}
	{/if} {* user *}
	{undef $users}
{else}
	<div>Nessuna tessera associata</div>
{/if}