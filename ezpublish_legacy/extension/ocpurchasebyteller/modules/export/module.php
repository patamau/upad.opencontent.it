<?php
$Module = array( "name" => "Upad export features",
                 "variable_params" => true );

$ViewList = array();

$ViewList["subscriptions"] = array(
    "functions" => array( 'export' ),
    "script" => "subscriptions.php",
    "params" => array('ID', 'Type') );

$ViewList["docs"] = array(
    "functions" => array( 'export' ),
    "script" => "docs.php",
    "params" => array('Type', 'ID') );

$FunctionList['export'] = array();

?>
