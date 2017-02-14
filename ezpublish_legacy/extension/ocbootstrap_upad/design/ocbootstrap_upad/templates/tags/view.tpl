{def $limit = 10}
{def $nodes = fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
extended_attribute_filter,
hash( id, TagsAttributeFilter,
params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
offset, first_set( $view_parameters.offset, 0 ), limit, $limit,
main_node_only, true(),
sort_by, array( modified, false() ) ) )}

{def $nodes_count = fetch( content, tree_count, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
extended_attribute_filter,
hash( id, TagsAttributeFilter,
params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
main_node_only, true() ) )}
<div class="container{if $is_ente} ente ente_{$ente.node_id}{/if}">
    <div class="row clearfix">
        <section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">
            <div class="clearfix m_bottom_25 m_sm_bottom_20">
                <h2 class="tt_uppercase color_dark m_bottom_25">{$tag.keyword|wash}</h2>
            </div>

            {if $nodes|count}
                {foreach $nodes as $node}
                    {node_view_gui content_node=$node view=line}
                {/foreach}
            {/if}

            {include uri='design:navigator/google.tpl'
            page_uri=concat( '/tags/view/', $tag.url )
            item_count=$nodes_count
            view_parameters=$view_parameters
            item_limit=$limit}



        </section>
        <!-- sidebar -->
        {include uri='design:page_sidebar.tpl'}
    </div>
</div>

{undef $limit $nodes $nodes_count}