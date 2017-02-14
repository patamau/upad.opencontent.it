{def $page_limit = 20
     $list_count = fetch( 'content', 'keyword_count', hash( 'alphabet', $alphabet,
                                                           'limit', $page_limit,
                                                           'offset', $view_parameters.offset,
                                                           'classid', $view_parameters.classid ) )
     $uniq_id = 0
     $uniq_post = array()}


<div class="container">
    <div class="row clearfix">
        <section class='col-lg-12 col-md-12 col-sm-12 m_bottom_30'>
            <div class=" clearfix">
                <h2 class="tt_uppercase color_dark m_bottom_25">{'Keyword: %keyword'|i18n( 'design/ocbootstrap/content/keyword', ,
                hash( '%keyword', $alphabet ) )|wash()}</h2>

                <table class="table_type_4 responsive_table full_width r_corners wraper shadow t_align_l t_xs_align_c m_bottom_30">
                <tr>
                    <th>{'Link'|i18n( 'design/ocbootstrap/content/keyword' )}</th>
                    <th>{'Type'|i18n( 'design/ocbootstrap/content/keyword' )}</th>
                </tr>
                {if $list_count}
                    {foreach fetch( 'content', 'keyword', hash( 'alphabet', $alphabet,
                                                                'limit', $page_limit,
                                                                'offset', $view_parameters.offset,
                                                                'classid', $view_parameters.classid ) ) as $keyword
                            sequence array( 'bgdark', 'bglight' ) as $style}
                    {set $uniq_id = $keyword.link_object.node_id}
                    {if $uniq_post|contains( $uniq_id )|not}
                        <tr class="{$style}">
                        <td>
                            <a href={$keyword.link_object.object.main_node.url_alias|ezurl}>{$keyword.link_object.name|wash}</a>
                        </td>
                        <td>
                            {$keyword.link_object.class_name|wash}
                        </td>
                        </tr>
                    {set $uniq_post = $uniq_post|append( $uniq_id )}
                    {/if}
                    {/foreach}
                {/if}

                </table>
                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=concat('/content/keyword/', $alphabet)
                         item_count=$list_count
                         view_parameters=$view_parameters
                         item_limit=$page_limit}
            </div>
        </section>
    </div>
</div>
