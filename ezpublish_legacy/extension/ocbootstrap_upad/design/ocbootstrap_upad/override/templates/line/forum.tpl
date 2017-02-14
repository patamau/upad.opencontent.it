<div class="content-view-line class-{$node.class_identifier} media">    
  <div class="media-body">
        <h4><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h4>
		
		{if $node|has_attribute( 'description' )}
		  {attribute_view_gui attribute=$node|attribute( 'description' )}
		{/if}
		
		{*<table class="list forum" cellspacing="0">
            <tr>                
                <th class="topic"> {"Number of topics"|i18n("design/ocbootstrap/line/forum")} </th>
                <th class="replies"> {"Number of posts"|i18n("design/ocbootstrap/line/forum")} </th>
                <th class="lastreply"> {"Last reply"|i18n( "design/ocbootstrap/line/forum" )} </th>
            </tr>
            <tr>
                <td>{fetch('content','list_count',hash(parent_node_id,$node.node_id))}</td>
                <td>{fetch('content','tree_count',hash(parent_node_id,$node.node_id))}</td>
                <td> {let forum_list = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                            'limit', 4,
                                            'sort_by', array( array( 'modified_subnode', false() ), array( 'node_id', false() ) ) ) )}
                    <ul>
                        {section loop=$forum_list}
                        <li> {node_view_gui view=line content_node=$:item} </li>
                        {/section}
                    </ul>
                    {/let}</td>
            </tr>
        </table>*}
    </div>
</div>
