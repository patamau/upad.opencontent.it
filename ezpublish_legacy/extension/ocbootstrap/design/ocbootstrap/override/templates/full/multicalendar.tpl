{set-block scope=root variable=cache_ttl}900{/set-block}
{* Multicalendar - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
	
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}
    
    {foreach $node.data_map.calendars.content.relation_list as $relation}
      {def $related_node = fetch( 'content', 'node', hash( 'node_id', $relation.node_id ) )
           $related_node_children = fetch( 'content', 'list', hash( 'parent_node_id', $related_node.node_id,
                                                                     'limit', '5',
                                                                     'class_filter_type', 'include',
                                                                     'class_filter_array', array( 'event' ),
                                                                     'sort_by', array( 'attribute', true(), 'event/from_time' ) ) )}
      <h2><a href="{$related_node.url_alias|ezurl(no)}">{$related_node.name}</a></h2>
      <div class="table-responsive">
        <table class="table table-striped" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <th>{'Event'|i18n( 'design/ocbootstrap/full/multicalendar' )}</th>
            <th>{'Start date'|i18n( 'design/ocbootstrap/full/multicalendar' )}</th>
            <th>{'Category'|i18n( 'design/ocbootstrap/full/multicalendar' )}</th>
            <th>{'Description'|i18n( 'design/ocbootstrap/full/multicalendar' )}</th>
        </tr>
        {foreach $related_node_children as $child sequence array( 'bglight', 'bgdark' ) as $style}
        <tr>
            <td><a href="{$child.url_alias|ezurl(no)}">{$child.name|wash()}</a></td>
            <td>{attribute_view_gui attribute=$child.data_map.from_time}</td>
            <td>{attribute_view_gui attribute=$child.data_map.category}</td>
            <td>{attribute_view_gui attribute=$child.data_map.text}</td>
        </tr>
        {/foreach}
        </table>
      </div>
      {undef}
    {/foreach}
	
  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>