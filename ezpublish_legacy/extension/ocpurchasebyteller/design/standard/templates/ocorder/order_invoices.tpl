{foreach $helper.invoices as $i => $invoice}  
  <div class="invoice{if $i|gt(0)} page_break_before{/if}">
  {include uri="design:invoice/invoice.tpl" invoice=$invoice}
  </div>
{/foreach}