<?php

class UpadCheckCoursesInBasketType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = 'upadcheckcoursesinbasket';
    const LOGFILE = 'upadcheckcoursesinbasket.log';

    function UpadCheckCoursesInBasketType()
    {
        $this->eZWorkflowEventType( self::WORKFLOW_TYPE_STRING, "Verifica non ci siano corsi di diversi enti nel carrello" );
        $this->setTriggerTypes( array( 'shop' => array( 'addtobasket' => array( 'before' ) ) ) );
    }

    protected function log( $message ) {
        eZLog::write( $message, self::LOGFILE );
        eZCLI::instance()->output( $message );
    }

    function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        //$order = eZOrder::fetch( $parameters['order_id'] );
        $object = eZContentObject::fetch( $parameters['object_id'] );
        $basket = eZBasket::currentBasket();

        if ( $object->attribute( 'class_identifier' ) == 'corso') {

            //$this->log(print_r($process, true));

            if ($basket->isEmpty()) {
                $this->log('accepted');
                return eZWorkflowType::STATUS_ACCEPTED;
            } else {
                /*
                //$this->log('rejected');
                //$http = eZHTTPTool::instance();
                $datamap = $object->dataMap();
                // Ente
                $rel_ente = $datamap['ente']->content();
                $products = $basket->items();

                foreach ($products as $p) {
                    $tempObject = $p['item_object']->ContentObject;
                    if ($tempObject->attribute( 'class_identifier' ) == 'corso') {
                        $tempDatamap = $tempObject->dataMap();
                        $tempRel_ente = $tempDatamap['ente']->content();

                        // Controllo che il corso da aggiungere sia dello stesso ente dei corsi già aggiunti
                        if ($rel_ente['relation_list'][0]['contentobject_id'] != $tempRel_ente['relation_list'][0]['contentobject_id']) {

                            $this->log('rejected ' . $rel_ente['relation_list'][0]['contentobject_id'] . ' ---- ' . $tempRel_ente['relation_list'][0]['contentobject_id']);

                            $localHost       = eZSys::serverURL();
                            $indexDir        = eZSys::indexDir();
                            header('Location: ' . $localHost . $indexDir . '/shop/basket/(error)/ente');
                            ////return eZWorkflowType::STATUS_REDIRECT;
                            eZExecution::cleanExit();
                            //return eZWorkflowType::STATUS_REJECTED;
                        }

                    }
                }*/

                $localHost       = eZSys::serverURL();
                $indexDir        = eZSys::indexDir();
                header('Location: ' . $localHost . $indexDir . '/shop/basket/(error)/noempty');
                ////return eZWorkflowType::STATUS_REDIRECT;
                eZExecution::cleanExit();

            }
        }
        //return eZWorkflowType::STATUS_ACCEPTED;
    }

}

eZWorkflowEventType::registerEventType( UpadCheckCoursesInBasketType::WORKFLOW_TYPE_STRING, "UpadCheckCoursesInBasketType" );
