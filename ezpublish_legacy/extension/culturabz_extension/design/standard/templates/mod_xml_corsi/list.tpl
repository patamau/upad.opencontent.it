<?xml version="1.0" encoding="UTF-8"?>
<events>
	{foreach $corsi_attivi as $corso max 2}
		{if $corso.data_map.area_tematica.content.relation_list[0].contentobject_id|ne('15903')}{*Se non si tratta di un corso TESSERAMENTO*}
			{*$corso|attribute('show')*}
			<event>
				<!--  Termine der Veranstaltung  -->
				<date>
					<!--  ID der Gemeinde/Fraktion auf kultur.bz.it  -->
					<fkgemid>12</fkgemid>
					<!-- optional Name der Gemeinde/Fraktion wenn kultur.bz.it id nicht verfubar | nicht empfehlenswert	-->
					<searchgem>Bolzano</searchgem>
					<!--  ID des Veranstaltungsortes auf kultur.bz.it  -->
					<fkplaceid>1960</fkplaceid>
					<!-- optional Name des Veranstaltungsortes wenn kultur.bz.it id nicht verfugbar | nicht empfehlenswert	-->
					<searchplace>Sede Upad Bolzano/ Upad Bozen Firmensitz</searchplace>
					<!--  Begin Datum  yyyy-mm-dd  -->
					<startdate>{$corso.data_map.data_inizio.content|datetime( 'custom' ,'%Y-%m-%d' )}</startdate>
					<!--  optional End Datum yyyy-mm-dd  -->
					<enddatedate>{$corso.data_map.data_fine.content|datetime( 'custom' ,'%Y-%m-%d' )}</enddatedate>
					<!--  Begin Uhrzeit in Minuten  -->
					{def $time = explode($corso.data_map.fascia_oraria.content ,'-')}
					{if $time|count()|eq(2)}{*INSERISCO GLI ORARI SOLO SE CI SONO*}
						<starttime>{$time[0]|trim('.')}</starttime>
						<!--  optional End Uhrzeit in Minuten  -->
						<endtime>{$time[1]|trim('.')}</endtime>
					{/if}
				</date>
				<!--
				 Eindeutige ID der Veranstaltung auf dem Partnersystem 
				-->
				<originid>{$corso.contentobject_id}</originid>
				<!--  ID der Kategorie auf kultur.bz.it  -->{*Per il momento mettiamo 50=Corsi/Workshop*}
				<fkcatid>50</fkcatid>
				<!--  Titel DE der Veranstalktung nur Plain Text  -->
				<title lang="it">{$corso.data_map.title.content|explode('&')|implode('&amp;')}</title>
				<!--
				 Kurzbeschreibung DE der Veranstalktung nur Plain Text 
				-->
				<desc lang="it">{$corso.data_map.title.content|explode('&')|implode('&amp;')}</desc>
				<!--  Beschreibung DE der Veranstaltung auch Html  -->
				<content lang="it">
					{*$corso.data_map.description.content.input.input_xml|explode('&')|implode('&amp;')*}
					{set-block variable=$descrizioneXML}
						{attribute_view_gui attribute=$corso.data_map.description}
					{/set-block}
					{$descrizioneXML|explode('&')|implode('&amp;')|explode('&nbsp')|implode('')}
				</content>
				<!--  Src des Bildes  -->
				<images>
					<imagesrc>
						{def $url_array = $corso.data_map.image.content.reference.url|ezurl('no','full')|explode('/')}
						{set $url_array = $url_array |remove(3,1)}
						{$url_array|implode('/')}
					</imagesrc>
					
					{def $ente = fetch( content, object, hash( object_id, $corso.data_map.ente.content.relation_list[0].contentobject_id ) )}
					<imageautor>{$ente.name}</imageautor>
					{undef $ente }
					
					<topimage>1</topimage>
				</images>
				<!--  Unix-Timestamp der letzten Anderung  -->
				<timemodify>{$corso.object.modified.content}</timemodify>
			</event>
		{/if}
	{/foreach}
</events>