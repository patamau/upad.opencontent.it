<div class="navigation clearfix m_bottom_25 m_sm_bottom_20">
    {foreach $data.fields as $field}
        <a class="tr_delay_hover r_corners button_type_16 f_size_medium bg_dark_color bg_cs_hover color_light m_xs_bottom_5" href={concat( $page_url, $field.remove_view_parameters )|ezurl()}>
            <i class="fa fa-times m_right_5"></i> <strong>{$field.name}:</strong> {$field.value}
        </a>
        {delimiter}&nbsp;{/delimiter}
    {/foreach}
    &nbsp;<a class="tr_delay_hover r_corners button_type_16 f_size_medium bg_scheme_color color_light m_xs_bottom_5" href={$page_url|ezurl()}>Annulla ricerca</a>
</div>

{if $data.count}
    <div class="content-view-children">
          {foreach $data.contents as $child } 
              {node_view_gui view='line' content_node=$child}
              
          {/foreach}
    </div>
    {include name=navigator
          uri='design:navigator/google.tpl'
          page_uri=$page_url
          item_count=$data.count
          view_parameters=$view_parameters
          item_limit=$page_limit}
{else}
    <div class="warning">Nessun risultato</div>
{/if}
