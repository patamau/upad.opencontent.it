<?php

$module = $Params['Module'];
$tpl    = eZTemplate::factory();
$http   = eZHTTPTool::instance();

$courseId = intval( $Params['CourseID'] );
$course = eZContentObject::fetch( $courseId );

if ( !$course instanceof eZContentObject )
{
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );
}

if ( $http->hasPostVariable( 'Discard' ) )
{
    $module->redirectTo( '/courses/list/');
    return;
}

if ( $http->hasPostVariable( "Create" ) )
{

    $anno     = $http->postVariable( "Anno", date('Y') );
    $edizione = $http->postVariable( "Edition", 1 );

    $newParentNodeID = $course->mainParentNodeID();
    $allVersions = false;

    $db = eZDB::instance();
    $db->begin();
    $newObject = $course->copy( $allVersions );
    // We should reset section that will be updated in updateSectionID().
    // If sectionID is 0 then the object has been newly created
    $newObject->setAttribute( 'section_id', 0 );
    $newObject->store();

    $dataMap = $newObject->dataMap();
    // Salvo l'anno
    $dataMap['anno']->fromString( $anno );
    $dataMap['anno']->store();

    // Salvo l'edizione
    $dataMap['edizione']->fromString( $edizione );
    $dataMap['edizione']->store();

    $curVersion        = $newObject->attribute( 'current_version' );
    $curVersionObject  = $newObject->attribute( 'current' );
    $newObjAssignments = $curVersionObject->attribute( 'node_assignments' );
    unset( $curVersionObject );

    // remove old node assignments
    foreach( $newObjAssignments as $assignment )
    {
        $assignment->purge();
    }

    // and create a new one
    $nodeAssignment = eZNodeAssignment::create( array(
                                                     'contentobject_id' => $newObject->attribute( 'id' ),
                                                     'contentobject_version' => $curVersion,
                                                     'parent_node' => $newParentNodeID,
                                                     'is_main' => 1
                                                     ) );
    $nodeAssignment->store();

    // publish the newly created object
    eZOperationHandler::execute( 'content', 'publish', array( 'object_id' => $newObject->attribute( 'id' ),
                                                              'version'   => $curVersion ) );
    // Update "is_invisible" attribute for the newly created node.
    $newNode = $newObject->attribute( 'main_node' );
    eZContentObjectTreeNode::updateNodeVisibility( $newNode, $newParentNode );
    $db->commit();

    // Cono i le iscrizioni in preiscrizioni
    if ($http->hasPostVariable('CloneSubscription') && $http->postVariable('CloneSubscription') == 1)
    {
//        UpadPreSubscription::cloneFromCourse( $course, $newObject);
        UpadSubscription::cloneFromCourse( $course, $newObject);
    }

    //redirect
    $module->redirectTo( '/courses/list/' . $newObject->ID);
    return;
}

$Result = array();
$tpl->setVariable( "course", $course );
$Result['path'] = array(
    array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
    array( 'text' => "Nuova edizione: " . $course->attribute( 'name' ), 'url' => false ),
);
$Result['content'] = $tpl->fetch( 'design:courses/create_edition.tpl' );
