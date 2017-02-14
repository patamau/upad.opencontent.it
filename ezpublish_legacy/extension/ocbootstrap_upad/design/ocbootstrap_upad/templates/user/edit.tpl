<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">{"User profile"|i18n("design/ocbootstrap/user/edit")}</h2>
                <form action={concat($module.functions.edit.uri,"/",$userID)|ezurl} method="post" name="Edit">

                    <div class="user-edit">
                        <div class="block">
                          <label>{"Username"|i18n("design/ocbootstrap/user/edit")}</label>
                          <strong>{$userAccount.login|wash}</strong>
                        </div>

                        <div class="block">
                          <label>{"Email"|i18n("design/ocbootstrap/user/edit")}</label>
                          <strong>{$userAccount.email|wash(email)}</strong>
                        </div>

                        <div class="m_bottom_25">
                          <label>{"Name"|i18n("design/ocbootstrap/user/edit")}</label>
                          <strong>{$userAccount.contentobject.name|wash}</strong>
                        </div>

                        {*if fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                                  'function', 'edit' ) )}
                        <p><a href={"content/draft"|ezurl}>{"My drafts"|i18n("design/ocbootstrap/user/edit")}</a></p>
                        {/if}
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'shop',
                                                                  'function', 'administrate' ) )}
                        <p><a href={concat("/shop/customerorderview/", $userID, "/", $userAccount.email)|ezurl}>{"My orders"|i18n("design/ocbootstrap/user/edit")}</a></p>
                        {/if}
                        {*if fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                                  'function', 'pendinglist' ) )}
                        <p><a href={"/content/pendinglist"|ezurl}>{"My pending items"|i18n("design/ocbootstrap/user/edit")}</a></p>
                        {/if}
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'notification',
                                                                  'function', 'use' ) )}
                        <p><a href={"notification/settings"|ezurl}>{"My notification settings"|i18n("design/ocbootstrap/user/edit")}</a></p>
                        {/if}
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'shop',
                                                                  'function', 'buy' ) )}
                        <p><a href={"/shop/wishlist"|ezurl}>{"My wish list"|i18n("design/ocbootstrap/user/edit")}</a></p>
                        {/if*}

                        <div class="buttonblock">
                            <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light" type="submit" name="EditButton" value="{'Edit profile'|i18n('design/ocbootstrap/user/edit')}" />
                            <input class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" type="submit" name="ChangePasswordButton" value="{'Change password'|i18n('design/ocbootstrap/user/edit')}" />
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </div>
</div>
