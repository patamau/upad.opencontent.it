{def $ente = fetch( content, object, hash( object_id, $course.current.data_map.ente.content.relation_list[0].contentobject_id ) )
$codice_area = fetch( content, object, hash( object_id, $course.current.data_map.codice_area.content.relation_list[0].contentobject_id ) )
$num_lezioni = $course.data_map.numero_lezioni.content
$subscriptions = fetch( 'content', 'tree', hash( parent_node_id, 1,
class_filter_type, 'include',
class_filter_array, array( 'subscription' ),
attribute_filter, array( 'and', array( 'subscription/course', '=', $course.id ), array( 'subscription/annullata', '=', '0' ) ),
sort_by, array( 'published', true() ) ) )

$subscriptions_count = fetch(
    'content', 'tree_count', hash(
        parent_node_id, 1,
        attribute_filter, array( 'and', array( 'subscription/course', '=', $course.id ), array( 'subscription/annullata', '=', '0' )),
        class_filter_type, 'include',
        class_filter_array, array( 'subscription' )
    )
)
$count = 1}

<div class="container attendance{if gt($c, 1)} page_break_before{/if}">
    <table class="table header" cellspacing="0" cellpadding="0" border="0" style="width:100%;">
        <tbody>
        <tr>
            <td style="width: 100px; text-align: center;">
                <img src="{$ente.data_map.image.content['medium'].url|ezroot(no,full)}"
                     title="{$ente.name|wash(xhtml)}"/>
                <strong>{attribute_view_gui attribute=$ente.data_map.title}</strong>
            </td>
        </tr>
        </tbody>
    </table>
    <hr/>
    <h1>Lista iscritti confermati / prenotati</h1>
    <h3>{attribute_view_gui attribute=$course.data_map.title} - {$codice_area.data_map.codice.content}
        -{$ente.data_map.codice.content}-{$course.data_map.anno.content}-{$course.data_map.codice.content}
        -{$course.data_map.edizione.content}</h3>
    <table class="table" cellspacing="0" cellpadding="0" border="0" style="width:100%;">
        <tbody>
        <tr>
            <td style="width: 50%; border: none">Data inizio:
                <strong>{attribute_view_gui attribute=$course.data_map.data_inizio}</strong></td>
        </tr>
        <tr>
            <td style="border: none">Data fine:
                <strong>{attribute_view_gui attribute=$course.data_map.data_fine}</strong></td>
        </tr>
        </tbody>
    </table>
    <br/>
    <table class="table box" cellspacing="0" cellpadding="0" border="0"
           style="table-layout: fixed; border: 1px solid #ccc;">
        <tbody>
        <tr>
            <td>#</td>
            <td>Iscritto/a</td>
            <td>Indirizzo</td>
            <td>Città</td>
            <td>Telefono</td>
            <td>Ultima Ricevuta<br/>Nr<br/>Data</td>
            <td>Totale ricevute</td>
        </tr>
        {if $subscriptions_count|gt(0)}
            {def $total_amount = 0}
            {foreach $subscriptions as $subscription}
                <tr>
                    <td>{$count}</td>
                    <td>{$subscription.data_map.user.content.current.data_map.first_name.content|wash()} {$subscription.data_map.user.content.current.data_map.last_name.content|wash()}</td>
                    <td>{$subscription.data_map.user.content.current.data_map.indirizzo_residenza.content|wash()}</td>
                    <td>{attribute_view_gui attribute=$subscription.data_map.user.content.current.data_map.luogo_residenza}{*$subscription.data_map.user.content.current.data_map.luogo_residenza|attribute(show)*}</td>
                    <td>{$subscription.data_map.user.content.current.data_map.telefono.content|wash()}</td>
                    <td>
                        {def $reverse_invoices = $subscription.data_map.invoices.content.rows.sequential|reverse()
                        $invoice = fetch( courses, invoice, hash( 'id', $reverse_invoices[0].columns[0] ))}
                        {$invoice.invoice_id}<br/>{$invoice.date|l10n(shortdate)}
                        {undef $reverse_invoices $invoice}
                    </td>
                    <td style="text-align: right">
                        {def $user_total = 0}
                        {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
                            {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
                            {set $user_total = $user_total|sum($invoice.total)}
                            {undef $invoice}
                        {/foreach}
                        {set $total_amount = $total_amount|sum($user_total)}
                        {$user_total|l10n( 'currency' )}
                        {undef $user_total}
                    </td>
                </tr>
                {set $count = $count|sum(1)}
            {/foreach}
            <tr class="last">
                <td colspan="4"></td>
                <td><strong>Totale</strong></td>
                <td style="text-align: right"><strong>{$total_amount|l10n( 'currency' )}</strong></td>
            </tr>
            {undef $total_amount}
        {/if}
        </tbody>
    </table>
</div>
{undef $ente $count}
