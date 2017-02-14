{def $is_ente = false()}
<div class="container">
    <div class="row clearfix">
        <section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">
            <!--slider-->
            {include uri='design:parts/home/slider.tpl'}

            <!--blog-->
            {include uri='design:parts/home/in_evidenza.tpl'}

            <!--special offers-->
            {include uri='design:parts/home/offerte.tpl'}
        </section>

        <!-- sidebar -->
        {include uri='design:page_sidebar.tpl'}

    </div>
</div>

<!-- News ed eventi -->
{include uri='design:parts/home/news_eventi.tpl'}

<!-- Partner -->
{include uri='design:parts/partner.tpl'}
