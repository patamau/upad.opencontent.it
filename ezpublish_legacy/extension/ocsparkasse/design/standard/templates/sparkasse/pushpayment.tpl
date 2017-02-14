<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                <h2 class="tt_uppercase color_dark m_bottom_25">Informazioni per il pagamento</h2>

                <p class="m_bottom_30">Paga con: <img src="{'logo-sparkasse.png'|ezimage( 'no' )}" alt="Carta di credito" /></p>

                <form action="{$sparkasse.url}" method="post">
                    <input type="hidden" name="xml" value="{$sparkasse.xml}" />
                    <input type="hidden" name="hash" value="{$sparkasse.hash}" />
                    <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light" type="submit" name="pay" value="Paga con Carta di credito" />
                </form>
            </div>
        </section>
    </div>
</div>
