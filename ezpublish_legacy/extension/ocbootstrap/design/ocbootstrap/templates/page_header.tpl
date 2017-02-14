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
        {include uri='design:page_header_logo.tpl'}
      </div>
      <div class="col-sm-4">
        {include uri='design:page_header_searchbox.tpl'}
      </div>
    </div>
  </div>
</header>
