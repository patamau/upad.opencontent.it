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

				{def $additional_fields=array('ente')}

                {foreach $helper.attribute_fields as $input}
                	[{$input.class_attribute.identifier}]
                    {if $additional_fields|contains($input.class_attribute.identifier)}
                    	{attribute_search_form( $helper, $input )}
                    {/if}
                    {* add search user by id *}
                {/foreach}
                
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
