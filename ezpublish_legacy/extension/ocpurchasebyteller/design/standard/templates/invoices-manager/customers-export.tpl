{def $ente = $invoices[0].ente
     $range = ''}

{if $a}
    {set $range = concat('dal ', $da, ' al ', $a)}
{else}
    {set $range = concat('del ', $da)}
{/if}

<div class="container invoices-customers-export">
    <table class="table header" cellspacing="0" cellpadding="0" border="0"  style="width:100%;">
        <tbody>
            <tr>
                <td style="width: 210px">
                    <img src="{$ente.data_map.image.content['medium'].url|ezroot(no,full)}" title="{$ente.name|wash(xhtml)}" />
                </td>
                <td>{attribute_view_gui attribute=$ente.data_map.header_invoice}</td>
            </tr>
        </tbody>
    </table>
    <hr />
    <h1>Riepilogo ricevute {$range}</h1>
    <br />
    <table class="table box" cellspacing="0" cellpadding="0" border="0"  style="border: 1px solid #ccc; width: 100%">
        <tbody>
            <tr>
                <td>Data</td>
                <td>N.ricevuta</td>
                <td>Cliente</td>
                <td>Importo</td>
            </tr>
            {def $total_amount = 0}
            {foreach $invoices as $i}
                {def $user = fetch( 'content', 'object', hash( 'object_id', $i.user_id ) )}
                {set $total_amount = $total_amount|sum($i.total)}
                <tr>
                    <td>{$i.date|l10n(shortdate)}</td>
                    <td>{$i.invoice_id_string}{if ne($i.order_id, 0)} (Ecommerce){/if}</td>
                    <td>{$user.data_map.first_name.content} {$user.data_map.last_name.content}</td>
                    <td style="text-align: right">{$i.total|l10n( 'currency' )}</td>
                </tr>
            {/foreach}
            <tr class="last">
               <td colspan="3" style="text-align: right"><strong>Totale</strong></td>
               <td style="text-align: right"><strong>{$total_amount|l10n( 'currency' )}</strong></td>
            </tr>
            {undef $total_amount}
        </tbody>
    </table>
    <table class="table footer" cellspacing="0" cellpadding="0" border="0"  style="width: 50%">
        <tr>
            <td>Contanti:</td>
            <td>_____________________________</td>
        </tr>
        <tr>
            <td>Bancomat:</td>
            <td>_____________________________</td>
        </tr>
        <tr>
            <td>Bonifici:</td>
            <td>_____________________________</td>
        </tr>
        <tr>
            <td>Ecommerce:</td>
            <td>_____________________________</td>
        </tr>
        <tr>
            <td>Totale:</td>
            <td>_____________________________</td>
        </tr>
    </table>
</div>
{undef $ente}
