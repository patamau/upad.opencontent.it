<!doctype html>
<!--[if lt IE 9 ]><html class="unsupported-ie ie" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->
<head>
{def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}


{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}
{def $pagedata        = ezpagedata()}

{def $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $current_node_id  = $pagedata.node_id}

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Site: {ezsys( 'hostname' )} -->
  {if ezsys( 'hostname' )|contains( 'opencontent' )}
    <META name="robots" content="NOINDEX,NOFOLLOW" />
  {/if}

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>
<body>

{*<script src="<Path>/cookiechoices.js"></script>*}
{*ezscript_require( array( 'cookiechoices.js' ))*}
{*<script src="{'cookiechoices.js'|ezdesign('no')}"></script>*}

<script src="{'javascript/cookiechoices.js'|ezdesign('no')}"></script>
<script>
     {literal}
  document.addEventListener('DOMContentLoaded', function(event) {
    cookieChoices.showCookieConsentBar("In base alla normativa in materia di privacy applicabile, Il Titolare del trattamento dei dati acquisiti tramite il presente sito informa l’utente che tale sito web non utilizza cookie di profilazione al fine di inviare messaggi pubblicitari in linea con le preferenze manifestate nell'ambito della navigazione in rete. Il presente sito installa cookies di terze parti. La prosecuzione della navigazione, compreso lo scroll ed il click su elementi del sito, equivale a consenso.Per maggiori informazioni, anche in ordine ai cookies tecnici utilizzati dal sito, e per negare il consenso all’installazione dei singoli cookie è possibile consultare",
      'Proseguo ed acconsento', 'l’informativa cookies completa', '/Cookies');
  });
  {/literal}
</script>

<div id="page" class="wide_layout relative w_xs_auto">

    {include uri='design:page_header.tpl'}
{/cache-block}
{cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
      {include uri='design:page_toolbar.tpl'}
    {/if}

    {if and($pagedata.show_path, ne($current_node_id, 2))}
      {include uri='design:breadcrumb.tpl'}
    {/if}
    <div class="page_content_offset">

{/cache-block}
    {if and( $pagedata.website_toolbar, $pagedata.is_edit)}
        <div class="container">
    {/if}
    {$module_result.content}
    {if and( $pagedata.website_toolbar, $pagedata.is_edit)}
        </div>
    {/if}
{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

    </div>

    {include uri='design:page_footer.tpl'}

</div>

{*include uri='design:page_footer_utils.tpl'*}
{include uri='design:page_footer_script.tpl'}

{* Codice extra usato da plugin javascript *}
{*include uri='design:page_extra.tpl'*}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
