<div class="container">
    <div class="content-browse row">
        {def $col = 'col-md-6 col-md-offset-3'}

        {let item_type=ezpreference( 'admin_list_limit' )
        number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
        select_name='SelectedObjectIDArray'
        select_type='checkbox'
        select_attribute='contentobject_id'
        browse_list_count=0
        page_uri_suffix=false()
        node_array=array()
        bookmark_list=fetch('content','bookmarks',array())}
        {if is_set( $node_list )}
            {def $page_uri=$requested_uri }
            {set browse_list_count = $node_list_count
            node_array        = $node_list
            page_uri_suffix   = concat( '?', $requested_uri_suffix)}
        {else}
            {def $page_uri=concat( '/content/browse/', $main_node.node_id )}

            {set browse_list_count=fetch( content, list_count, hash( parent_node_id, $node_id, depth, 1, objectname_filter, $view_parameters.namefilter) )}
            {if $browse_list_count}
                {set node_array=fetch( content, list, hash( parent_node_id, $node_id, depth, 1, offset, $view_parameters.offset, limit, $number_of_items, sort_by, $main_node.sort_array, objectname_filter, $view_parameters.namefilter ) )}
            {/if}
        {/if}

        {if eq( $browse.return_type, 'NodeID' )}
            {set select_name='SelectedNodeIDArray'}
            {set select_attribute='node_id'}
        {/if}

        {if eq( $browse.selection, 'single' )}
            {set select_type='radio'}
        {/if}


        <div class="col-md-12 m_bottom_20">
            {if $browse.description_template}
                {include name=Description uri=$browse.description_template browse=$browse main_node=$main_node}
            {else}
                <div class="attribute-header">
                    <h1 class="long">{'Browse'|i18n( 'design/ocbootstrap/content/browse' )}{if $main_node} - {$main_node.name|wash}{/if}</h1>
                </div>
                <p>{'To select objects, choose the appropriate radiobutton or checkbox(es), and click the "Select" button.'|i18n( 'design/ocbootstrap/content/browse' )}</p>
                <p>{'To select an object that is a child of one of the displayed objects, click the parent object name to display a list of its children.'|i18n( 'design/ocbootstrap/content/browse' )}</p>
            {/if}
        </div>

        {if eq($browse.action_name, 'AddUserToCourse')}

            {set col = 'col-md-6'
                 browse_list_count = 10
                 node_array=fetch( content, list, hash( parent_node_id, $node_id, depth, 1, limit, 10, sort_by, array( 'published', false() ) ) )}
            <div class="col-md-6">
                <div class="panel panel-default clearfix">
                    <div class="panel-heading">
                        Ultimi 10 utenti aggiunti
                    </div>
                    <form name="browse" action={$browse.from_page|ezurl()} method="post">

                        {include uri='design:content/browse_mode_list.tpl'}

                        {if $browse.persistent_data|count()}
                            {foreach $browse.persistent_data as $key => $data_item}
                                <input type="hidden" name="{$key|wash}" value="{$data_item|wash}"/>
                            {/foreach}
                        {/if}


                        <input type="hidden" name="BrowseActionName" value="{$browse.action_name}"/>
                        {if $browse.browse_custom_action}
                            <input type="hidden" name="{$browse.browse_custom_action.name}"
                                   value="{$browse.browse_custom_action.value}"/>
                        {/if}


                        <div style="padding: 10px" class="clearfix">
                            <button class="pull-left btn btn-primary" type="submit"
                                    name="SelectButton">{'Select'|i18n('design/ocbootstrap/content/browse')}</button>
                            {if $cancel_action}
                                <input type="hidden" name="BrowseCancelURI" value="{$cancel_action|wash}"/>
                            {/if}
                            <button class="pull-right btn btn-large btn-default" type="submit"
                                    name="BrowseCancelButton">{'Cancel'|i18n( 'design/ocbootstrap/content/browse' )}</button>
                            {if ezhttp_hasvariable( 'SearchText', 'get' )}
                                <a class="pull-right btn btn-default" style="margin-right: 10px"
                                   href={'content/browse'|ezurl()}>Annulla ricerca</a>
                            {/if}
                        </div>
                    </form>
                </div>
                {* Ulitmi 10 iscritti ai corsi *}
                {def $subscriptionParentNode = 8125
                     $subscription = fetch( content, list, hash( parent_node_id, $subscriptionParentNode, class_filter_type,  'include', class_filter_array, array( 'subscription' ), depth, 1, limit, 30, sort_by, array( 'published', false() ) ) )
                }
                {if $subscription|count()|gt(0)}

                    {def $object = false()
                         $sub_users_ids = array()
                         $sub_users = array()}
                    {foreach $subscription as $s}
                        {if $sub_users_ids|contains( $s.data_map.user.content.current.contentobject_id )|not()}
                            {set $object = fetch( 'content', 'object', hash( 'object_id', $s.data_map.user.content.current.contentobject_id ) )
                                 $sub_users_ids = $sub_users_ids|append( $s.data_map.user.content.current.contentobject_id )
                                 $sub_users = $sub_users|append( $object.main_node )
                            }
                        {/if}
                        {if $sub_users_ids|count()|eq(10)}
                            {break}
                        {/if}
                    {/foreach}
                    {set browse_list_count = 10
                         node_array = $sub_users
                    }
                    <div class="panel panel-default clearfix">
                        <div class="panel-heading">
                            Ultimi 10 utenti iscritti
                        </div>
                        <form name="browse" action={$browse.from_page|ezurl()} method="post">

                            {include uri='design:content/browse_mode_list.tpl'}

                            {if $browse.persistent_data|count()}
                                {foreach $browse.persistent_data as $key => $data_item}
                                    <input type="hidden" name="{$key|wash}" value="{$data_item|wash}"/>
                                {/foreach}
                            {/if}


                            <input type="hidden" name="BrowseActionName" value="{$browse.action_name}"/>
                            {if $browse.browse_custom_action}
                                <input type="hidden" name="{$browse.browse_custom_action.name}"
                                       value="{$browse.browse_custom_action.value}"/>
                            {/if}


                            <div style="padding: 10px" class="clearfix">
                                <button class="pull-left btn btn-primary" type="submit"
                                        name="SelectButton">{'Select'|i18n('design/ocbootstrap/content/browse')}</button>
                                {if $cancel_action}
                                    <input type="hidden" name="BrowseCancelURI" value="{$cancel_action|wash}"/>
                                {/if}
                                <button class="pull-right btn btn-large btn-default" type="submit"
                                        name="BrowseCancelButton">{'Cancel'|i18n( 'design/ocbootstrap/content/browse' )}</button>
                                {if ezhttp_hasvariable( 'SearchText', 'get' )}
                                    <a class="pull-right btn btn-default" style="margin-right: 10px"
                                       href={'content/browse'|ezurl()}>Annulla ricerca</a>
                                {/if}
                            </div>

                        </form>
                    </div>
                    {undef $subscriptionParentNode $subscription $object $sub_users_ids $sub_users}
                {/if}
            </div>
            {if is_set( $node_list )}
                {set $page_uri=$requested_uri }
                {set browse_list_count = $node_list_count
                node_array        = $node_list
                page_uri_suffix   = concat( '?', $requested_uri_suffix)}
            {else}
                {set $page_uri=concat( '/content/browse/', $main_node.node_id )}

                {set browse_list_count=fetch( content, list_count, hash( parent_node_id, $node_id, depth, 1, objectname_filter, $view_parameters.namefilter) )}
                {if $browse_list_count}
                    {set node_array=fetch( content, list, hash( parent_node_id, $node_id, depth, 1, offset, $view_parameters.offset, limit, $number_of_items, sort_by, $main_node.sort_array, objectname_filter, $view_parameters.namefilter ) )}
                {/if}
            {/if}
        {/if}

            <div class="{$col}">
                <div class="panel panel-default clearfix">
                    {def $current_node=fetch( content, node, hash( node_id, $browse.start_node ) )}
                    {if $browse.start_node|gt( 1 )}
                        <div class="panel-heading">
                            <a href={concat( '/content/browse/', $main_node.parent_node_id, '/' )|ezurl}><span
                                        class="glyphicon glyphicon-arrow-up"></span></a>
                            {$current_node.name|wash}&nbsp;[{$current_node.children_count}]
                        </div>
                    {/if}

                    <form role="search" class="relative type_2 m_top_5" method="get"
                          action="{'/content/search'|ezurl( 'no' )}">
                        <input class="form-control" type="search" name="SearchText" id="site-wide-search-field"
                               placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}"/>
                        <button type="submit" class="f_right search_button tr_all_hover f_xs_none"><i
                                    class="fa fa-search"></i></button>
                        <input name="Mode" type="hidden" value="browse"/>
                        <input name="BrowsePageLimit" type="hidden" value="{$number_of_items}"/>
                        <input name="SubTreeArray[]" type="hidden" value="{$browse.start_node}"/>
                    </form>

                    <form name="browse" action={$browse.from_page|ezurl()} method="post">

                        {include uri='design:content/browse_mode_list.tpl'}

                        {include name=Navigator
                        uri='design:navigator/google.tpl'
                        page_uri=concat('/content/browse/',$main_node.node_id)
                        item_count=$browse_list_count
                        view_parameters=$view_parameters
                        item_limit=$number_of_items}

                        {if $browse.persistent_data|count()}
                            {foreach $browse.persistent_data as $key => $data_item}
                                <input type="hidden" name="{$key|wash}" value="{$data_item|wash}"/>
                            {/foreach}
                        {/if}


                        <input type="hidden" name="BrowseActionName" value="{$browse.action_name}"/>
                        {if $browse.browse_custom_action}
                            <input type="hidden" name="{$browse.browse_custom_action.name}"
                                   value="{$browse.browse_custom_action.value}"/>
                        {/if}


                        <div style="padding: 10px" class="clearfix">
                            <button class="pull-left btn btn-primary" type="submit"
                                    name="SelectButton">{'Select'|i18n('design/ocbootstrap/content/browse')}</button>
                            {if $cancel_action}
                                <input type="hidden" name="BrowseCancelURI" value="{$cancel_action|wash}"/>
                            {/if}
                            <button class="pull-right btn btn-large btn-default" type="submit"
                                    name="BrowseCancelButton">{'Cancel'|i18n( 'design/ocbootstrap/content/browse' )}</button>
                            {if ezhttp_hasvariable( 'SearchText', 'get' )}
                                <a class="pull-right btn btn-default" style="margin-right: 10px"
                                   href={'content/browse'|ezurl()}>Annulla ricerca</a>
                            {/if}
                        </div>

                    </form>
                </div>
            </div>
        {/let}
    </div>
</div>