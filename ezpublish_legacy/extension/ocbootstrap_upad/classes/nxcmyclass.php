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
		$joins = ' ezcontentobject_link.from_contentobject_id = ezcontentobject.id';
		$joins .= ' AND ezcontentobject_link.contentclassattribute_id = 390';
		$joins .= ' AND ezcontentobject.current_version=ezcontentobject_link.from_contentobject_version';
		$joins .= ' AND ezcontentobject_link.to_contentobject_id '.$params['compare'].' '.$params['otherobject_id'];
		$joins .= ' AND ';

		return array(
				'tables'  => ', ezcontentobject_link',
				'joins'   => $joins,
				'columns' => null
		);
	}
	
	public function filterCourseByEnte($params){
		$joins = ' ezcontentobject_link.from_contentobject_id = ezcontentobject.id';
		$joins .= ' AND ezcontentobject_link.contentclassattribute_id = 391';
		$joins .= ' AND ezcontentobject.current_version=ezcontentobject_link.from_contentobject_version';
		$joins .= ' AND ezcontentobject_link.to_contentobject_id = '.$params['ente'];
		$joins .= ' AND ';
		return array(
				'tables'  => ', ezcontentobject_link',
				'joins'   => $joins,
				'columns' => null
		);
	}
	
	/**
	 * Cerca utenti per contentobject_id
	 * @param unknown $params 'id' utente
	 */
	public function filterUserById( $params ) {
		$joins = ' ezcontentobject.id = '.$params['id'];
		$joins .= ' AND ';
		
		return array(
				'tables'  => '',
				'joins'   => $joins,
				'columns' => null
		);
	}

	/*
	
	 SELECT users.name, card_attribute.version as 'card version', users.current_version as 'user version', subscriptions.current_version as 'subscription version', courses.current_version as 'course version', card_attribute.data_text, courses.name, course_link.from_contentobject_version, areatematica_link.from_contentobject_version
	FROM ezcontentobject as subscriptions, ezcontentobject as users, ezcontentobject as courses,
	ezcontentobject_link as user_link, ezcontentobject_link as course_link, ezcontentobject_link as areatematica_link, ezcontentobject_attribute as card_attribute
	WHERE subscriptions.contentclass_id=49 AND user_link.from_contentobject_version=subscriptions.current_version
	AND user_link.from_contentobject_id=subscriptions.id AND users.id=user_link.to_contentobject_id
	AND card_attribute.contentobject_id=users.id AND card_attribute.version=users.current_version
	AND card_attribute.contentclassattribute_id=483 AND (card_attribute.data_text LIKE '' OR card_attribute.data_text IS NULL)
	 AND course_link.from_contentobject_id=subscriptions.id AND courses.id=course_link.to_contentobject_id AND course_link.from_contentobject_version=subscriptions.current_version AND areatematica_link.from_contentobject_id=courses.id AND areatematica_link.from_contentobject_version=courses.current_version
	 AND areatematica_link.contentclassattribute_id=390 AND areatematica_link.to_contentobject_id=15903
	 
	 */
}
?>