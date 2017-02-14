<div class="container">
    <div class="row clearfix">
              
        <div class='col-lg-4 col-md-4 col-sm-4 m_bottom_30 col-lg-offset-4'>
          
            <div class="alert_box r_corners warning m_bottom_10 text-center">
              <i class="fa fa-exclamation-circle"></i>
              <h1>Funzionalità presto disponibile</h1>
            </div>
          
            <h2 class="tt_uppercase color_dark m_bottom_20">{"Login"|i18n("design/ocbootstrap/user/login")}</h2>
            {if $User:warning.bad_login}
                <div class="alert_box r_corners warning m_bottom_10">
                    <i class="fa fa-exclamation-circle"></i>
                    <p><strong>{"Could not login"|i18n("design/ocbootstrap/user/login")}</strong></p>
                    <p>{"A valid username and password is required to login."|i18n("design/ocbootstrap/user/login")}</p>
                </div>
            {/if}

            {if $site_access.allowed|not}
                <div class="alert_box r_corners warning m_bottom_10">
                    <i class="fa fa-exclamation-circle"></i>
                    <p><strong>{"Access not allowed"|i18n("design/ocbootstrap/user/login")}</strong></p>
                    <p>{"You are not allowed to access %1."|i18n("design/ocbootstrap/user/login",,array($site_access.name))}</p>
                </div>
            {/if}

            <form class="validate-form" method="post" action={"/user/login/"|ezurl} name="loginform">
                <div class='form-group m_bottom_15'>
                    <div class='controls with-icon-over-input'>
                        <input type="text" autofocus="" name="Login" placeholder="{"Username"|i18n("design/ocbootstrap/user/login",'User name')}" class="form-control" data-rule-required="true" value="{$User:login|wash}">
                        <i class='icon-user text-muted'></i>
                    </div>
                </div>
                <div class='form-group m_bottom_15'>
                    <div class='controls with-icon-over-input'>
                        <input type="password" name="Password" placeholder="{"Password"|i18n("design/ocbootstrap/user/login")}" class="form-control" data-rule-required="true" >
                        <i class='icon-lock text-muted'></i>
                    </div>
                </div>
                <div class='m_bottom_15'>
                    <input type="checkbox" class="d_none"  name="Cookie" id="checkbox_10"><label for="checkbox_10">{"Remember me"|i18n("design/ocbootstrap/user/login")}</label>
                </div>
                <button class='button_type_4 tr_all_hover r_corners f_left bg_scheme_color color_light f_mxs_none m_mxs_bottom_15' name="LoginButton">{'Login'|i18n('design/ocbootstrap/user/login','Button')}</button>
                <div class="f_right f_size_medium f_mxs_none">
                    <a href="{'/user/forgotpassword'|ezurl('no')}" class="color_dark">{'Forgot your password?'|i18n( 'design/ocbootstrap/user/login' )}</a><br>
                    {if ezmodule( 'user/register' )}
                        <a href={"/user/register"|ezurl}  class="color_dark" title="{'Register'|i18n('design/ocbootstrap/pagelayout')}">{'Register'|i18n('design/ocbootstrap/pagelayout')}</a>
                    {/if}
                </div>

                {if and( is_set( $User:post_data ), is_array( $User:post_data ) )}
                    {foreach $User:post_data as $key => $postData}
                        <input name="Last_{$key|wash}" value="{$postData|wash}" type="hidden" /><br/>
                    {/foreach}
                {/if}
                <input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />
            </form>
        </div>
    </div>
</div>
