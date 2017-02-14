#!/usr/bin/env php
<?php
/**
 *
 */

// script initializing
require_once 'autoload.php';

$cli = eZCLI::instance();
$script = eZScript::instance( array( 'description' => ( "Resetta l'ecommerce" ),
    'use-session' => false,
    'use-modules' => true,
    'use-extensions' => true ) );

$script->startup();

$options = $script->getOptions();
$script->initialize();
$script->setUseDebugAccumulators( true );


$ini = eZINI::instance();
// Get user's ID who can remove subtrees. (Admin by default with userID = 14)
$userCreatorID = $ini->variable( "UserSettings", "UserCreatorID" );
$user = eZUser::fetch( $userCreatorID );
if ( !$user )
{
    $cli->error( "Script Error!\nCannot get user object by userID = '$userCreatorID'.\n(See site.ini[UserSettings].UserCreatorID)" );
    $script->shutdown( 1 );
}
eZUser::setCurrentlyLoggedInUser( $user, $userCreatorID );



$db = eZDB::instance();
// Svuoto la tabella degli ordini e le collegate
$db->query( "TRUNCATE TABLE ezorder" );
$db->query( "TRUNCATE TABLE ezorder_item" );
$db->query( "TRUNCATE TABLE ezorder_nr_incr" );

//Svuoto la tabella del carrello
$db->query( "TRUNCATE TABLE ezbasket" );
// Svuoto la tabella dei product collection e le collegate
$db->query( "TRUNCATE TABLE ezproductcollection" );
$db->query( "TRUNCATE TABLE ezproductcollection_item" );

// Svuoto la tabella dei payment object
$db->query( "TRUNCATE TABLE ezpaymentobject" );

// Svuoto la tabella delle fatture
$db->query( "TRUNCATE TABLE upad_invoice" );


// Elimianre le iscrizioni

/*
$parentID = 2;
$limit = 5;

$params = array(
    'ClassFilterType'  => 'include',
    'ClassFilterArray' => array( 'punto' )
);

$count  = eZContentObjectTreeNode::subTreeCountByNodeID( $params, $parentID );

//$cli->output( 'Premi assegnati in data '.$date.': ' .  $count);
$offset = 0;
$i = 1;
$params['Limit'] = $limit;

while( $offset <= $count )
{
    $params[ 'Offset' ] = $offset;
    $nodes = eZContentObjectTreeNode::subTreeByNodeID( $params, $parentID );
    foreach( $nodes as $node )
    {
        $cli->output( $i . ': ' .$node->attribute( 'name' ) );
        $dataMap = $node->dataMap();
        $dataMap['oggetto']->fromString($dataMap['oggetto1']->toString());
        $dataMap['oggetto']->store();

        $i++;
    }
    // Increment the offset until we've gone through every user
    $offset += $limit;
}
*/


$script->shutdown();

?>
