{def $afilter = array( array( 'user/card', '=', '') )
	$users = fetch( 'content', 'tree', 
	hash( parent_node_id, 12, 
		main_node_only, true(),
		class_filter_type, 'include', 
		class_filter_array, array( 'user' ),
		attribute_filter, $afilter,
		sort_by, array( 'published', true() ) ,
		)
)}{foreach $users as $node
}{def $subscriptions = fetch(
    'content', 'tree', hash(
		    parent_node_id, 1,
		    class_filter_type, 'include',
		    class_filter_array, array( 'subscription' ),
		    attribute_filter, array(
			    array( 'subscription/user', '=', $node.object.id )
		    ),
		    sort_by, array(
		    	array( 'published', false() )
		    )
	    )
    )
}{def
	$subdate=0
	$subcourse=false()
	$annullato=true()
}{foreach $subscriptions as $subscription
}{def 
	$cname = $subscription.data_map.course.content.name|wash()|downcase()
	$area_tematica = fetch( 'content', 'related_objects', 
		hash( 'object_id', $subscription.data_map.course.content.id, 
			'attribute_identifier', 'corso/area_tematica'
			) 
		)[0]
	}{if $area_tematica.id|eq(15903)
		}{if $subcourse|not()
			}{set 
			$subcourse=$subscription.data_map.course
			$subdate=$subscription.object.published
		}{/if
		}{if eq($subscription.data_map.annullata.content, 0)
            }{if ge($subscription.object.published,$subdate)
            	}{set $subdate=$subscription.object.published
            		$subcourse=$subscription.data_map.course
            		$annullato=false()
              }{/if
	    }{/if
    }{/if
    }{undef $cname $area_tematica
}{/foreach
}{def 
	$expdate=makedate($subdate|datetime(custom, '%m')|int(),$subdate|datetime(custom, '%d')|int(),$subdate|datetime(custom, '%Y')|int()|sum(1))
	$print = and($expdate|sub(currentdate())|gt(0),$annullato|not())
}{if $print}{include uri="design:parts/csv_user.tpl" 
	id=$node.object.id
	firstname=$node.data_map.first_name.content
	surname=$node.data_map.last_name.content
	birthdate=$node.data_map.data_nascita.data_text|strtotime()|datetime('custom','%d/%m/%Y')
	email=$node.data_map.user_account.content.email
	card=$node.data_map.card.content
	expdate=$expdate
	anullato=$annullato
	}{undef $subscriptions $card_course $subcourse $subdate $expdate $annullato}{'\r\n'
}{/if}{/foreach}{/if}