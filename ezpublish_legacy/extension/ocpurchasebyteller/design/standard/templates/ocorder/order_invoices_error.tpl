<div class="container">

<div class="alert alert-danger">
{if $error|is_string()}
  <p>{$error}</p>
{else}
  <p>L'ordine richiesto non &egrave; stato ancora completamente processato o non appartiene all'utente corrente</p>
{/if}
</div>

</div>