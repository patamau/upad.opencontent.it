<header role="banner">
				<!--header top part-->
				<section class="h_top_part">
					<div class="container">
						{include uri='design:page_header_links.tpl'}
					</div>
				</section>
				<!--header bottom part-->
				<section class="h_bot_part container">
					<div class="clearfix row">
						<div class="col-lg-2 col-md-2 col-sm-2 t_xs_align_c">
                            {include uri='design:page_header_logo.tpl'}
						</div>
						<div class="col-lg-7 col-md-8 col-sm-10 t_xs_align_c ">
							<ul class="horizontal_list f_right clearfix">
								<li class="relative bg_light_color_3 p_5 f_left">
									<span class="tooltip tr_all_hover r_corners bg_scheme_color color_light f_size_small">Mua</span>
									<a href="{'Chi-siamo/Mua'|ezurl( 'no' )}"><img src="{'temp/mua.png'|ezimage('no')}" alt="mua"></a>
								</li>
								<li class="relative m_left_10 bg_light_color_3 p_5 f_left">
									<span class="tooltip tr_all_hover r_corners bg_scheme_color color_light f_size_small">ascolto giovani</span>
									<a href="{'Chi-siamo/Ascolto-Giovani'|ezurl( 'no' )}"><img src="{'temp/ascolto-giovani.png'|ezimage('no')}" alt="ascolto giovani"></a>
								</li>
								<li class="relative m_left_10 bg_light_color_3 p_5 f_left">
									<span class="tooltip tr_all_hover r_corners bg_scheme_color color_light f_size_small">palladio</span>
									<a href="{'Chi-siamo/Palladio'|ezurl( 'no' )}"><img src="{'temp/palladio.png'|ezimage('no')}" alt="palladio"></a>
								</li>
								<li class="relative m_left_10 bg_light_color_3 p_5 f_left">
									<span class="tooltip tr_all_hover r_corners bg_scheme_color color_light f_size_small">tempo libero</span>
									<a href="{'Chi-siamo/Tempo-libero-UPAD'|ezurl( 'no' )}"><img src="{'temp/tempo-libero.png'|ezimage('no')}" alt="tempo libero"></a>
								</li>
								<li class="relative m_left_10 bg_light_color_3 p_5 f_left">
									<span class="tooltip tr_all_hover r_corners bg_scheme_color color_light f_size_small">altoatesini</span>
									<a href="{'Chi-siamo/Altoatesini-nel-mondo'|ezurl( 'no' )}"><img src="{'temp/altoatesini.png'|ezimage('no')}" alt="altoatesini"></a>
								</li>
							</ul>
						</div>
						<div class="col-lg-3 col-md-2 col-sm-12">
                            {include uri='design:page_header_searchbox.tpl'}
						</div>
					</div>
				</section>
                {include uri='design:nav/nav-main.tpl'}
			</header>

{*
<header>
  <div class="container">
    <div class="row">
      <div class="navbar nav-tools">
        <div class="container-fluid">
          <div class="nav-collapse row">
            {include uri='design:page_header_languages.tpl'}
            {include uri='design:page_header_links.tpl'}
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="branding col-sm-8">
        {*<a href="{'/'|ezurl( 'no' )}" title="{ezini('SiteSettings','SiteName')|wash}" class="logo">
          <img src="{'logo.png'|ezimage( 'no' )}" alt="{ezini('SiteSettings','SiteName')|wash}" />
        </a>
        *}
        {*
        {include uri='design:page_header_logo.tpl'}
      </div>
      <div class="col-sm-4">
        {include uri='design:page_header_searchbox.tpl'}
      </div>
    </div>
  </div>
</header>
*}
