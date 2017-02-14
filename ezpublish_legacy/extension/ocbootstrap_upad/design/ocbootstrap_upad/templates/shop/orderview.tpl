<div class="container">
    <div class="row clearfix">
        <div class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>


            <div class="shop-orderview">

            <div class="attribute-header">
              <h1 class="long">{'Order %order_id [%order_status]'|i18n( 'design/ocbootstrap/shop/orderview',,
                   hash( '%order_id', $order.order_nr,
                         '%order_status', $order.status_name ) )}</h1>
            </div>

            {shop_account_view_gui view=html order=$order}

            {def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
                     $locale = false()
                     $symbol = false()}

            {if $currency}
                {set locale = $currency.locale
                     symbol = $currency.symbol}
            {/if}

			{if $order.status_id|eq( 1001 )}
			  {* istruzioni bonifico *}
			  <div class="alert alert-info">
			  <p><strong>Istruzioni per il pagamento con bonifico bancario:</strong></p>
			  {def $iban = ezini( 'Settings', 'IBAN', 'bonificobancario.ini' )
				   $intestazione_iban = ezini( 'Settings', 'IntestatarioIBAN', 'bonificobancario.ini' )}
			  {if $iban|is_array()}
				{foreach $iban as $index => $i}
					<p>Effettua il bonifico bancario all'IBAN <strong>{$i}</strong>
					{if $intestazione_iban|is_array()}
						intestato a <strong>{$intestazione_iban[$index]}</strong>.</p>
					{else}
						intestato a <strong>{$intestazione_iban}</strong>.</p>
					{/if}
					{delimiter} <p>oppure</p> {/delimiter}
				{/foreach}
			  {else}
				<p>Effettua il bonifico bancario all'IBAN <strong>{$iban}</strong></p>
				<p>Intestato a <strong>{$intestazione_iban}</strong>.</p>
			  {/if}
			  {def $note_node_id = ezini('Settings', 'NoteNodeID', 'bonificobancario.ini')}
				{if $note_node_id}
				{def $note = fetch('content','node',hash('node_id',$note_node_id))}
				{if $note.data_map.description.has_content}
				  <small>{attribute_view_gui attribute=$note.data_map.description}</small>
				{/if}
			  {/if}

			  </div>
			{/if}

            <hr />

            <h3>{'Product items'|i18n( 'design/ocbootstrap/shop/orderview' )}</h3>
            <table class="table" width="100%" cellspacing="0" cellpadding="0" border="0"  style="width: 100%">
            <tr>
                <th>
                {'Product'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
                <th>
                {'Count'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
                <th>
                {'VAT'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
                <th>
                {'Price inc. VAT'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
                <th>
                {'Discount'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
                <th>
                {'Total price ex. VAT'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
                <th>
                {'Total price inc. VAT'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
            </tr>
            {if $order.product_items|count()}
            {foreach $order.product_items as $product_item sequence array( 'bglight', 'bgdark' ) as $style}
            <tr class="{$style}">
                <td>
                <a href={concat( "/content/view/full/", $product_item.node_id )|ezurl}>{$product_item.object_name}</a>
                </td>
                <td>
                {$product_item.item_count}
                </td>
                <td>
                {$product_item.vat_value} %
                </td>
                <td>
                {$product_item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
                </td>
                <td>
                {$product_item.discount_percent}%
                </td>
                <td>
                {$product_item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
                </td>
                <td>
                {$product_item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}
                </td>
            </tr>
            {/foreach}
            {/if}
            </table>
<hr />
            <h3>{'Order summary'|i18n( 'design/ocbootstrap/shop/orderview' )}:</h3>
            <table class="table" cellspacing="0" cellpadding="0" border="0" style="width: 100%">
            <tr>
                <th>
                {'Summary'|i18n( 'design/ocbootstrap/shop/orderview' )}:
                </th>
                <th>
                {'Total price ex. VAT'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
                <th>
                {'Total price inc. VAT'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </th>
            </tr>
            <tr class="bglight">
                <td>
                {'Subtotal of items'|i18n( 'design/ocbootstrap/shop/orderview' )}:
                </td>
                <td>
                {$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}
                </td>
                <td>
                {$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}
                </td>
            </tr>
            {if $order.order_items|count()}
            {foreach $order.order_items as $order_item sequence array( 'bglight', 'bgdark' ) as $style}
            <tr class="{$style}">
                <td>
                {$order_item.description}:
                </td>
                <td>
                {$order_item.price_ex_vat|l10n( 'currency', $locale, $symbol )}
                </td>
                <td>
                {$order_item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
                </td>
            </tr>
            {/foreach}
            {/if}
            <tr class="bgdark">
                <td>
                    {'Order total'|i18n( 'design/ocbootstrap/shop/orderview' )}
                </td>
                <td>
                    {$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}
                </td>
                <td>
                    {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
                </td>
            </tr>
            </table>
<hr />

            <h3>{'Order history'|i18n( 'design/ocbootstrap/shop/orderview' )}:</h3>
            <table class="table" cellspacing="0" cellpadding="0" border="0" style="width: 100%">
            <tr>
                <th>{'Date'|i18n( 'design/ocbootstrap/shop/orderview' )}</th>
                <th>{'Order status'|i18n( 'design/ocbootstrap/shop/orderview' )}</th>
            </tr>
            {def $order_status_history=fetch( 'shop', 'order_status_history', hash( 'order_id', $order.order_nr ) )}
            {if $order_status_history|count()}
            {foreach $order_status_history as $history sequence array( 'bglight', 'bgdark' ) as $style}
            <tr class="{$style} ">
                <td class="date">{$history.modified|l10n( 'shortdatetime' )}</td>
                <td>{$history.status_name|wash}</td>
            </tr>
            {/foreach}
            {/if}
	    {* Bottone per scaricare la fattura *}
	    {if or($order.status_id|eq( 3 ), $order.status_id|eq( 1000 ), $order.status_id|eq( 1002 ))}
		<table class="table m_top_20" cellspacing="0" cellpadding="0" border="0"  style="width: 100%">
		    <tr>
			<td>
			    <a href={concat("layout/set/pdf/ocorder/invoice/", $order.id)|ezurl} class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light f_right">Scarica la fattura</a>
			</td>
		    </tr>
		</table>
	    {/if}
            </table>

            </div>
        </div>
    </div>
</div>
