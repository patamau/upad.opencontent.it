<div class="container">

    <h1>Nuova edizione: <br>{$course.name|wash()}</h1>

    <hr class="m_bottom_20 divider_type_3">
    <div class="row clearfix">
        <div class="col-lg-6 col-md-6 col-sm-6 m_xs_bottom_20">
            <h5 class="fw_medium m_bottom_10 color_dark">Prezzo</h5>
            <table class="description_table m_bottom_5">
                <tbody>
                    <tr>
                        <td>Prezzo:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course.data_map.price}</strong></td>
                    </tr>
                </tbody>
            </table>
            <h5 class="fw_medium m_bottom_10 color_dark">Date di svolgimento</h5>
            <table class="description_table m_bottom_5">
                <tbody>
                    <tr>
                        <td>Inizio:</td>
                        <td><strong class="color_dark">dal {$course.data_map.data_inizio.content.timestamp|datetime( 'custom', '%d/%m/%Y' )} al {$course.data_map.data_fine.content.timestamp|datetime( 'custom', '%d/%m/%Y' )}</strong></td>
                    </tr>
                    <tr>
                        <td>Orario:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'orario' )}</strong></td>
                    </tr>
                    <tr>
                        <td>Anno:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'anno' )}</td>
                    </tr>
                    <tr>
                        <td>Edizione:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'edizione' )}</strong></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-6 m_xs_bottom_20">
            <h5 class="fw_medium m_bottom_10 color_dark">Informazioni</h5>
            <table class="description_table m_bottom_5">
                <tbody>
                    <tr>
                        <td>Relatore:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'docente' )}</strong></td>
                    </tr>
                    <tr>
                        <td>Luogo:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'luogo' )}</strong></td>
                    </tr>
                    <tr>
                        <td>Ente:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'ente' )}</strong></td>
                    </tr>
                    <tr>
                        <td>Area Tematica:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'area_tematica' )}</strong></td>
                    </tr>
                    <tr>
                        <td>Destinatari:</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$course|attribute( 'destinatari' )}</strong></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <hr />

    <div class="row clearfix">
        <div class="col-lg-12 col-md-12 col-sm-12 m_xs_bottom_20 m_bottom_20">
            <h2 class="m_xs_bottom_20 m_bottom_20">Verifica i dati per la nuova edizione</h2>
            <form action={concat('courses/create_edition/', $course.id)|ezurl()} method="post" class="form-horizontal">

                <div class="form-group">
                    <div class="col-lg-6 col-md-6">
                        <label for="year">Anno</label>
                        <input type="text" class="form-control" id="Year" name="Year" value="{$course.data_map.anno.content}">
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <label for="year">Numero edizione</label>
                        <input type="text" class="form-control" id="Edition" name="Edition" value="{$course.data_map.edizione.content|sum(1)}">
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12 m_xs_bottom_20 m_bottom_20">
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="CloneSubscription" value="1" checked="checked"> Vuoi duplicare le iscrizioni del corso in preiscrizioni per la nuova edizione?
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 m_xs_bottom_20 m_bottom_20">
                    <div class="form-group">
                        <input class="btn btn-sm btn-danger" type="submit" name="Discard" value="Annulla" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 text-right m_xs_bottom_20 m_bottom_20">
                    <div class="form-group">
                        <input class="btn btn-sm btn-primary" type="submit" name="Create" value="Crea nuova edizione del corso" />
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
