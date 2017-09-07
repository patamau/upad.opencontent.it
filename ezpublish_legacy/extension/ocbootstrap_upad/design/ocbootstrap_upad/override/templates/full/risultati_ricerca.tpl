<div class="container">
    <div class="row clearfix">
        <section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">
            <div class="clearfix m_bottom_25 m_sm_bottom_20">
                <h2 class="tt_uppercase color_dark m_bottom_25">{$node.name|wash()}</h2>
                <!--<img class="r_corners m_bottom_40" src="images/temp/offerta-formativa-lista.jpg" alt="">-->
                {include uri='design:atoms/image.tpl' item=$node image_class='original' css_class='r_corners m_bottom_40'}
            </div>
            {if $node|has_attribute( 'body' )}
                <div class="clearfix m_bottom_25 m_sm_bottom_20">
                    {attribute_view_gui attribute=$node|attribute( 'body' )}
                </div>
            {/if}
            
    	  	{def $current_user=fetch( 'user', 'current_user' )}
    	  	
            {def $page_limit = 10
                 $data = class_search_result(  hash( 'sort_by', hash( 'name', 'asc' ),
													 'limit', $page_limit),
									   $view_parameters )}
            {if $data.is_search_request}
                {include name=class_search_form_result
                         uri='design:parts/class_search_form_result.tpl'
                         data=$data
                         page_url=$node.url_alias
                         view_parameters=$view_parameters
                         page_limit=$page_limit}
            {/if}
        </section>

        <!-- sidebar -->
        {include uri='design:page_sidebar.tpl'}
    </div>
</div>

<!-- Partner -->
{include uri='design:parts/partner.tpl'}

