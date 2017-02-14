{def $ente = fetch( content, object, hash( object_id, $course.current.data_map.ente.content.relation_list[0].contentobject_id ) )
     $codice_area = fetch( content, object, hash( object_id, $course.current.data_map.codice_area.content.relation_list[0].contentobject_id ) )
     $num_lezioni = $course.data_map.numero_lezioni.content
     $subscriptions = fetch( 'content', 'tree', hash( parent_node_id, 1,
                                                        class_filter_type, 'include',
                                                        class_filter_array, array( 'subscription' ),
                                                        attribute_filter, array( array( 'subscription/course', '=', $course.id ) ),
                                                        sort_by, array( 'name', true() ) ) )

     $subscriptions_count = fetch( 'content', 'tree_count', hash( parent_node_id, 1,
                                                                 attribute_filter, array( array( 'subscription/course', '=', $course.id ) ),
                                                                 class_filter_type, 'include',
                                                                 class_filter_array, array( 'subscription' ) ) )
     $sub_count = 1}

{def $pages = 1
     $extra = 2
     $num_lezioni_piu_extra = $num_lezioni|sum($extra)
     $columns = 12
     $mod = $num_lezioni_piu_extra|mod($columns)
     $number = 1
     $end = 12}


{if eq($mod, 0)}
    {set $columns = $columns|sub($extra)
         $end = $end|sub($extra)
         $mod = $num_lezioni_piu_extra|mod($columns)}
{/if}


{if gt($mod, 0)}
    {set $pages = ceil($num_lezioni_piu_extra|div($columns))}
{else}
    {set $pages = floor($num_lezioni_piu_extra|div($columns))}
{/if}

{if eq($pages, 0)}
    {set $pages = 1}
{/if}

