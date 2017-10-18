<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">Gestione fatture</h2>

                <div class="alert alert-info m_bottom_30" role="alert">
                    In questa sezione è possibile ricercare ed esportare le fatture degli enti.<br>
                    Per ricercare le fatture di un singolo giorno inviare il form con il campo "<strong>A</strong>" vuoto.

                </div>

                <form method="post" action={"invoice/manage"|ezurl}  class="form-inline m_bottom_30">
                    <input type="hidden" name="action" value="search">

                    <div class="form-group">
                        <label for="ente">Ente</label>
                        <select name="ente" id="ente" class="form-control">
                            <option value="all">Tutti</option>
                            {foreach $enti as $e}
                                <option value="{$e.contentobject_id}"{if eq($ente, $e.contentobject_id)} selected="selected"{/if}>{$e.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="da">Da</label>
                        <div class="input-group">
                            <input type="text" class="form-control date-picker" name="da" id="da" value="{if $da}{$da}{else}{currentdate()|datetime( 'custom', '%d-%m-%Y' )}{/if}">
                            <span class="input-group-addon"> <i class="fa fa-calendar"></i> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="da">A</label>
                        <div class="input-group">
                            <input type="text" class="form-control date-picker" name="a" id="a" value="{if $a}{$a}{/if}">
                            <span class="input-group-addon"> <i class="fa fa-calendar"></i> </span>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-default" name="template" value="search">Cerca</button>
                </form>
                {if gt($invoices|count(), 0)}
                	{def $corsi = array(36297,42245)}
					CORSO: {$corso}<br/>
					ENTE: {$ente}<br/>
                	{set $corso = $corsi[0]}
                	<select name="corso" id="corso" class="form-control">
                		{foreach $corsi as $c}
                			<option value="{$c}">{$c}</option>
                		{/foreach}
                	</select>
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Data</th>
                                <th>N. Ricevuta</th>
                                <th>Cliente</th>
                                <th>Importo €</th>
                                <th>Ente erogante</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            {def $total_amount = 0}
                            {foreach $invoices as $i}
                                {def $user = fetch( 'content', 'object', hash( 'object_id', $i.user_id ) )}
                                {set $total_amount = $total_amount|sum($i.total)}
                                <tr>
                                    <td>{$i.date|l10n(shortdate)}</td>
                                    <td>{$i.invoice_id_string}{if ne($i.order_id, 0)} (Ecommerce){/if}</td>
                                    <td>{$user.name}</td>
                                    <td class="text-right">{$i.total|l10n( 'currency' )}</td>
                                    <td>{$i.ente.name}</td>
                                    <td><a class="btn btn-sm btn-danger" href={concat("layout/set/pdf/invoice/view/",$i.id)|ezurl()}>Stampa</a></td>
                                </tr>
                                {undef $user}
                            {/foreach}
                            <tr>
                                <td colspan="3" class="text-right"><strong>Totale:</strong></td>
                                <td class="text-right"><strong>{$total_amount|l10n( 'currency' )}</strong></td>
                                <td colspan="3"></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="pull-right">
                        <a href="{concat( 'layout/set/a4/invoice/export/customers/', $ente, '/', $corso,'/', $da, '/', $a)|ezurl(no)}" class="btn btn-warning">Esporta</a>
                        <a href="{concat( 'layout/set/pdf/invoice/export/print/', $ente, '/', $corso,'/', $da, '/', $a)|ezurl(no)}" class="btn btn-danger">Stampa</a>
                    </div>
                {else}
                    {if $ente}
                        <p>Non sono presenti fatture per il periodo/ente selezionato.</p>
                    {/if}
                {/if}
            </div>
        </section>
    </div>
</div>

<script type="text/javascript">
    {literal}
    $( document ).ready(function(){
        $( ".date-picker" ).datepicker({
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            numberOfMonths: 1
        });
    });
    {/literal}
</script>
