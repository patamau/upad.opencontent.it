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
      {'Name'|i18n('design/standard/shop')}: {$invoice.user.contentobject.data_map.first_name.content|wash()} {$invoice.user.contentobject.data_map.last_name.content|wash()}<br />
      {*'Email'|i18n('design/standard/shop')}: {$invoice.user.contentobject.data_map.user_account.content.email|wash()}<br />*}
      Partita IVA/Codice Fiscale: {$invoice.user.contentobject.data_map.codice_fiscale.content|wash()}<br />
      {*Recapito telefonico: {$invoice.user.contentobject.data_map.telefono.content|wash()}<br />*}
    </p>

    </td>
    <td valign="top" style="width: 50%">
      <p><strong>{"Address"|i18n("design/standard/shop")}</strong></p>
      <p>
      {'Street'|i18n('design/standard/shop')}: {$invoice.user.contentobject.data_map.indirizzo_residenza.content|wash()}<br />
      {'Zip'|i18n('design/standard/shop')}: {$invoice.user.contentobject.data_map.cap_residenza.content|wash()}<br />
      {*'Place'|i18n('design/standard/shop')}: {$invoice.user.contentobject.data_map.comune_residenza.content|wash()}<br />
      {*'State'|i18n('design/standard/shop')}: {$invoice.user.contentobject.data_map.provincia_residenza.content|wash()}<br />*}
      {'Place'|i18n('design/standard/shop')}: {attribute_view_gui attribute=$invoice.user.contentobject.data_map.luogo_residenza}<br />
      </p>
    </td>
  </tr>
</table>

<hr />

<table class="table" cellspacing="0" cellpadding="0" border="0"  style="width:100%">
<thead>
<tr>
    <th><strong>Causale</strong></th>
    <th><strong>Importo</strong></th>
</tr>
</thead>
<tbody>

{foreach $invoice.items as $item}
  <tr>
		<td>
		   {$item.description}
		</td>
		<td class="number" align="center">{$item.total|l10n( 'currency', $invoice.locale, $invoice.symbol )}</td>
  </tr>
{/foreach}
</tbody>
</table>

<hr />
<table cellspacing="0" cellpadding="0" border="0"  style="width:100%">
<tbody>
    <tr>
        <th><b>Totale corrispettivo</b></th>
        <td class="number" align="center"><b>{$invoice.product_total_inc_vat|l10n( 'currency', $invoice.locale, $invoice.symbol )}</b></td>
    </tr>
</tbody>
</table>
