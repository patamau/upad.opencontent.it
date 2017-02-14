<table class="table" cellspacing="0" cellpadding="0" border="0"  style="width:100%">
<tbody>
<tr>
    <td>Ricevuta nr: <strong>%NUMBER%</strong> del <strong>%DATE%</strong>{if lt($invoice.product_total_inc_vat, 0)} (storno){/if}</td>
</tr>
</tbody>
</table>

<hr />

<table class="table" cellspacing="0" cellpadding="0" border="0"  style="width:100%">
  <tr>
    <td valign="top" style="width: 50%">
    <p><strong>{"Customer"|i18n("design/standard/shop")}</strong></p>
    <p>
      {'Name'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.first_name} {$invoice.reference_order.account_information.last_name}<br />
      {'Email'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.email}<br />
      Partita IVA/Codice Fiscale: {$invoice.reference_order.account_information.vat}<br />
      Recapito telefonico: {$invoice.reference_order.account_information.tel1}<br />
      Telefono cellulare: {$invoice.reference_order.account_information.tel2}
    </p>

    </td>
    <td valign="top" style="width: 50%">
      <p><strong>{"Address"|i18n("design/standard/shop")}</strong></p>
      <p>
      {*'Company'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.street1}<br />*}
      {'Street'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.street1}<br />
      {'Zip'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.zip}<br />
      {'Place'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.place}<br />
      {*'State'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.state}<br />*}
      {*'Country/region'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.country}<br />*}
      </p>
    </td>
    {*if $invoice.reference_order.account_information.send_street|ne('')}
      <td valign="top">
      <p><strong>Indirizzo di spedizione</strong></p>
      <p>
        {'Street'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.send_street}<br />
        {'Zip'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.send_zip}<br />
        {'Place'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.send_place}<br />
        {'State'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.send_state}<br />
        {'Country/region'|i18n('design/standard/shop')}: {$invoice.reference_order.account_information.send_country}
       </p>
      </td>
    {/if*}
  </tr>
</table>

<hr />

<table class="table" cellspacing="0" cellpadding="0" border="0"  style="width:100%">
<thead>
<tr>
    <th style="width:60px"><strong>Q.t&agrave;</strong></th>
    <th><strong>Causale</strong></th>
    <th><strong>Importo unitario</strong></th>
    <th><strong>Importo complessivo</strong></th>
</tr>
</thead>
<tbody>

{foreach $invoice.products as $ProductItem}
    <tr>
        <td class="number" align="left">
            {$ProductItem.item_count}
        </td>
		<td>
		   {$ProductItem.item_object.name|wash}
		</td>
		<td class="number" align="center">{$ProductItem.price_ex_vat|l10n( 'currency', $invoice.locale, $invoice.symbol )}</td>
		<td class="number" align="center">{$ProductItem.total_price_ex_vat|l10n( 'currency', $invoice.locale, $invoice.symbol )}</td>
    </tr>
{/foreach}
</tbody>
</table>

<hr />
<table cellspacing="0" cellpadding="0" border="0"  style="width:100%">
<tbody>

    <tr>
        <th colspan="4">Totale IVA esclusa:</th>
        <td class="number" align="center">{$invoice.product_total_ex_vat|l10n( 'currency', $invoice.locale, $invoice.symbol )}</td>
    </tr>
    <tr>
        <th colspan="4">IVA:</th>
        <td class="number" align="center">{$invoice.product_total_inc_vat|sub($invoice.product_total_ex_vat)|l10n( 'currency', $invoice.locale, $invoice.symbol )}</td>
    </tr>
    <tr>
        <th colspan="4"><b>Totale corrispettivo</b></th>
        <td class="number" align="center"><b>{$invoice.product_total_inc_vat|l10n( 'currency', $invoice.locale, $invoice.symbol )}</b></td>
    </tr>

</tbody>
</table>
