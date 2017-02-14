<?php
/** @var eZModule $module */
$module = $Params['Module'];
$tpl = eZTemplate::factory();
$http = eZHTTPTool::instance();
$userParameters = $Params['UserParameters'];
$currentId = intval( $Params['ID'] );

if ( $http->hasGetVariable( 'Search' ) && !isset( $userParameters['query'] ) )
{
    $module->redirectTo( 'courses/archive/(class_id)/44/(query)/' . $http->getVariable( 'Search' ) );
    return;
}

if ( !isset( $userParameters['offset'] ) ) $userParameters['offset'] = 0;
if ( !isset( $userParameters['query'] ) ) $userParameters['query'] = '';

$tpl->setVariable( "view_parameters", $userParameters );

$current = $currentId > 0 ? eZContentObject::fetch( $currentId ) : false;


$Result = array();
if ( $current instanceof eZContentObject && $current->attribute( 'class_identifier' ) == 'corso' )
{

    /* Archivia */
    if ( $http->hasGetVariable( 'Archive' ) )
    {

        // Recupero l'id del nodo in cui muovere il corso
        $ini    = eZINI::instance( 'purchasebyteller.ini' );
        $list = $ini->variable( 'EnteSettings', 'list');
        
        
        $dataMap = $current->dataMap();
        $rel_ente = $dataMap['ente']->content();
        $enteID = $rel_ente['relation_list'][0]['contentobject_id'];
        $archiveNodeID = $ini->variable( $list[$enteID], 'ArchiveNodeId');

        if ($archiveNodeID)
        {
            if ( eZOperationHandler::operationIsAvailable( 'content_move' ) )
            {
                $operationResult = eZOperationHandler::execute(
                    'content', 'move', array(
                        'node_id'            => $current->mainNodeID(),
                        'object_id'          => $current->ID,
                        'new_parent_node_id' => $archiveNodeID
                    ),
                    null,
                    true
                );
            }
            else
            {
                $operationResult = eZContentOperationCollection::moveNode( $current->mainNodeID(), $current->ID, $archiveNodeID );
            }
            
            if (!$operationResult['status'])
            {
                return $module->handleError(eZError::KERNEL_NOT_FOUND);
            }
        }
        else
        {
            // Output error
            return $module->handleError(eZError::KERNEL_NOT_FOUND);
        }
    }

    /* Ripristina */
    if ( $http->hasGetVariable( 'Restore' ) )
    {
        // Recupero l'id del nodo in cui muovere il corso
        $ini    = eZINI::instance( 'purchasebyteller.ini' );
        $list = $ini->variable( 'EnteSettings', 'list');


        $dataMap = $current->dataMap();
        $rel_ente = $dataMap['ente']->content();
        $enteID = $rel_ente['relation_list'][0]['contentobject_id'];
        $coursesNodeID = $ini->variable( $list[$enteID], 'CoursesNodeId');

        if ($coursesNodeID)
        {
            if ( eZOperationHandler::operationIsAvailable( 'content_move' ) )
            {
                $operationResult = eZOperationHandler::execute(
                    'content', 'move', array(
                    'node_id'            => $current->mainNodeID(),
                    'object_id'          => $current->ID,
                    'new_parent_node_id' => $coursesNodeID
                ),
                    null,
                    true
                );
            }
            else
            {
                $operationResult = eZContentOperationCollection::moveNode( $current->mainNodeID(), $current->ID, $coursesNodeID );
            }

            if (!$operationResult['status'])
            {
                return $module->handleError(eZError::KERNEL_NOT_FOUND);
            }
        }
        else
        {
            // Output error
            return $module->handleError(eZError::KERNEL_NOT_FOUND);
        }
        return $module->redirectToView( 'list',  array($current->ID));
    }

    $tpl->setVariable( "course", $current );
    $Result['path'] = array(
        array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
        array( 'text' => "Archivio", 'url' => 'courses/archive' ),
        array( 'text' => $current->attribute( 'name' ), 'url' => false )
    );
    $Result['content'] = $tpl->fetch( 'design:courses/archive-single.tpl' );
}
else
{
    $Result['path'] = array(
        array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
        array( 'text' => "Archivio", 'url' => false )
    );
    $Result['content'] = $tpl->fetch( 'design:courses/archive-list.tpl' );
}
