<table class="table" cellspacing="0" cellpadding="0" border="0">
  <tr>
    <td valign="top">
    <p><strong>{"Customer"|i18n("design/standard/shop")}</strong></p>
    <p>
      {'Name'|i18n('design/standard/shop')}: {$order.account_information.first_name} {$order.account_information.last_name}<br />
      {'Email'|i18n('design/standard/shop')}: {$order.account_information.email}<br />
      Partita IVA o Codice Fiscale: {$order.account_information.vat}<br />
      Recapito telefonico: {$order.account_information.tel1}<br />
      Telefono cellulare: {$order.account_information.tel2}
    </p>

    </td>
    <td valign="top">
      <p><strong>{"Address"|i18n("design/standard/shop")}</strong></p>
      <p>
      {'Company'|i18n('design/standard/shop')}: {$order.account_information.street1}<br />
      {'Street'|i18n('design/standard/shop')}: {$order.account_information.street2}<br />
      {'Zip'|i18n('design/standard/shop')}: {$order.account_information.zip}<br />
      {'Place'|i18n('design/standard/shop')}: {$order.account_information.place}<br />
      {'State'|i18n('design/standard/shop')}: {$order.account_information.state}<br />
      {'Country/region'|i18n('design/standard/shop')}: {$order.account_information.country}<br />
      </p>
    </td>
    {if $order.account_information.send_street|ne('')}
      <td valign="top">
      <p><strong>Indirizzo di spedizione</strong></p>
      <p>
        {'Street'|i18n('design/standard/shop')}: {$order.account_information.send_street}<br />
        {'Zip'|i18n('design/standard/shop')}: {$order.account_information.send_zip}<br />
        {'Place'|i18n('design/standard/shop')}: {$order.account_information.send_place}<br />
        {'State'|i18n('design/standard/shop')}: {$order.account_information.send_state}<br />
        {'Country/region'|i18n('design/standard/shop')}: {$order.account_information.send_country}
       </p>
      </td>
    {/if}     
  </tr>
</table>

{if $order.account_information.comment}
<p><strong>{'Comment'|i18n( 'design/standard/shop' )}</strong></p>
<p>{$order.account_information.comment|wash|nl2br}</p>
{/if}
