{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}


{if $load_css_file_list}
  {ezcss_load( array( 'flexslider.css',
                      'bootstrap.min.css',
                      'owl.carousel.css',
                      'owl.transitions.css',
                      'jquery.custom-scrollbar.css',
                      'jquery-ui.min.css',
                      'style.css',
                      'debug.css',
                      'websitetoolbar.css',
                      ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
                      ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ) ) )}
{else}
  {ezcss_load( array( 'flexslider.css',
                      'bootstrap.min.css',
                      'owl.carousel.css',
                      'owl.transitions.css',
                      'jquery.custom-scrollbar.css',
                      'jquery-ui.min.css',
                      'style.css',
                      'debug.css',
                      'websitetoolbar.css') )}
{/if}

<!--font include-->
<!--<link href="css/font-awesome.min.css" rel="stylesheet">-->
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
