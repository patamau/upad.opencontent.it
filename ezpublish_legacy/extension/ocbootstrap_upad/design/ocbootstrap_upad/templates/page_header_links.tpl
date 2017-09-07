<div class="row clearfix">
    {if $current_user.is_logged_in}
        <nav class="col-lg-6 col-md-6 col-sm-6 t_xs_align_c">
            <ul class="d_inline_b horizontal_list clearfix f_size_small users_nav">
                <li id="logout"><a href={"/user/logout"|ezurl} title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}"><i class="fa fa-sign-out"></i></a></li>
                <li id="myprofile"><a href={"/user/edit/"|ezurl} title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}" title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}">{$current_user.contentobject.name|wash}</a></li>
                <li id="basket"><a href={"/shop/basket"|ezurl} title="{'Shopping basket'|i18n('design/ocbootstrap/pagelayout')}" title="{'Shopping basket'|i18n('design/ocbootstrap/pagelayout')}"><i class="fa fa-shopping-cart"></i></a></li>
                {*<li id="basket"><a href={"/shop/orderlist/"|ezurl}>{"My orders"|i18n("design/ocbootstrap/user/edit")}</a></li>*}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'ocorder','function', 'list' ) )}
                <li id="orders"><a href={"/ocorder/list/"|ezurl} title="{'My orders'|i18n('design/ocbootstrap/user/edit')}"><i class="fa fa-list-ol"></i></a></li>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'utenti','function', 'list' ) )}
                    <li id="orders"><a href={"/utenti/list/"|ezurl} title="{'Gestione utenti'|i18n('design/ocbootstrap/user/edit')}"><i class="fa fa-users"></i></a></li>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'courses','function', 'list' ) )}
                <li id="orders"><a href={"/courses/list/"|ezurl} title="{"Gestione corsi"|i18n("design/ocbootstrap/user/edit")}"><i class="fa fa-book"></i></a></li>
                <li id="orders"><a href={"/cards/list/"|ezurl} title="{"Gestione tesseramenti"|i18n("design/ocbootstrap/user/edit")}"><i class="fa fa-credit-card"></i></a></li>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'invoice','function', 'manage' ) )}
                <li id="orders"><a href={"/invoice/manage/"|ezurl} title="{"Gestione fatture"|i18n("design/ocbootstrap/user/edit")}"><i class="fa fa-euro"></i></a></li>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'invoice','function', 'manage' ) )}
                <li id="orders"><a href={"/invoice/report_aree/"|ezurl} title="{"Report centro di costo"|i18n("design/ocbootstrap/user/edit")}"><i class="fa fa-money"></i></a></li>
                {/if}
            </ul>
        </nav>
    {else}
        <div class="col-lg-6 col-md-6 col-sm-6 t_xs_align_c">
            <p class="f_size_small">
                <!--<button class="tr_delay_hover r_corners button_type_16 bg_dark_color bg_cs_hover color_light" data-popup="#login_popup">Area Riservata LOGIN</button>-->
                <a href="{'/user/login'|ezurl( 'no' )}" class="tr_delay_hover r_corners button_type_16 bg_dark_color bg_cs_hover color_light">Area Riservata LOGIN</a>
            </p>
        </div>
    {/if}
    <nav class="col-lg-6 col-md-6 col-sm-6 t_align_r t_xs_align_c">
        <ul class="d_inline_b horizontal_list clearfix f_size_small users_nav">
            <li><a href="{'/Contatti'|ezurl( 'no' )}" class="default_t_color">Contattaci</a></li>
            <li><a href="{'Link-utili'|ezurl( 'no' )}" class="default_t_color">Link utili</a></li>
            <li><a href="{'/content/view/sitemap/2'|ezurl( 'no' )}" class="default_t_color">Mappa del sito</a></li>
            <li><a href="{'/Privacy'|ezurl( 'no' )}" class="default_t_color">Privacy</a></li>
            <li><a href="{'/Note-legali'|ezurl( 'no' )}" class="default_t_color">Note legali</a></li>
            <li><a href="{'/Condizioni'|ezurl( 'no' )}" class="default_t_color">Condizioni</a></li>
            <li><a href="{'/Regolamento'|ezurl( 'no' )}" class="default_t_color">Regolamento</a></li>
        </ul>
    </nav>
</div>
