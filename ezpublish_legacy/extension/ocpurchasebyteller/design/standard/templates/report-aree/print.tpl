{def $ente_object = fetch( content, object, hash( object_id, $ente ) )
     $total = 0}

<div class="container teachers-attendance">
    <table class="table header" cellspacing="0" cellpadding="0" border="0"  style="width:100%;">
        <tbody>
            <tr>
                <td style="width: 100px; text-align: center;">
                  <img src="{$ente_object.data_map.image.content['medium'].url|ezroot(no,full)}" title="{$ente_object.name|wash(xhtml)}" /><br />
                    <strong>{attribute_view_gui attribute=$ente_object.data_map.title}</strong>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <h1 style="text-align: center">Report centro di costo {$mesi[$mese]} {$anno}</h1>

    <br />
    <table class="table box" cellspacing="0" cellpadding="0" border="0"  style="width:100%; border: 1px solid #ccc;">
        <tbody>
            <tr>
                <td>Area</td>
                <td>Totale €</td>
                <td>Codice contabile</td>
                <td>Centro di costo</td>
            </tr>
            {foreach $search_results as $k => $v}
                <tr>
                    <td>{$v.codice}-{$v.name}</td>
                    <td style="text-align: right">{$v.total_amount|l10n( 'currency' )}</td>
                    <td>{$v.conto_contabile}</td>
                    <td>{$v.centro_costo}</td>
                </tr>
                {set $total = $total|sum($v.total_amount)}
            {/foreach}
            <tr class="last">
                <td style="text-align: right"><strong>Totale mensile €</strong></td>
                <td style="text-align: right"><strong>{$total|l10n( 'currency' )}</strong></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>
</div>
