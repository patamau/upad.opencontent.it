{def $total = 0}
<div class="container">
    <div class="col-md-12 m_bottom_20">
        <ul class="nav nav-tabs">
            <li role="presentation" class="active"><a href="{'invoice/report_aree'|ezurl(no)}"><i class="fa fa-money"></i> Report fatture</a></li>
            <li role="presentation"><a href="{'invoice/export_excel_aree'|ezurl(no)}"><i class="fa fa-table"></i> Report excel</a></li>
        </ul>
    </div>
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">Report centro di costo</h2>

                <div class="alert alert-info m_bottom_30" role="alert">
                    In questa sezione è possibile ricercare ed esportare le fatture in base al centro di costo.
                </div>

                <form method="post" action={"invoice/report_aree_test"|ezurl}  class="form-inline m_bottom_30">
                    <input type="hidden" name="action" value="search">

                    <div class="form-group">
                        <label for="ente">Ente</label>
                        <select name="ente" id="ente" class="form-control">
                            {foreach $enti as $e}
                                <option value="{$e.contentobject_id}"{if eq($ente, $e.contentobject_id)} selected="selected"{/if}>{$e.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="mese">Mese</label>
                        <select id="mese" name="mese" class="form-control">
                            {foreach $mesi as $k => $v}
                                <option value="{$k}"{if eq($k, $mese)} selected="selected"{/if}>{$v}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="anno">Anno</label>
                        <select id="anno" name="anno" class="form-control">
                            {foreach $anni as $k => $v}
                                <option value="{$v}"{if eq($v, $anno)} selected="selected"{/if}>{$v}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="anno">Stato dei corsi</label>
                        <select id="stato" name="stato" class="form-control">
                            {foreach $stati as $k => $v}
                                <option value="{$k}"{if eq($k, $stato)} selected="selected"{/if}>{$v}</option>
                            {/foreach}
                        </select>
                    </div>
                    <button type="submit" class="btn btn-default" name="template" value="search">Cerca</button>
                </form>

                {* Risultati *}
                {if gt($search_results|count(), 0)}
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Area</th>
                                <th>Totale €</th>
                                <th>Codice contabile</th>
                                <th>Centro di costo</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $search_results as $k => $v}
                                <tr>
                                    <td>{$v.codice}-{$v.name}</td>
                                    <td class="text-right">{$v.total_amount|l10n( 'currency' )}</td>
                                    <td>{$v.conto_contabile}</td>
                                    <td>{$v.centro_costo}</td>
                                </tr>
                                {set $total = $total|sum($v.total_amount)}
                            {/foreach}
                            <tr class="last">
                                <td class="text-right"><strong>Totale mensile €</strong></td>
                                <td class="text-right"><strong>{$total|l10n( 'currency' )}</strong></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="pull-right">
                        <a href="{concat( 'layout/set/a4/invoice/export_aree/', $ente, '/', $mese, '/', $anno)|ezurl(no)}" class="btn btn-danger">Stampa</a>
                    </div>
                {else}
                    {if $ente}
                        <p>Non sono presenti fatture per il periodo/codice selezionato.</p>
                    {/if}
                {/if}
            </div>
        </section>
    </div>
</div>
