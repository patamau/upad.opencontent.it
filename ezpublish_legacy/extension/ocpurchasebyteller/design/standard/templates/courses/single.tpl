{def $ente = fetch( content, object, hash( object_id, $course.data_map.ente.content.relation_list[0].contentobject_id ) )
$codice_area = fetch( content, object, hash( object_id, $course.data_map.codice_area.content.relation_list[0].contentobject_id ) ) 
$area_tematica = fetch( 'content', 'related_objects', hash( 'object_id', $course.id, 'attribute_identifier', 'corso/area_tematica') )[0]
}

<div class="container">
    <h1>{$course.name|wash()}</h1>
    
    {def $is_tesseramento = $area_tematica.name|eq('Tesseramento')}

    <hr class="m_bottom_20 divider_type_3">
    <div class="row clearfix">
        <div class="col-lg-6 col-md-6 col-sm-6 m_xs_bottom_30">
            <h5 class="fw_medium m_bottom_10 color_dark">Prezzo</h5>
            <table class="description_table m_bottom_5">
                <tbody>
                <tr>
                    <td>Prezzo:</td>
                    <td><strong class="color_dark">{attribute_view_gui attribute=$course.data_map.price}</strong></td>
                </tr>
                </tbody>
            </table>
            <h5 class="fw_medium m_bottom_10 color_dark">{if $is_tesseramento|not}Date di svolgimento{else}Dati tesseramento{/if}</h5>
            <table class="description_table m_bottom_5">
                <tbody>
                <tr>
                    <td>Inizio:</td>
                    <td>
                        <strong class="color_dark">dal {$course.data_map.data_inizio.content.timestamp|datetime( 'custom', '%d/%m/%Y' )}
                            al {$course.data_map.data_fine.content.timestamp|datetime( 'custom', '%d/%m/%Y' )}</strong>
                    </td>
                </tr>
                {if $is_tesseramento|not}
                <tr>
                    <td>Orario:</td>
                    <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'orario' )}</strong>
                    </td>
                </tr>
                {/if}
                <tr>
                    <td>Codice:</td>
                    <td>
                        <strong class="color_dark">
                            {$codice_area.data_map.codice.content}-{$ente.data_map.codice.content}
                            -{$course.data_map.anno.content}-{$course.data_map.codice.content}
                            -{$course.data_map.edizione.content}
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td>Anno:</td>
                    <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'anno' )}</td>
                </tr>
                <tr>
                    <td>Edizione:</td>
                    <td>
                        <strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'edizione' )}</strong>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-6 m_xs_bottom_30">
            <h5 class="fw_medium m_bottom_10 color_dark">Informazioni</h5>
            <table class="description_table m_bottom_5">
                <tbody>
                {if $is_tesseramento|not}
                <tr>
                    <td>Relatore:</td>
                    <td>
                        <strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'docente' )}</strong>
                    </td>
                </tr>
                <tr>
                    <td>Luogo:</td>
                    <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'luogo' )}</strong>
                    </td>
                </tr>
                {/if}
                <tr>
                    <td>Ente:</td>
                    <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'ente' )}</strong>
                    </td>
                </tr>
                <tr>
                    <td>Area Tematica:</td>
                    <td>
                        <strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'area_tematica' )}</strong>
                    </td>
                </tr>
                {if $is_tesseramento|not}
                <tr>
                    <td>Destinatari:</td>
                    <td>
                        <strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'destinatari' )}</strong>
                    </td>
                </tr>
                <tr>
                    <td>N° min partecipanti:</td>
                    <td>
                        <strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'numero_min_partecipanti' )}</strong>
                    </td>
                </tr>
                <tr>
                    <td>N° max partecipanti:</td>
                    <td>
                        <strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'numero_max_partecipanti' )}</strong>
                    </td>
                </tr>
                {/if}
                </tbody>
            </table>
        </div>
    </div>

    {* Iscrizioni *}
    {include uri='design:courses/parts/subscriptions.tpl'}

    {* Preiscrizioni *}
    {include uri='design:courses/parts/pre_subscriptions.tpl'}



</div>
