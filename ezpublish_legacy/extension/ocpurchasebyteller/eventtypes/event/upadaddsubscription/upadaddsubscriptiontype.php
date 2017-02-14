<?php

class UpadAddSubscriptionType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = 'upadaddsubscription';    

    function UpadAddSubscriptionType()
    {
        $this->eZWorkflowEventType( self::WORKFLOW_TYPE_STRING, "Aggiunge iscrizione al corso acquistato" );
        $this->setTriggerTypes( array( 'shop' => array( 'checkout' => array( 'after' ) ) ) );
    }

    function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        $order = eZOrder::fetch( $parameters['order_id'] );
        UpadSubscription::fromOrder( $order );        
        
        return eZWorkflowType::STATUS_ACCEPTED;
    }

}

eZWorkflowEventType::registerEventType( UpadAddSubscriptionType::WORKFLOW_TYPE_STRING, "UpadAddSubscriptionType" );