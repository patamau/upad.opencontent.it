{def $users = fetch( 'content', 'tree', 
	hash( parent_node_id, 12, 
		main_node_only, true(), 
		class_filter_type, 'include', 
		'class_filter_array', array( 'user' ),
		attribute_filter, array(
					    array( 'user/card', '!=', '' )
				    ),
		sort_by, array( 'name', true() ) 
		)
)}{foreach $users as $node}{include uri="design:parts/csv_user.tpl" 
	id=$node.object.id
	firstname=$node.data_map.first_name.content
	surname=$node.data_map.last_name.content
	birthdate=$node.data_map.data_nascita.data_text|strtotime()|datetime('custom','%d/%m/%Y')
	card=$node.data_map.card.content
	}{'\r\n'}{/foreach}