<?php
    // Introduction in the development of eZ Publish extensions
    $Module = array( 'name' => 'Modulo culturabz' );
    $ViewList = array();
    // new View list with 2 fixed parameters and
    // 2 parameters in order
    // http://.../modul1/list/ $Params['ParamOne'] /
    // $Params['ParamTwo']/ param4/$Params['4Param'] /param3/$Params['3Param']
    $ViewList['list'] = array( 'script' => 'list.php',
    'functions' => array( 'read' )/*,
    'params' => array('ParamOne', 'ParamTwo'),
    'unordered_params' => array('param3' => '3Param',
    'param4' => '4Param') */);
    // The entries in the user rights
    // are used in the View definition, to assign rights to own View functions
    // in the user roles
    $FunctionList = array();
    $FunctionList['read'] = array();
?>