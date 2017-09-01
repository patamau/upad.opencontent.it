<?php
/** @var eZModule $module */
$module = $Params['Module'];
$tpl = eZTemplate::factory();
$http = eZHTTPTool::instance();
$userParameters = $Params['UserParameters'];
$currentId = intval( $Params['ID'] );

/*
if ( $http->hasGetVariable( 'Search' ) && !isset( $userParameters['query'] ) )
{
    $module->redirectTo( 'courses/list/(class_id)/44/(query)/' . $http->getVariable( 'Search' ) );
    return;
}
*/

if ( !isset( $userParameters['offset'] ) ) $userParameters['offset'] = 0;
if ( !isset( $userParameters['query'] ) ) $userParameters['query'] = '';

$tpl->setVariable( "view_parameters", $userParameters );

$current = $currentId > 0 ? eZContentObject::fetch( $currentId ) : false;


$Result = array();
if ( $current instanceof eZContentObject && $current->attribute( 'class_identifier' ) == 'corso' )
{

    /* Iscrizione */
    if ( $http->hasPostVariable( 'Subscribe' ) )
    {
        eZContentBrowse::browse( array( 'action_name' => 'AddUserToCourse',
                                        'from_page' => '/courses/list/' . $currentId,
                                        'class_array' => array( 'user' ),
                                        'start_node' => eZINI::instance()->variable( "UserSettings", "DefaultUserPlacement" ),
                                        'cancel_page' => '/courses/list/' . $currentId ),
                                $module );
        return;
    }

    if ( $http->hasPostVariable( 'BrowseActionName' )
         && $http->postVariable( 'BrowseActionName' ) == 'AddUserToCourse'
         && $http->hasPostVariable( 'SelectButton' ) )
    {
        $selectedNodeIDArray = $http->postVariable( 'SelectedNodeIDArray' );
        $userObject = eZContentObject::fetchByNodeID( $selectedNodeIDArray[0] );
        if ( $userObject instanceof eZContentObject )
        {
            $user = eZUser::fetch( $userObject->attribute( 'id' ) );
            if ( $user instanceof eZUser )
            {
                UpadSubscription::instance( $currentId, $user->id() );
                $module->redirectTo( '/courses/list/' . $currentId );
                return;
            }
        }
    }

    /* Crea utene ed iscrivi */
    if ($http->hasPostVariable( 'CreateAndSubscribe' ))
    {
        $http->setSessionVariable('TargetCourse', $currentId);
        $module->redirectTo('add/new/user/?parent=12');
    }

    /* Annulla iscrizione */
    if ( $http->hasPostVariable( 'Unsubscribe' ) )
    {
        $subscriptionID = $http->postVariable( 'SubscriptionID' );
        $object = eZContentObject::fetch( $subscriptionID );

        if ( $object->attribute( 'class_identifier' ) == 'subscription')
        {
            $datamap = $object->dataMap();
            $datamap['annullata']->fromString( '1' );
            $datamap['annullata']->store();
            $module->redirectTo( '/courses/list/' . $currentId );
            return;
        }
    }

    /* Ripristina iscrizione */
    if ( $http->hasPostVariable( 'RestoreSubscription' ) )
    {
        $subscriptionID = $http->postVariable( 'SubscriptionID' );
        $object = eZContentObject::fetch( $subscriptionID );

        if ( $object->attribute( 'class_identifier' ) == 'subscription')
        {
            $datamap = $object->dataMap();
            $datamap['annullata']->fromString( '0' );
            $datamap['annullata']->store();
            $module->redirectTo( '/courses/list/' . $currentId );
            return;
        }
    }

    /* Preiscrizione */
    if ( $http->hasPostVariable( 'Presubscribe' ) )
    {
        eZContentBrowse::browse( array( 'action_name' => 'PresubscribeUserToCourse',
            'from_page' => '/courses/list/' . $currentId,
            'class_array' => array( 'user' ),
            'start_node' => eZINI::instance()->variable( "UserSettings", "DefaultUserPlacement" ),
            'cancel_page' => '/courses/list/' . $currentId ),
            $module );
        return;
    }

    if ( $http->hasPostVariable( 'BrowseActionName' )
        && $http->postVariable( 'BrowseActionName' ) == 'PresubscribeUserToCourse'
        && $http->hasPostVariable( 'SelectButton' ) )
    {
        $selectedNodeIDArray = $http->postVariable( 'SelectedNodeIDArray' );
        $userObject = eZContentObject::fetchByNodeID( $selectedNodeIDArray[0] );
        if ( $userObject instanceof eZContentObject )
        {
            $user = eZUser::fetch( $userObject->attribute( 'id' ) );
            if ( $user instanceof eZUser )
            {
                UpadPreSubscription::instance( $currentId, $user->id() );
                $module->redirectTo( '/courses/list/' . $currentId );
                return;
            }
        }
    }

    if ( $http->hasPostVariable( 'ConfirmPreSubscription' ) )
    {
        if ( $http->hasPostVariable( 'PreSubscriptionID' ) )
        {
            UpadPreSubscription::confirm( $http->postVariable('PreSubscriptionID') );
        }
    }

    $tpl->setVariable( "course", $current );
    $Result['path'] = array(
        array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
        array( 'text' => $current->attribute( 'name' ), 'url' => false ),
    );
    $Result['content'] = $tpl->fetch( 'design:courses/single.tpl' );
}
else
{
    $Result['path'] = array( array( 'text' => "Gestione Corsi", 'url' => false ) );
    $Result['content'] = $tpl->fetch( 'design:cards/list.tpl' );
}
