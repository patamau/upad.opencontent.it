{def $page_limit=20
     $count = 1
     $col_count=2
     $sub_children=0
     $excluded_primary_node = array(60, 103)
     $classes = array('luogo', 'form_prenotazione', 'corso')
     $classes_child = array('article', 'luogo', 'form_prenotazione', 'feedback_form', 'corso')
     $children=fetch('content','list',hash('parent_node_id', $node.node_id,
                                           'limit', $page_limit,
                                           'offset', $view_parameters.offset,
                                           'sort_by', $node.sort_array,
                                            'depth', 1,
                                           'class_filter_type', 'exclude',
                                           'class_filter_array', $classes))}


<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">{"Site map"|i18n("design/ocbootstrap/view/sitemap")} {$node.name|wash}</h2>


                <table width="100%" cellspacing="0" cellpadding="4">
                <tr>
                    {foreach $children as $key => $child}
                        {if $excluded_primary_node|contains($child.node_id)|not()}
                            <td width="50%" style="padding: 5px 0">
                                <h2><a href={$child.url_alias|ezurl}>{$child.name}</a></h2>
                                {if $child.class_identifier|eq( 'event_calendar' )}
                                    {set $sub_children=fetch('content','list',hash( 'parent_node_id', $child.node_id,
                                                                                    'limit', $page_limit,
                                                                                    'class_filter_type', 'exclude',
                                                                                    'class_filter_array', $classes_child,
                                                                                    'sort_by', array( 'attribute', false(), 'event/from_time' ) ) )}
                                {else}
                                    {set $sub_children=fetch('content','list',hash( 'parent_node_id', $child.node_id,
                                                                                    'limit', $page_limit,
                                                                                    'class_filter_type', 'exclude',
                                                                                    'class_filter_array', $classes_child,
                                                                                    'sort_by', $child.sort_array))}
                                {/if}
                                <ul>
                                {foreach $sub_children as $sub_child}
                                    <li><a class="m_left_20" href={$sub_child.url_alias|ezurl}>{$sub_child.name}</a></li>
                                {/foreach}
                                </ul>
                            </td>
                            {if ne( $key|mod($col_count), 0 )}
                                </tr>
                                <tr>
                            {/if}
                            {set $count = $count|sum(1)}
                        {/if}
                    {/foreach}
                </tr>
                </table>

            </div>
        </section>
    </div>
</div>
