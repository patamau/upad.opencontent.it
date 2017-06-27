{* Load JavaScript dependencys + JavaScriptList
{ezscript_load( array(
    ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ),
    ezini( 'JavaScriptSettings', 'FrontendJavaScriptList', 'design.ini' )
))}

<!--[if lt IE 9]>
<script type="text/javascript" src={"javascript/respond.js"|ezdesign()} ></script>
<![endif]-->
*}

{ezscript_load( array(
    'ezjsc::jquery',
    'ezjsc::jqueryUI',
    'plugins/chosen.jquery.js'
))}

<script type="text/javascript" src="//platform-api.sharethis.com/js/sharethis.js#property=58f70e3076d0e100120d8ad9&product=inline-share-buttons"></script>