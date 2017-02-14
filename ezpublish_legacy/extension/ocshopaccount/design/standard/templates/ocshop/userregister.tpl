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

            <div class="clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">{"Your account information"|i18n("design/ocbootstrap/shop/userregister")}</h2>
                {section show=$input_error}
                    <div class="alert_box r_corners warning m_bottom_10">
                        <i class="fa fa-exclamation-circle"></i>
                        <p>
                            {"Input did not validate. All fields marked with * must be filled in."|i18n("design/ocbootstrap/shop/userregister")}
                        </p>
                    </div>
                {/section}

                <form method="post" action={"/ocshop/userregister/"|ezurl}>
                    <div class='col-lg-6 col-md-6 col-sm-6 '>
                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="FirstName">{"First name"|i18n("design/ezdemo/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="FirstName" id="FirstName" placeholder="{"First name"|i18n("design/ezdemo/shop/userregister")}" value="{$first_name|wash}">
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="LastName">{"Last name"|i18n("design/ezdemo/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="LastName" id="LastName" placeholder="{"Last name"|i18n("design/ezdemo/shop/userregister")}" value="{$last_name|wash}">
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="EMail">{"Email"|i18n("design/ezdemo/shop/userregister")}:*</label>
                            <input class="form-control" type="text" name="EMail" id="EMail" placeholder="{"Email"|i18n("design/ezdemo/shop/userregister")}" value="{$email|wash}">
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="Vat">Codice Fiscale:*</label>
                            <input class="form-control" type="text" name="Vat" id="Vat" placeholder="Codice Fiscale" value="{$vat|wash}">
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="Tel1">Recapito telefono:*</label>
                            <input class="form-control" type="text" name="Tel1" id="Tel1" placeholder="Telefono" value="{$tel1|wash}">
                        </div>
                    </div>

                    <div class='col-lg-6 col-md-6 col-sm-6 '>
                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="Street1">Indirizzo:*</label>
                            <input class="form-control" type="text" name="Street1" id="Street1" placeholder="{"Street"|i18n("design/ezdemo/shop/userregister")}" value="{$street1|wash}">
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="Zip">CAP:*</label>
                            <input class="form-control" type="text" name="Zip" id="Zip" placeholder="CAP" value="{$zip|wash}">
                        </div>

                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="Place">Comune:*</label>
                            <input class="form-control" type="text" name="Place" id="Place" placeholder="" value="{$place|wash}">
                        </div>


                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="State">Provincia:</label>
                            <div class="controls">
                                <input class="form-control" type="text" name="State" id="State" placeholder="" value="{$state|wash}">
                            </div>
                        </div>

                        {*
                        <input class="form-control" type="hidden" name="State" id="State" placeholder="{"State"|i18n("design/ezdemo/shop/userregister")}" value="{$state|wash}">
                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="Country">{"Country"|i18n("design/ezdemo/shop/userregister")}:*</label>
                            {include uri='design:shop/country/edit.tpl' select_name='Country' select_size=1 current_val=$country use_country_code=false()}
                        </div>
                        *}

                        <div class='form-group m_bottom_15'>
                            <label class="control-label" for="Comment">Note:</label>
                            <textarea class="form-control" name="Comment" cols="80" rows="5">{$comment|wash}</textarea>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                    <div class="col-lg-12 col-md-12 col-sm-12 form-group m_bottom_15">
                        <input class="tr_delay_hover r_corners button_type_15 bg_scheme_color color_light" type="submit" name="CancelButton" value="{"Cancel"|i18n('design/ocbootstrap/shop/userregister')}" />
                        <input class="tr_delay_hover r_corners button_type_15 bg_dark_color bg_cs_hover color_light" type="submit" name="StoreButton" value="{"Continue"|i18n( 'design/ocbootstrap/shop/userregister')}" />
                    </div>
                </form>
                <p>{"All fields marked with * must be filled in."|i18n("design/ocbootstrap/shop/userregister")}</p>
            </div>
        </section>
    </div>
</div>
