{set_defaults( hash(
	'id',$node.object.id,
	'firstname',$node.data_map.first_name.content,
	'surname',$node.data_map.last_name.content,
	'birthdate',$node.data_map.data_nascita.data_text|strtotime()|datetime('custom','%d/%m/%Y'),
	'card',$node.data_map.card.content,
	'expdate',0
) )
}{if $expdate|eq(0)
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
	}{if $area_tematica.name|eq('Tesseramento')
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
}{set $expdate=makedate($subdate|datetime(custom, '%m')|int(),$subdate|datetime(custom, '%d')|int(),$subdate|datetime(custom, '%Y')|int()|sum(1))
}{/if
}{$id},{$firstname},{$surname},{$birthdate},{$card},{$expdate|datetime(custom,'%d/%m/%Y')
}{undef $subscriptions $card_course $subcourse $subdate $expdate}