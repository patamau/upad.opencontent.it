<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">Esportazione utenti iscritti ai corsi</h2>

                <div class="alert alert-info m_bottom_30" role="alert">
                    In questa sezione è possibile esportare la lista di Utenti iscritti ai corsi degli enti selezionati dalla data inserita.
                </div>

                {if $too_many}
                    <div class="alert alert-warning m_bottom_30" role="alert">
                        Ci sono troppi risultati per la ricerca che hai fatto, prova a ridurre il periodo impostato.
                    </div>
                {/if}

                <form method="post" action={"utenti/export"|ezurl}  class="form-inline m_bottom_30">
                    <input type="hidden" name="action" value="export">

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
                            <input type="text" class="form-control date-picker" name="da" id="da" value="{if $da}{$da}{/if}">
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
            </div>
        </section>
        
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">{'Esportazione tesseramenti'}</h2>
				
				<div class="col-lg-4 col-md-4 col-sm-4">
				<table class="table table-striped m_top_10">
					<tbody>
						<tr>
						{def $where=concat( 'layout/set/csv/content/view/csv/5')|ezurl('no')}
		                <td>Tesserati:</td><td><i class="fa fa-download"></i> <a href='{$where}' download='users.csv'>{'Scarica CSV'}</a></td>
		                {undef $where}
		                </tr><tr>
		                {def $where=concat( 'layout/set/csv/content/view/csv/5/(expiry)/30')|ezurl('no')}
		                <td>In scadenza (30 giorni):</td><td><i class="fa fa-download"></i> <a href='{$where}' download='expiring.csv'>{'Scarica CSV'}</a></td>
		                {undef $where}
		                </tr><tr>
		                {def $where=concat( 'layout/set/csv/content/view/csv/5/(expiry)/-1')|ezurl('no')}
		                <td>Scaduti:</td><td><i class="fa fa-download"></i> <a href='{$where}' download='expired.csv'>{'Scarica CSV'}</a></td>
		                {undef $where}
		                </tr>
	                </tbody>
                </table>
                </div>
            </div>
        </section>
    </div>
</div>

<script type="text/javascript">
    {literal}
    $( document ).ready(function(){
        /*
        $( ".date-picker" ).datepicker({
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            numberOfMonths: 1
        });
        */

        $( "#da" ).datepicker({
            dateFormat: "dd-mm-yy",
            defaultDate: "+0",
            changeMonth: true,
            numberOfMonths: 2,
            onClose: function( selectedDate ) {
                $( "#a" ).datepicker( "option", "minDate", selectedDate );
            }
        });
        $( "#a" ).datepicker({
            dateFormat: "dd-mm-yy",
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 2,
            onClose: function( selectedDate ) {
                $( "#da" ).datepicker( "option", "maxDate", selectedDate );
            }
        });

    });
    {/literal}
</script>
