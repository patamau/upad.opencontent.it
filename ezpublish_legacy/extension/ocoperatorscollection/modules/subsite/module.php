<?php

$Module = array( 'name' => 'Redirect to subsite',
                 'variable_params' => true );

$ViewList = array();

$ViewList['subsite'] = array(
    'script' => 'view.php',
    'params' => array( 'SubsiteID', 'NodeID' ) );


?>
