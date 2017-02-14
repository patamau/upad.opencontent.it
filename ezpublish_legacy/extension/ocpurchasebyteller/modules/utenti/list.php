<?php

$module = $Params['Module'];
$tpl = eZTemplate::factory();
$http = eZHTTPTool::instance();
$userParameters = $Params['UserParameters'];
$currentId = intval( $Params['ID'] );

if ( $http->hasGetVariable( 'Search' ) && !isset( $userParameters['query'] ) )
{
    $module->redirectTo( 'utenti/list/(class_id)/4/(query)/' . $http->getVariable( 'Search' ) );
    return;
}

if ( !isset( $userParameters['offset'] ) ) $userParameters['offset'] = 0;
if ( !isset( $userParameters['query'] ) ) $userParameters['query'] = '';

$tpl->setVariable( "view_parameters", $userParameters );

$current = $currentId > 0 ? eZContentObject::fetch( $currentId ) : false;
$Result = array();
if ( $current instanceof eZContentObject && $current->attribute( 'class_identifier' ) == 'user' )
{
    $tpl->setVariable( "user", $current );
    $Result['path'] = array(
        array( 'text' => "Gestione Utenti", 'url' => 'utenti/list' ),
        array( 'text' => $current->attribute( 'name' ), 'url' => false ),
    );
    $Result['content'] = $tpl->fetch( 'design:utenti/single.tpl' );
}
else
{
    $Result['path'] = array(
        array( 'text' => "Gestione Utenti", 'url' => false )
    );
    $Result['content'] = $tpl->fetch( 'design:utenti/list.tpl' );
}


