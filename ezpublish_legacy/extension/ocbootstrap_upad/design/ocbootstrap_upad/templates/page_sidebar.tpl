{if $is_ente}
    <aside class="col-lg-3 col-md-3 col-sm-4 m_xs_bottom_30">
        <!-- Menù ente -->
        {include uri='design:parts/sidebar/menu_ente.tpl'}

        <!--banners-->
        {include uri='design:parts/sidebar/banners.tpl'}

        <!-- Download -->
        {include uri='design:parts/sidebar/download.tpl'}
    </aside>
{else}
    <aside class="col-lg-3 col-md-3 col-sm-4 m_xs_bottom_30">
        <!--widgets-->
        {class_search_form( 'corso', hash( 'RedirectNodeID', ezini( 'NodeSettings', 'RisultatiRicercaNodeID', 'content.ini' ) ) )}

        <!--banners-->
        {include uri='design:parts/sidebar/banners.tpl'}

        <!--tags-->
        {*<figure class="widget shadow r_corners wrapper m_bottom_30">
            <figcaption>
                <h3 class="color_light">Tags</h3>
            </figcaption>
            <div class="widget_content">
                <div class="tags_list">
                    {eztagscloud(
                        hash(
                            'parent_node_id', 2,
                            'sort_by', array(
                                'keyword', true()
                            )
                        )
                    )}
                </div>
            </div>
        </figure>*}
    </aside>
{/if}
