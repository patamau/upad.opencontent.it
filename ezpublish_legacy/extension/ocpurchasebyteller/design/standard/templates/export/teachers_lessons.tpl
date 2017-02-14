{def $ente = fetch( content, object, hash( object_id, $course.current.data_map.ente.content.relation_list[0].contentobject_id ) )
     $num_lezioni = $course.data_map.numero_lezioni.content}

{switch match=$ente.id}

    {case match=160}
        {def $tsx = 'M7.05.03'
             $tdx = 'Rev. 00'
             $bsx = 'P7.05- All. 5'}
    {/case}

    {case}
        {def $tsx = ''
             $tdx = ''
             $bsx = ''}
    {/case}

{/switch}

<div class="container teachers-lessons">
    <table class="table header" cellspacing="0" cellpadding="0" border="0"  style="width:100%; border: 1px solid #ccc;">
        <tbody>
            <tr>
                <td rowspan="2" style="width: 100px">
                  <img src="{$ente.data_map.image.content['medium'].url|ezroot(no,full)}" title="{$ente.name|wash(xhtml)}" />
                </td>
                <td rowspan="2" style="text-align: center;"><strong>{attribute_view_gui attribute=$ente.data_map.title}</strong></td>
                <td>{$tsx}</td>
                <td>{$tdx}</td>
            </tr>
            <tr>
                <td>{$bsx}</td>
                <td>pag. <span id="pagenumber"></span> di <span id="pagecount"></span></td>
            </tr>
        </tbody>
    </table>
    <br />
    <table class="table" cellspacing="0" cellpadding="0" border="0"  style="width:100%;">
        <tbody>
            <tr>
                <td style="width: 70%; border: none">Corso: <strong>{attribute_view_gui attribute=$course.data_map.title}</strong></td>
                <td style="border: none">Cod: <strong>{attribute_view_gui attribute=$course.data_map.product_number}</strong></td>
            </tr>
        </tbody>
    </table>

    {for 1 to $num_lezioni as $i}
        <br />
        <table class="table box{if eq($i|mod(7), 0)} page_breaker{/if}" cellspacing="0" cellpadding="0" border="0"  style="width:100%; border: 1px solid #ccc;">
            <tbody>
                <tr>
                    <td style="width: 30%">Data</td>
                    <td style="width: 40%">Orario lezione - dalle ore</td>
                    <td style="width: 30%">alle ore</td>
                </tr>
                <tr>
                    <td colspan="3">Argomento trattato</td>
                </tr>
                <tr>
                    <td colspan="2" style="width: 40%">Firma docente</td>
                    <td style="width: 60%">Firma verifica</td>
                </tr>
                <tr class="last">
                    <td colspan="3">Note</td>
                </tr>
            </tbody>
        </table>
    {/for}
</div>
