{set_defaults( hash(
	'id',$node.object.id,
	'firstname',$node.data_map.first_name.content,
	'surname',$node.data_map.last_name.content,
	'birthdate',$node.data_map.data_nascita.data_text|strtotime()|datetime('custom','%d/%m/%Y'),
	'card',$node.data_map.card.content,	
) )}{$id},{$firstname},{$surname},{$birthdate},{$card}