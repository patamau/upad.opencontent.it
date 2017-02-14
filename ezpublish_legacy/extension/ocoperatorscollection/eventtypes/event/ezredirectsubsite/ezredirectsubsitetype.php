<?php

class eZRedirectSubisteType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = "ezredirectsubsite";
    
	function eZRedirectSubisteType()
    {
        $this->eZWorkflowEventType( eZRedirectSubisteType::WORKFLOW_TYPE_STRING, ezpI18n::tr( 'opencontent', 'Redirect' ) );
        $this->setTriggerTypes( array( 'content' => array( 'read' => array( 'before' ) ) ) );
    }

    function execute( $process, $event )
    {
        $parameterList = $process->attribute( 'parameter_list' );
        $nodeID = $parameterList['node_id'];
        $userID = $parameterList['user_id'];
        $languageCode = $parameterList['language_code'];
        
        $ini = eZINI::instance( 'ocoperatorscollection.ini' );        
        foreach( $ini->variable( 'Redirect', 'ExcludeReferers' ) as $exclude )
        {            
            if ( isset( $_SERVER['HTTP_REFERER'] ) && strpos( $_SERVER['HTTP_REFERER'], $exclude ) !== false )
            {
                return eZWorkflowType::STATUS_ACCEPTED;
            }
        }
        
        $node = eZContentObjectTreeNode::fetch( $nodeID );
        if ( !$node )
        {
            return eZWorkflowType::STATUS_ACCEPTED;
        }
        
        $http = eZHTTPTool::instance();
        $http->setSessionVariable( "RedirectAfterLogin", 'content/view/full/' . $nodeID );
        
        $identifiers = $ini->hasVariable( 'Subsite', 'Classes' ) ? $ini->variable( 'Subsite', 'Classes' ) : array();
        
        if ( in_array( $node->attribute( 'class_identifier' ), $identifiers ) )
        {
            $dataMap = $node->attribute( 'data_map' );
            if ( isset( $dataMap['link'] ) && $dataMap['link']->hasContent() )
            {
                if ( $dataMap['link']->Content() !== "http://" . eZSys::hostname() . '/' )
                    header( 'Location: ' . $dataMap['link']->Content() );
            }
            
        }
        
        $path = $node->attribute( 'path' );
        
        foreach ( $path as $item )
        {
            if ( in_array( $item->attribute( 'class_identifier' ), $identifiers ) )
            {
                $dataMap = $item->attribute( 'data_map' );
                if ( isset( $dataMap['link'] ) && $dataMap['link']->hasContent() )
                {
                    if ( $dataMap['link']->Content() !== "http://" . eZSys::hostname() . '/' )
                        header( 'Location: ' . $dataMap['link']->Content() . 'content/view/full/' . $nodeID );
                }
                
            }
        }
        
        return eZWorkflowType::STATUS_ACCEPTED;
    }

}

eZWorkflowEventType::registerEventType( eZRedirectSubisteType::WORKFLOW_TYPE_STRING, 'eZRedirectSubisteType' );

?>