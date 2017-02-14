<?php

class UpadSubscribeCreatedUserType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = 'upadsubscribecreateduser';

    function __construct()
    {
        $this->eZWorkflowEventType( self::WORKFLOW_TYPE_STRING, "Iscrive al corso l'untente appena creato" );
        $this->setTriggerTypes( array( 'content' => array( 'publish' => array( 'after' ) ) ) );
    }

    function execute( $process, $event )
    {
        $parameters = $process->attribute('parameter_list');
        $objectID = $parameters['object_id'];
        $object = eZContentObject::fetch($objectID);
        $http = eZHTTPTool::instance();

        if ( !$object instanceof eZContentObject ) {
            return eZWorkflowType::STATUS_WORKFLOW_CANCELLED;
        }

        if ($object->attribute('class_identifier') == 'user' && $http->hasSessionVariable('TargetCourse'))
        {
            $courseID = $http->sessionVariable('TargetCourse');
            $http->removeSessionVariable('TargetCourse');
            $course = eZContentObject::fetch( $courseID );
            if ( $course instanceof eZContentObject)
            {
                UpadSubscription::instance( $courseID, $object->ID );
                $localHost       = eZSys::serverURL();
                $indexDir        = eZSys::indexDir();
                header('Location: ' . $localHost . $indexDir . '/courses/list/' . $courseID);
                eZExecution::cleanExit();
            }
        }
        return eZWorkflowType::STATUS_ACCEPTED;
    }

}

eZWorkflowEventType::registerEventType( UpadSubscribeCreatedUserType::WORKFLOW_TYPE_STRING, "UpadSubscribeCreatedUserType" );