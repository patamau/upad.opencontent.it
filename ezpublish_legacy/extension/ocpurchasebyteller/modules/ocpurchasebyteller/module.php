<?php

$Module = array( 'name' => 'ocpurchasebyteller');
$ViewList = array();

$ViewList = array();
$ViewList['form'] = array(
    'script' => 'form.php',
    'functions' => array( 'buy' ),
    "unordered_params" => array( "offset" => "Offset", 's' => 'Search' ),
    'params' => array( 'productObjectID')
);

$ViewList['assign'] = array(
    'script' => 'assign.php',
    'functions' => array( 'buy' ),
    'params' => array( 'productObjectID', 'userID')
);

$ViewList['multiadd'] = array(
    'functions' => array( 'buy' ),
    'script' => 'multiadd.php',
    'default_navigation_part' => 'ezshopnavigationpart',
    'params' => array( 'ActionAddToBasket', 'ContentNodeID', 'ContentObjectID', 'ViewMode', 'Quantity')
);

$FunctionList = array();
$FunctionList['buy'] = array();


?>
