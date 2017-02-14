<?php

$Module = array( 'name' => 'OpenContent Shop Account' );

$ViewList["userregister"] = array(
    "functions" => array( 'buy' ),
    "script" => "userregister.php",
    'ui_context' => 'edit',
    "default_navigation_part" => 'ezshopnavigationpart',
    'single_post_actions' => array( 'StoreButton' => 'Store',
                                    'CancelButton' => 'Cancel' )
    );

$FunctionList = array();
$FunctionList['buy'] = array( );
?>
