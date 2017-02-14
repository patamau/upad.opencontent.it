#!/usr/bin/env php
<?php

error_reporting(E_ERROR);

require 'autoload.php';

$cli = eZCLI::instance();

$cli->output( "Script start" );


$script = eZScript::instance( array( 'description' => ( "Upad publish course ws script" ),
                                     'use-session' => false,
                                     'use-modules' => true,
                                     'use-extensions' => true,
                                     'user' => false ) );

$script->startup();
$script->initialize();
$script->setUseDebugAccumulators( true );


$wsINI      = eZINI::instance( 'ocwscourse.ini' );
$upadID     = $wsINI->variable( 'EnteSetting', 'UpadID' );
$palladioID = $wsINI->variable( 'EnteSetting', 'PalladioID' );

$wsUrl = $wsINI->variable( 'WsSettings', 'WsUrl' );
$wsUsername = $wsINI->variable( 'WsSettings', 'WsUsername' );
$wsPassword = $wsINI->variable( 'WsSettings', 'WsPassword' );

$parentNodeID = 2;
$limit = 2;


$params = array(
    'ClassFilterType'  => 'include',
    'ClassFilterArray' => array( 'corso' ),
    //'LoadDataMap'      => true,
    //'IgnoreVisibility' => true
);

// Get the total courses count
$count  = eZContentObjectTreeNode::subTreeCountByNodeID( $params, $parentNodeID );

$cli->output( 'Corsi totali: ' .  $count);


$offset = 0;
$i = 0;
$params['Limit'] = $limit;


while( $offset <= $count )
{
    $params[ 'Offset' ] = $offset;
    $courses = eZContentObjectTreeNode::subTreeByNodeID( $params, $parentNodeID );

    foreach( $courses as $c )
    {
        //$cli->output( $i . ': ' .$c->attribute( 'name' ) );


        $datamap = $c->dataMap();

        // Ente
        $rel_ente = $datamap['ente']->content();
        $ente = eZContentObject::fetch( $rel_ente['relation_list'][0]['contentobject_id'] );


        if ($ente->ID != $upadID && $ente->ID != $palladioID) {

            $cli->warning($i . ': ' . $c->attribute( 'name' ) . ' ---------- Ws non eseguito,  corso non Upad/Palladio');

        } else {

            $attributes = array();
            $attributes['ente'] = $ente->ID;
            //$this->log(print_r($c, true));
            //$this->log(print_r($datamap, true));

            //Id
            if ($c->attribute( "current_version" ) > 1 && $datamap['ws_id']->attribute('data_text') != '') {
                $attributes['id'] = $datamap['ws_id']->attribute('data_text');
            }

            // Titolo
            $attributes['titolo'] = $datamap['title']->attribute('data_text');
            // Giorno d'inizio
            $attributes['data_inizio'] = strftime( '%Y-%m-%d',  $datamap['data_inizio']->attribute('data_int'));
            // Giorno di fine
            $attributes['data_fine'] = strftime( '%Y-%m-%d',  $datamap['data_fine']->attribute('data_int'));
            // Docente
            $attributes['docente'] = $datamap['docente']->attribute('data_text');
            // Descrizione
            $attributes['descrizione'] = substr(strip_tags($datamap['short_description']->attribute('data_text')), 0, 380);


            // Area tematica
            $rel_area_tematica = $datamap['area_tematica']->content();
            $area_tematica = eZContentObject::fetch( $rel_area_tematica['relation_list'][0]['contentobject_id'] );
            //$this->log(print_r($area_tematica, true));
            $attributes['area_tematica'] = $area_tematica->Name;

            // Luogo
            $rel_luogo = $datamap['luogo']->content();
            $luogo = eZContentObject::fetch( $rel_luogo['relation_list'][0]['contentobject_id'] );
            $data_map_luogo = $luogo->dataMap();
            //$this->log(print_r($data_map_luogo, true));

            $attributes['luogo'] = array(
                'indirizzo' => $data_map_luogo['indirizzo']->attribute('data_text'),
                'numero_civico' => $data_map_luogo['numero_civico']->attribute('data_text'),
                'cap' => $data_map_luogo['cap']->attribute('data_text'),
                'citta' => $data_map_luogo['city']->attribute('data_text'),
                'codice_catasto' => $data_map_luogo['codice_catasto']->attribute('data_text')
            );

            // Destinatari
            $rel_destinatari = $datamap['destinatari']->content();
            foreach ($rel_destinatari['relation_list'] as $k => $v) {
                $destinatari = eZContentObject::fetch( $v['contentobject_id'] );
                $attributes['destinatari'][] = $destinatari->Name;
            }
            //$this->log(print_r($attributes, true));

            // Istanzio la classe che si occupa di interrogare i webservices
            $wsCourse = new WsCourse($wsUrl, $wsUsername, $wsPassword, 'sync_script_publishcourse.log');

            $wsId = $wsCourse->publishCourse($attributes);


            if ($wsId) {
                // L'inserimento è avvenuto con successo, salvo l'id restituito dal ws nell'oggetto
                $datamap['ws_id']->fromString( $wsId );
                $datamap['ws_id']->store();

                $cli->output($i . ': ' . $attributes['titolo'] . ' # ' . $wsId);

            } else {
                $cli->output($i . ': ' . $attributes['titolo'] . ' Errore ws ');
            }
        }

        $i++;
    }
    // Increment the offset until we've gone through every user
    $offset += $limit;

    // Clear the eZ Publish in-memory object cache
    //eZContentObject::clearCache();
}

$script->shutdown();

?>
