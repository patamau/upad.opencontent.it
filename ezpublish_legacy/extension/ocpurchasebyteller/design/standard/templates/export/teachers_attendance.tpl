{def $ente = fetch( content, object, hash( object_id, $course.current.data_map.ente.content.relation_list[0].contentobject_id ) )
     $codice_area = fetch( content, object, hash( object_id, $course.current.data_map.codice_area.content.relation_list[0].contentobject_id ) )
     $num_lezioni = $course.data_map.numero_lezioni.content}

<div class="container teachers-attendance">

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
    <br />
    <h1 style="text-align: center">Presenze professori<br />{attribute_view_gui attribute=$course.data_map.title}</h1>
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
                <td style="border: none">Durata singola lezione: </td>
            </tr>
        </tbody>
    </table>
    <br />
    <table class="table box" cellspacing="0" cellpadding="0" border="0"  style="width:100%; border: 1px solid #ccc;">
        <tbody>
            <tr>
                <td style="width:10%;">Data</td>
                <td style="width:10%;">Dalle</td>
                <td style="width:10%;">Alle</td>
                <td style="width:20%;">Firma</td>
                <td style="width:5%;">Visto</td>
                <td style="width:45%;" class="last">Argomento</td>
            </tr>
            {for 1 to $num_lezioni as $i}
                <tr class="{if eq($i|mod(27), 0)}page_breaker{/if}{if eq($num_lezioni, $i)} last{/if}">
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td class="last">&nbsp;<br/>&nbsp;</td>
                </tr>
            {/for}
        </tbody>
    </table>
</div>
