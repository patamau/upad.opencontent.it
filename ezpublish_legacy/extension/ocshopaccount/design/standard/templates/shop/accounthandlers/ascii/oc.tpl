{"Customer information"|i18n('design/standard/shop')}:
{$order.account_information.first_name} {$order.account_information.last_name}{if $order.account_information.street1} ({$order.account_information.street1}){/if}

{"Email"|i18n('design/standard/shop')}:
{$order.account_information.email}

{"Shipping address"|i18n('design/standard/shop')}:
{$order.account_information.street2}
{$order.account_information.zip} {$order.account_information.place}
Partita IVA o Codice Fiscale: {$order.account_information.vat}
Recapito telefonico: {$order.account_information.tel1}
Telefono cellulare: {$order.account_information.tel2}

{if $order.account_information.state}{$order.account_information.state} {/if}{$order.account_information.country}
