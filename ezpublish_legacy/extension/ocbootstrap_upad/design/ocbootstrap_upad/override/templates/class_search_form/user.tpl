{*
  helper OCClassSearchFormHelper
  class eZContentClass
  sort_form html tpl @todo
  published_form html tpl @todo
*}

<figure class="widget shadow r_corners wrapper m_bottom_30">
    <figcaption>
        <h3 class="color_light">Ricerca Rapida</h3>
    </figcaption>
    <div class="widget_content">
        <form name="{concat('class_search_form_',$helper.class.identifier)}" method="get" action="{'/ocsearch/action'|ezurl( 'no' )}">

            <!--Categories list-->
            <ul class="categories_list">

                {* Ricerca semplice *}
                {include uri='design:class_search_form/query.tpl' helper=$helper input=$helper.query_field}

				{def $additional_fields=array('card')}

                {foreach $helper.attribute_fields as $input}
                    {if $additional_fields|contains($input.class_attribute.identifier)}
                    	{attribute_search_form( $helper, $input )}
                    {/if}
                    {* add search user by id *}
                {/foreach}
                
                <li>
				    <a href="#" class="f_size_large color_dark d_block relative">
				        <b>Identificativo</b>
				        <span class="bg_light_color_1 r_corners f_right color_dark talign_c"></span>
				    </a>
				    <!--second level-->
				    <ul class="d_none">
				        <li>
				            <fieldset class="m_bottom_15 m_top_5">
				                <input type="text" class="form-control" name="userid" id="userid" value="">
				            </fieldset>
				        </li>
				    </ul>
				</li>
                
                {undef $additional_fields}
                
                <li class="t_align_c m_top_20">
                    <button type="submit" class="button_type_4 r_corners bg_scheme_color color_light tr_all_hover">Cerca utente</button>
                </li>
            </ul>

            {include uri='design:class_search_form/sort.tpl' helper=$helper input=$helper.sort_field}

            {include uri='design:class_search_form/publish_date.tpl' helper=$helper input=$helper.published_field}

            {foreach $parameters as $key => $value}
                <input type="hidden" name="{$key}" value="{$value}" />
            {/foreach}

            <input type="hidden" name="class_id" value="{$helper.class.id}" />

        </form>
    </div>
</figure>
