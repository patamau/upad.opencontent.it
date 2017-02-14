<div class="content-view-full class-{$node.class_identifier} row">
  
  {* Per il menu di sinistra scommenta e togli "wide" dal content-main *}
  {*include uri='design:nav/nav-section.tpl'*}
    
  <div class="content-main wide">
    
    <h1>{$node.name|wash()}</h1>
    
    <div class="info text-right">
      {include uri='design:parts/date.tpl'}    
      {include uri='design:parts/author.tpl'}
    </div>
    
    {def $name_pattern = $node.object.content_class.contentobject_name|explode('>')|implode(',')
           $name_pattern_array = array('enable_comments', 'enable_tipafriend', 'show_children', 'show_children_exclude', 'show_children_pr_page')}
      {set $name_pattern  = $name_pattern|explode('|')|implode(',')}
      {set $name_pattern  = $name_pattern|explode('<')|implode(',')}
      {set $name_pattern  = $name_pattern|explode(',')}
      {foreach $name_pattern  as $name_pattern_string}
          {set $name_pattern_array = $name_pattern_array|append( $name_pattern_string|trim() )}
      {/foreach}
  
    <div class="table-responsive">
      <table class="table table-striped">
      {foreach $node.object.contentobject_attributes as $attribute}
        {if and( $name_pattern_array|contains($attribute.contentclass_attribute_identifier)|not(), $node|has_attribute( $attribute.contentclass_attribute_identifier ) )}
        <tr class="attribute-{$attribute.contentclass_attribute_identifier}">
          <th>{$attribute.contentclass_attribute_name}</th>
          <td>
            {attribute_view_gui attribute=$attribute}
          </td>
        </tr>
        {/if}
      {/foreach}
      </table>
    </div>
    
    {include uri='design:parts/children.tpl' view='line'}
	
	{include uri=concat('design:parts/relations.tpl') node=$node}   
	
  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}
  
</div>
