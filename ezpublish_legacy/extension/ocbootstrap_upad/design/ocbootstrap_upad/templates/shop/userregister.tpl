<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class="clearfix m_bottom_30">
                <ul class="">
                    <li class="col-lg-4 col-md-4 col-sm-4">1. {"Shopping basket"|i18n("design/ocbootstrap/shop/basket")}</li>
                    <li class="f_size_large fw_medium scheme_color col-lg-4 col-md-4 col-sm-4">2. {"Account information"|i18n("design/ocbootstrap/shop/basket")}</li>
                    <li class="col-lg-4 col-md-4 col-sm-4">3. {"Confirm order"|i18n("design/ocbootstrap/shop/basket")}</li>
                </ul>
            </div>

            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">{"Your account information"|i18n("design/ocbootstrap/shop/userregister")}</h2>
                {section show=$input_error}
                    <div class="alert_box r_corners warning m_bottom_10">
                        <i class="fa fa-exclamation-circle"></i>
                        <p>
                            {"Input did not validate. All fields marked with * must be filled in."|i18n("design/ocbootstrap/shop/userregister")}
                        </p>
                    </div>
                {/section}
                <form method="post" action={"/shop/userregister/"|ezurl}>
                    <div class='col-lg-6 col-md-6 col-sm-6 '>
                        <div class='form-group m_bottom_15'>
                            <label>{"First name"|i18n("design/ocbootstrap/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="FirstName" size="20" value="{$first_name|wash}" />
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"Last name"|i18n("design/ocbootstrap/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="LastName" size="20" value="{$last_name|wash}" />
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"Email"|i18n("design/ocbootstrap/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="EMail" size="20" value="{$email|wash}" />
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"Company"|i18n("design/ocbootstrap/shop/userregister")}:</label>
                            <input class="form-control" type="text" name="Street1" size="20" value="{$street1|wash}" />
                        </div>
                    </div>
                    <div class='col-lg-6 col-md-6 col-sm-6 '>

                        <div class='form-group m_bottom_15'>
                            <label>{"Street"|i18n("design/ocbootstrap/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="Street2" size="20" value="{$street2|wash}" />
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"Zip"|i18n("design/ocbootstrap/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="Zip" size="20" value="{$zip|wash}" />
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"Place"|i18n("design/ocbootstrap/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="Place" size="20" value="{$place|wash}" />
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"State"|i18n("design/ocbootstrap/shop/userregister")}:</label>
                            <input class="form-control" type="text" name="State" size="20" value="{$state|wash}" />
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"Country"|i18n("design/ocbootstrap/shop/userregister")}:*</label>
                            {include uri='design:shop/country/edit.tpl' select_name='Country' select_size=5 current_val=$country}
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label>{"Comment"|i18n("design/ocbootstrap/shop/userregister")}:</label>
                            <textarea name="Comment" cols="80" rows="5">{$comment|wash}</textarea>
                        </div>
                    </div>

                    <div class="form-group m_bottom_15">
                        <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light" type="submit" name="CancelButton" value="{"Cancel"|i18n('design/ocbootstrap/shop/userregister')}" />
                        <input class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" type="submit" name="StoreButton" value="{"Continue"|i18n( 'design/ocbootstrap/shop/userregister')}" />
                    </div>

                </form>

                <p>{"All fields marked with * must be filled in."|i18n("design/ocbootstrap/shop/userregister")}</p>

            </div>
        </section>
    </div>
</div>
