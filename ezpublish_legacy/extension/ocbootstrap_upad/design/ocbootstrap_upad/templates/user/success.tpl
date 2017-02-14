
<div class="row">
<div class="col-md-8 col-md-offset-2">

<h1 class="container-title">{"User registered"|i18n("design/ocbootstrap/user/success")}</h1>

<div class="alert alert-success clearfix">
{if $verify_user_email}
<p>{'Your account was successfully created. An email will be sent to the specified address. Follow the instructions in that email to activate your account.'|i18n('design/ocbootstrap/user/success')}</p>
{else}
<p>{"Your account was successfully created."|i18n("design/ocbootstrap/user/success")}</p>
<a class="btn btn-success pull-right" href={'/'|ezurl()}>Ok</a>
{/if}
</div>


</div>
</div>

