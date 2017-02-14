<!DOCTYPE html>
<!--[if lt IE 9 ]><html class="unsupported-ie ie" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->
<head>

{def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

{cache-block keys=array( $module_result.uri, $current_user.contentobject_id )}

{def $pagedata = ezpagedata()
     $pagestyle = $pagedata.css_classes
     $locales = fetch( 'content', 'translation_list' )
     $current_node_id = $pagedata.node_id}

<meta name="viewport" content="width=device-width, initial-scale=1.0">
{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>

<body class='contrast-blue login contrast-background'>
  <div class='middle-container'>
    <div class='middle-row'>
      <div class='middle-wrapper'>
        <div class='login-container-header'>
          <div class='container'>
            <div class='row'>
              <div class='col-sm-12'>
                <div class='text-center'>
                  <img width="121" height="31" src={'logo_lg.png'|ezimage()} />
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class='login-container'>
          <div class='container'>
        
      {/cache-block}                
      {$module_result.content}
      {cache-block keys=array( $module_result.uri, $current_user.contentobject_id )}
          </div>
        </div>
        <div class='login-container-footer'>
          <div class='container'>
            <div class='row'>
              <div class='col-sm-12'>
                <div class='text-center'>
                  {if module_params().function_name|eq('register')}
                  <a href={'user/login'|ezurl()}>
                    <i class='icon-user'></i>                    
                    <strong>
                    {'Login'|i18n('design/standard/user','Button')}  
                    </strong>
                  </a>
                  {else}
                  <a href={'user/register'|ezurl()}>
                    <i class='icon-user'></i>                    
                    <strong>
                    {'Sign Up'|i18n('design/standard/user','Button')}  
                    </strong>
                  </a>
                  {/if}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>  
{include uri='design:page_footer_script.tpl'}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
