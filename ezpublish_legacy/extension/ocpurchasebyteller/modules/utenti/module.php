<?php

$Module = array( "name" => "Upad Users Dahsboard",
                 "variable_params" => true );

$ViewList = array();

$ViewList["list"] = array(
    "functions" => array( 'list' ),
    "script" => "list.php",
    "unordered_params" => array( "offset" => "Offset" ),
    "params" => array( 'ID' )
);

$ViewList["export"] = array(
    "functions" => array( 'export' ),
    "script" => "export.php",
    "params" => array()
);

$FunctionList = array();
$FunctionList['list'] = array();
$FunctionList['export'] = array();


?>
