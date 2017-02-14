{def $total = 0}
<div class="container">
    <div class="col-md-12 m_bottom_20">
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="{'invoice/report_aree'|ezurl(no)}"><i class="fa fa-money"></i> Report fatture</a></li>
            <li role="presentation" class="active"><a href="{'invoice/export_excel_aree'|ezurl(no)}"><i class="fa fa-table"></i> Report excel</a></li>
        </ul>
    </div>
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">Report excel centro di costo</h2>

                <div class="alert alert-info m_bottom_30" role="alert">
                    In questa sezione è possibile esportare un report in excel in base al centro di costo.
                </div>

                <form method="post" action={"invoice/export_excel_aree"|ezurl}  class="form-inline m_bottom_30">
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
                        <label for="da">Da</label>
                        <div class="input-group">
                            <input type="text" class="form-control date-picker" name="da" id="da" value="{if $da}{$da}{else}{currentdate()|datetime( 'custom', '%d-%m-%Y' )}{/if}">
                            <span class="input-group-addon"> <i class="fa fa-calendar"></i> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="da">A</label>
                        <div class="input-group">
                            <input type="text" class="form-control date-picker" name="a" id="a" value="{if $a}{$a}{else}{currentdate()|datetime( 'custom', '%d-%m-%Y' )}{/if}">
                            <span class="input-group-addon"> <i class="fa fa-calendar"></i> </span>
                        </div>
                    </div>
                    {*
                    <div class="form-group">
                        <label for="anno">Stato dei corsi</label>
                        <select id="stato" name="stato" class="form-control">
                            {foreach $stati as $k => $v}
                                <option value="{$k}"{if eq($k, $stato)} selected="selected"{/if}>{$v}</option>
                            {/foreach}
                        </select>
                    </div>*}
                    <button type="submit" class="btn btn-default" name="template" value="search">Cerca</button>

                </form>
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
            changeMonth: true,
            numberOfMonths: 2,
            onClose: function( selectedDate ) {
                $( "#a" ).datepicker( "option", "minDate", selectedDate );
            }
        });
        $( "#a" ).datepicker({
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            numberOfMonths: 2,
            onClose: function( selectedDate ) {
                $( "#da" ).datepicker( "option", "maxDate", selectedDate );
            }
        });
    });
    {/literal}
</script>
