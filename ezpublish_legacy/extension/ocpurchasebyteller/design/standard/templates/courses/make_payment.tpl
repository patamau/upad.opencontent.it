<div class="container">
  <h2>Esegui pagamento per il corso <a href={concat('courses/list/', $course.id)|ezurl}><strong>{$course.name|wash()}</strong></a> per conto di <strong>{$user.name|wash()}</strong></h2>
  <hr />
  <div class="well">
    <form class="form-inline" role="form" action={concat("courses/make_payment/",$course.id,"/",$user.id)|ezurl()} method="post">
      <div class="input-group">
        <div class="input-group-addon">€</div>
        <input type="text" name="PaymentValue" class="form-control" placeholder="Inserisci importo" value="{$course.data_map.price.content.price|wash()}">
      </div>
      <div class="checkbox">
        <label>
          <input type="checkbox" name="PaymentWriteOff"> Esegui storno
        </label>
      </div>
      <button type="submit" name="MakePaymentButton" class="btn btn-danger">Esegui</button>
    </form>
  </div>


  <h2 class="m_bottom_20">Ricevute emesse a {$user.name|wash()} per il corso {$course.name|wash()}</h2>
  <table class="table">
    <tr>
      <th><strong>Numero</strong></th>
      <th><strong>Data</strong></th>
      <th><strong>Totale</strong></th>
      <th style="width:200px"></th>
    </tr>

  {def $subscription = fetch( 'content', 'object', hash( 'remote_id', concat( 'subscription_', $course.id, '_', $user.id )  ) )
  	$url=''}
  {if $subscription}
    {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
      {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
        <tr>
          <td>{$invoice.invoice_id_string}</td>
          <td>{$invoice.date|l10n(shortdate)}</td>
          <td>{$invoice.total|l10n( 'currency' )}</td>
          <td>
          	{set $url=concat("layout/set/pdf/invoice/view/",$invoice.id)|ezurl('no')}
            <a class="btn btn-sm btn-danger" href='{$url}' title="Apri {$invoice.id}" target="{$invoice.id}"><i class="fa fa-eye"></i> Apri</a>
            <a class="btn btn-sm btn-danger" href='{$url}' download="invoice{$invoice.id}.pdf" title="Scarica {$invoice.id}"><i class="fa fa-download"></i> Scarica</a>
            {*
          	{set $url=concat("layout/set/pdf/invoice/view/",$invoice.id)|ezurl('no','full')}
            <a class="btn btn-sm btn-danger" onclick="printPage('{$url}')" title="Stampa"><i class="fa fa-print"></i></a>
            *}
          </td>
        </tr>
      {undef $invoice}
    {/foreach}
  {/if}
  </table>
  {undef $subscription $url}


</div>
