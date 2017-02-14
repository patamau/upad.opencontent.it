<?php

class PublishCourseType extends eZWorkflowEventType {

    const WORKFLOW_TYPE_STRING = "publishcourse";
    const LOGFILE = 'ecws_workflow_publishcourse.log';

    public function __construct() {
        parent::__construct( PublishCourseType::WORKFLOW_TYPE_STRING, 'Publish course' );
        $this->setTriggerTypes( array( 'content' => array( 'publish' => array( 'after' ) ) ) );
    }

    protected function log( $message ) {
        eZLog::write( $message, self::LOGFILE );
        eZCLI::instance()->output( $message );
    }

    public function publishCourse ( eZContentObject $object ) {
        if ( !$object instanceof eZContentObject ) {
            $this->log( "Oggetto non valido" );
            return false;
        }

        if ( $object->attribute( 'class_identifier' ) == 'corso' /*&& $object->attribute( "current_version" ) == 1*/) {

            $wsINI      = eZINI::instance( 'ocwscourse.ini' );
            $upadID     = $wsINI->variable( 'EnteSetting', 'UpadID' );
            $palladioID = $wsINI->variable( 'EnteSetting', 'PalladioID' );

            $datamap = $object->dataMap();

            // Ente
            $rel_ente = $datamap['ente']->content();
            $ente = eZContentObject::fetch( $rel_ente['relation_list'][0]['contentobject_id'] );


            if ($ente->ID != $upadID && $ente->ID != $palladioID) {
                $this->log('Workflow non eseguito, Corso non uapd, palladio ');
                return true;
            }

            $attributes = array();
            $attributes['ente'] = $ente->ID;
            $this->log(print_r($object, true));
            //$this->log(print_r($datamap, true));

            //Id
            if ($object->attribute( "current_version" ) > 1 && $datamap['ws_id']->attribute('data_text') != '') {
                $attributes['id'] = $datamap['ws_id']->attribute('data_text');
            }

            // Titolo
            $attributes['titolo'] = $datamap['title']->attribute('data_text');

            // $ora 18:00 - 20:00, 18:00:00 - 20:00:00, 18.00 - 20.00, 18.00.00 - 20.00.00
            $oraInizio = '00:00:00';
            $oraFine = '00:00:00';
            $orario =  $datamap['orario']->toString();
            $orarioArray = explode('-', $orario);

            if (count($orarioArray) == 2)
            {
                $oraInizio = strftime( '%H:%M:%S',  trim(strtotime($orarioArray[0])));
                $oraFine = strftime( '%H:%M:%S',  trim(strtotime($orarioArray[1])));
            }

            // Giorno d'inizio
            $attributes['data_inizio'] = strftime( '%Y-%m-%d',  $datamap['data_inizio']->attribute('data_int')) . 'T' . $oraInizio;
            // Giorno di fine
            $attributes['data_fine'] = strftime( '%Y-%m-%d',  $datamap['data_fine']->attribute('data_int')) . 'T' . $oraFine;
            // Docente
            $attributes['docente'] = $datamap['docente']->attribute('data_text');
            // Descrizione
            $attributes['descrizione'] = substr(strip_tags($datamap['short_description']->attribute('data_text')), 0, 380);
            // Numero lezioni
            $attributes['numero_lezioni'] = $datamap['numero_lezioni']->toString();


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

            $wsUrl = $wsINI->variable( 'WsSettings', 'WsUrl' );
            $wsUsername = $wsINI->variable( 'WsSettings', 'WsUsername' );
            $wsPassword = $wsINI->variable( 'WsSettings', 'WsPassword' );

            // Istanzio la classe che si occupa di interrogare i webservices
            $wsCourse = new WsCourse($wsUrl, $wsUsername, $wsPassword, self::LOGFILE);

            $wsId = $wsCourse->publishCourse($attributes);

            $this->log('WsID: ' . $wsId);

            if ($wsId) {
                // L'inserimento è avvenuto con successo, salvo l'id restituito dal ws nell'oggetto
                $datamap['ws_id']->fromString( $wsId );
                $datamap['ws_id']->store();

                return true;
            } else {
                return false;
            }
        }
    }

    public function execute( $process, $event ) {
        $parameters = $process->attribute( 'parameter_list' );
        $objectID = $parameters['object_id'];
        $object = eZContentObject::fetch( $objectID );
        $this->publishCourse($object);

        return eZWorkflowType::STATUS_ACCEPTED;

    }
}

eZWorkflowEventType::registerEventType( PublishCourseType::WORKFLOW_TYPE_STRING,'publishcoursetype' );

?>
