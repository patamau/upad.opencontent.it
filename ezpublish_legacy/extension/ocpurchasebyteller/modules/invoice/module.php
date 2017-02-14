<?php
$Module = array( "name" => "Upad Invoice",
                 "variable_params" => true );

$ViewList = array();

$ViewList["view"] = array(
    "functions" => array( 'view' ),
    "script" => "view.php",
    "unordered_params" => array(),
    "params" => array( 'ID' )
);

$ViewList["manage"] = array(
    "functions" => array( 'manage' ),
    "script" => "manage.php",
    "unordered_params" => array(),
    "params" => array( 'ente', 'da', 'a' )
);

$ViewList["export"] = array(
    "functions" => array( 'manage' ),
    "script" => "export.php",
    "params" => array('type', 'ente', 'da', 'a')
);

$ViewList["report_aree"] = array(
    "functions" => array( 'manage' ),
    "script" => "report_aree.php",
    "unordered_params" => array(),
    "params" => array( 'ente', 'mese', 'anno' )
);

$ViewList["report_aree_test"] = array(
    "functions" => array( 'manage' ),
    "script" => "report_aree_test.php",
    "unordered_params" => array(),
    "params" => array( 'ente', 'mese', 'anno' )
);

$ViewList["export_aree"] = array(
    "functions" => array( 'manage' ),
    "script" => "export_aree.php",
    "unordered_params" => array(),
    "params" => array( 'ente', 'mese', 'anno', 'stato' )
);

$ViewList["export_excel_aree"] = array(
    "functions" => array( 'manage' ),
    "script" => "export_excel_aree.php",
    "unordered_params" => array(),
    "params" => array( 'ente', 'da', 'a' )
);

$ViewList["test"] = array(
    "functions" => array( 'manage' ),
    "script" => "test.php",
    "unordered_params" => array(),
    "params" => array()
);

$FunctionList['view'] = array();
$FunctionList['manage'] = array();
?>
