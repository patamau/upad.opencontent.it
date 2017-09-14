<?php

class nxcMyClass
{
	/**
	 * Filtro per relazione oggetto.
	 * @param unknown $params specifica 
	 * 'otherobject_id' id dell'oggetto in relazione da matchare
	 * 'compare' es: = oppure !=
	 * @return string[]|NULL[]|string[]
	 */
	public function myFilter( $params ) {
		
		//SELECT * FROM ezcontentobject INNER JOIN ezcontentobject_link ON ezcontentobject_link.from_contentobject_id = ezcontentobject.id AND ezcontentobject_link.to_contentobject_id=15903 WHERE 1
		//l'area tematica è la 390
		$joins = ' ezcontentobject_link.from_contentobject_id = ezcontentobject.id AND ezcontentobject_link.contentclassattribute_id = 390 AND ezcontentobject_link.to_contentobject_id '.$params['compare'].' '.$params['otherobject_id'].' AND ';

		return array(
				'tables'  => ', ezcontentobject_link',
				'joins'   => $joins,
				'columns' => null
		);
	}
}
?>