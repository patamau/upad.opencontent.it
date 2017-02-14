<div class="container">
{include uri="design:invoice/header.tpl" invoice=$invoice}
{$invoice.text|explode( '%NUMBER%' )|implode( $invoice.invoice_id_string )|explode( '%DATE%' )|implode( $invoice.date|l10n( 'shortdate' ) )}
{include uri="design:invoice/footer.tpl" invoice=$invoice}
</div>
