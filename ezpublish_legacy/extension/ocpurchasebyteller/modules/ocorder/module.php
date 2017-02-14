<?php
$Module = array( "name" => "Ocorder",
                 "variable_params" => true );

$ViewList = array();

$ViewList["invoice"] = array(
    "functions" => array( 'invoice' ),
    "script" => "invoice.php",
    "default_navigation_part" => 'ezcontentnavigationpart',
    "params" => array( "OrderID", "includePackingSlip" ) );


$ViewList["list"] = array(
    "functions" => array( 'list' ),
    "script" => "list.php",
    "unordered_params" => array( "offset" => "Offset" ),
    "params" => array() );    

$FunctionList['invoice'] = array();
$FunctionList['list'] = array();
?>