{for 1 to $pages as $c}
    {if eq($c, $pages)}
        {set $end = $mod|sub($extra)}
    {/if}

    <div class="container attendance{if gt($c, 1)} page_break_before{/if}">
        <table class="table header" cellspacing="0" cellpadding="0" border="0"  style="width:100%;">
            <tbody>
                <tr>
                    <td style="width: 100px; text-align: center;">
                      <img src="{$ente.data_map.image.content['medium'].url|ezroot(no,full)}" title="{$ente.name|wash(xhtml)}" />
                        <strong>{attribute_view_gui attribute=$ente.data_map.title}</strong>
                    </td>
                </tr>
            </tbody>
        </table>
        <hr />
        <h3>{attribute_view_gui attribute=$course.data_map.title}</h3>
        <table class="table" cellspacing="0" cellpadding="0" border="0"  style="width:100%;">
            <tbody>
                <tr>
                    <td>Docente: <strong>{attribute_view_gui attribute=$course.data_map.docente}</strong></td>
                    <td><strong>{$codice_area.data_map.codice.content}-{$ente.data_map.codice.content}-{$course.data_map.anno.content}-{$course.data_map.codice.content}-{$course.data_map.edizione.content}</strong></td>
                </tr>
                <tr>
                    <td style="width: 50%; border: none">Data inizio: <strong>{attribute_view_gui attribute=$course.data_map.data_inizio}</strong></td>
                    <td style="border: none">Durata corso in lezioni: <strong>{attribute_view_gui attribute=$course.data_map.numero_lezioni}</strong></td>
                </tr>
                <tr>
                    <td style="width: 50%; border: none">Data fine: <strong>{attribute_view_gui attribute=$course.data_map.data_fine}</strong></td>
                    <td style="border: none">Orario corso: <strong>{attribute_view_gui attribute=$course.data_map.orario}</strong></td>
                </tr>
            </tbody>
        </table>
        {if gt($num_lezioni, 0)}
            <br />
            <table class="table box" cellspacing="0" cellpadding="0" border="0"  style="table-layout: fixed; border: 1px solid #ccc;">
                <tbody>
                    <tr>
                        <td class="hidden" style="width: 10px">#</td>
                        <td style="width: 70px">Iscritto/a</td>
                        <td style="width: 45px">Nr<br />Data</td>
                        {if gt($end, 0)}
                            {for 1  to $end as $i}
                              {set $number = $i|sum($columns|mul($c|sub(1))) }
                              <td{if and(eq($i, $end), ne($c, $pages))} class="last"{/if} style="width: 55px">{$number}^ lezione</td>
                            {/for}
                        {/if}
                        {if eq($c, $pages)}
                            <td style="width: 55px"></td>
                            <td class="last" style="width: 55px"></td>
                        {/if}
                    </tr>
                    {if $subscriptions_count|gt(0)}
                        {set $sub_count = 1}
                        {foreach $subscriptions as $subscription}
                            {if eq($subscription.data_map.annullata.content, 0)}
                                <tr>
                                    <td class="hidden">{$sub_count}</td>
                                    <td>{$subscription.data_map.user.content.current.data_map.last_name.content|wash()} {$subscription.data_map.user.content.current.data_map.first_name.content|wash()}</td>
                                    <td>
                                        {def $reverse_invoices = $subscription.data_map.invoices.content.rows.sequential|reverse()
                                              $invoice = fetch( courses, invoice, hash( 'id', $reverse_invoices[0].columns[0] ))}

                                        {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
                                            {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
                                            {if $invoice.total|gt(0)}
                                                {break}
                                            {else}
                                                {undef $invoice}
                                            {/if}
                                        {/foreach}
                                        {$invoice.invoice_id}<br />{$invoice.date|l10n(shortdate)}
                                        {undef $reverse_invoices $invoice}
                                    </td>
                                    {if gt($end, 0) }
                                        {for 1  to $end as $i}
                                            <td{if and(eq($i, $end), ne($c, $pages))} class="last"{/if}></td>
                                        {/for}
                                    {/if}
                                    {if eq($c, $pages)}
                                        <td></td>
                                        <td class="last"></td>
                                    {/if}

                                </tr>
                            {/if}
                            {* Elimino per richiesta email 18/05/2015 *}
                            {*else}
                                <tr>
                                    <td>{$subscription.data_map.user.content.name|wash()}</td>
                                    <td>
                                        {def $reverse_invoices = $subscription.data_map.invoices.content.rows.sequential|reverse()
                                              $invoice = fetch( courses, invoice, hash( 'id', $reverse_invoices[0].columns[0] ))}

                                        {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
                                            {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
                                            {if $invoice.total|gt(0)}
                                                {break}
                                            {else}
                                                {undef $invoice}
                                            {/if}
                                        {/foreach}
                                        {$invoice.invoice_id}<br />{$invoice.date|l10n(shortdate)}
                                        {undef $reverse_invoices $invoice}
                                    </td>
                                    <td colspan="{$end}"{if ne($c, $pages)} class="last"{/if} style="text-align:center;">Iscrizione annullata</td>
                                    {if eq($c, $pages)}
                                        <td></td>
                                        <td class="last"></td>
                                    {/if}
                                </tr>
                            {/if*}

                            {set $sub_count = $sub_count|sum(1)}
                        {/foreach}
                    {/if}
                    {* Aggiungo 5 righe in più come da richiesta *}
                    {for 1  to 5 as $r}
                        <tr{if eq($r, 5)} class="last"{/if}>
                            <td class="hidden"></td>
                            <td>{if eq($r, 5)} Firma docente{else} &nbsp;<br />&nbsp;{/if}</td>
                            <td></td>
                            {if gt($end, 0) }
                               {for 1  to $end as $i}
                                   <td{if and(eq($i, $end), ne($c, $pages))} class="last"{/if}></td>
                               {/for}
                            {/if}
                            {if eq($c, $pages)}
                              <td></td>
                              <td class="last"></td>
                            {/if}
                        </tr>
                    {/for}
                </tbody>
            </table>

        {/if}
    </div>
{/for}
{*<br />
<div class="container attendance">
    <table class="table box" cellspacing="0" cellpadding="0" border="0"  style="width: 100%; border: 1px solid #ccc;">
        <tbody>
            <tr class="last">
                <td style="width:30%">Docente</td>
                <td class="last">&nbsp;</td>
            </tr>
        </tbody>
    </table>
</div>*}


{undef $ente $num_lezioni $count}
