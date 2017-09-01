<?php
$Module = array( "name" => "Upad Cards Dahsboard",
                 "variable_params" => true );

$ViewList = array();

$ViewList["list"] = array(
    "functions" => array( 'manage' ),
    "script" => "list.php",
    "unordered_params" => array( "offset" => "Offset" ),
    "params" => array( 'ID' )
);

$FunctionList = array();
$FunctionList['manage'] = array();
?>
