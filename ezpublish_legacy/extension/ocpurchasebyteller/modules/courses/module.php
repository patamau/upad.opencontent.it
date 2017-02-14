<?php
$Module = array( "name" => "Upad Courses Dahsboard",
                 "variable_params" => true );

$ViewList = array();

$ViewList["list"] = array(
    "functions" => array( 'manage' ),
    "script" => "list.php",
    "unordered_params" => array( "offset" => "Offset" ),
    "params" => array( 'ID' )
);

$ViewList["archive"] = array(
    "functions" => array( 'manage' ),
    "script" => "archive.php",
    "unordered_params" => array( "offset" => "Offset" ),
    "params" => array( 'ID' )
);

$ViewList["make_payment"] = array(
    "functions" => array( 'manage' ),
    "script" => "make_payment.php",
    "unordered_params" => array(),
    "params" => array( 'CourseID', 'UserID' )
);

$ViewList["add_subscription"] = array(
    "functions" => array( 'manage' ),
    "script" => "add_subscription.php",
    "unordered_params" => array(),
    "params" => array( 'CourseID' )
);

$ViewList["create_edition"] = array(
    "functions" => array( 'manage' ),
    "script" => "create_edition.php",
    "unordered_params" => array(),
    "params" => array( 'CourseID' )
);

$FunctionList = array();
$FunctionList['manage'] = array();
?>
