<ul class="nav navbar-nav navbar-right">
  {if $current_user.is_logged_in}
    <li id="myprofile"><a href={"/user/edit/"|ezurl} title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}">{'My profile'|i18n('design/ocbootstrap/pagelayout')}</a></li>
    <li id="logout"><a href={"/user/logout"|ezurl} title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}">{'Logout'|i18n('design/ocbootstrap/pagelayout')} ( {$current_user.contentobject.name|wash} )</a></li>
  {else}
    {if ezmodule( 'user/register' )}
    <li id="registeruser"><a href={"/user/register"|ezurl} title="{'Register'|i18n('design/ocbootstrap/pagelayout')}">{'Register'|i18n('design/ocbootstrap/pagelayout')}</a></li>
    {/if}
    <li id="login" class="dropdown">
      <a href="#" title="hide login form" class="dropdown-toggle" data-toggle="dropdown">{'Login'|i18n('design/ocbootstrap/pagelayout')}</a>
      <div class="panel dropdown-menu">
        <form class="login-form" action="{'/user/login'|ezurl( 'no' )}" method="post">
          <fieldset>
            <div class="form-group">
              <label for="login-username" class="sr-only">{'Username'|i18n('design/ocbootstrap/pagelayout')}</label>
              <input class="form-control" type="text" name="Login" id="login-username" placeholder="Username">
            </div>
            <div class="form-group">
              <label for="login-password" class="sr-only">{'Password'|i18n('design/ocbootstrap/pagelayout')}</label>
              <input class="form-control" type="password" name="Password" id="login-password" placeholder="Password">
            </div>
            <button class="btn btn-primary pull-right" type="submit">
                  {'Login'|i18n('design/ocbootstrap/pagelayout')}
              </button>
              <p class="small"><a href="{'/user/forgotpassword'|ezurl( 'no' )}" class="forgot-password">{'Forgot your password?'|i18n('design/ocbootstrap/pagelayout')}</a></p>
          </fieldset>
          <input type="hidden" name="RedirectURI" value="" />
        </form>
      </div>
    </li>
{/if}
</ul>

