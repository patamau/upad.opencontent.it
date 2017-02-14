<?php


$Module = array( 'name' => 'OpenTeam Add object',
                 'variable_params' => true );

$ViewList = array();

$ViewList['new'] = array( 'functions' => array( 'add' ),
                           'script' => 'new.php',
                           'params' => array( 'Class' ),
                           'unordered_params' => array() );

$FunctionList['add'] = array( 'Class' => array( 'name'=> 'Class',
                                                'values'=> array(),
                                                'path' => 'classes/',
                                                'file' => 'ezcontentclass.php',
                                                'class' => 'eZContentClass',
                                                'function' => 'fetchList',
                                                'parameter' => array( 0, false, false, array( 'name' => 'asc' ) ) ) );



?>
