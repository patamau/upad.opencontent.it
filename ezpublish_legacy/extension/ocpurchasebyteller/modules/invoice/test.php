<?php
/*
$module = $Params['Module'];
$http   = eZHTTPTool::instance();
$tpl    = eZTemplate::factory();

$sourceCourse = eZContentObject::fetch(14477);
$targetCourse = eZContentObject::fetch(14740);


UpadPreSubscription::cloneFromCourse($sourceCourse, $targetCourse);*/


/*$c_fetch_parameters = array(
    'query'     => '',
    'class_id'  => array('corso'),
    'filter'    => array( 'submeta_codice_area___id____si:15168'),
    'limit'     => array(1),
    'sort_by'   => array('corso/title' => 'asc')
);

$c_fetch_parameters['ignore_visibility'] = true;

$filter = array();
$filter []= 'and';
$filter []= array( 'submeta_codice_area___id____si:15168');
$filter []= array(
    'or',
    'meta_is_hidden_b:true',
    'meta_is_invisible_b:true'
);
$c_fetch_parameters['filter'] = $filter;

echo '<pre>';
print_r($c_fetch_parameters);

$c_result = eZFunctionHandler::execute('ezfind', 'search', $c_fetch_parameters);


echo '<pre>';
print_r($c_result);*/


// Test index plugin

UpadInvoiceMeta::getReport();
exit;


$s_fetch_parameters = array(
    'query'     => '',
    'class_id'  => array('subscription'),
    'filter'    => array( 'extra_invoice_id____si:2973'),
    'limit'     => array(1)
);
$result = eZFunctionHandler::execute('ezfind', 'search', $s_fetch_parameters);
$subscription = $result['SearchResult'][0];
$subscriptionDataMap = $subscription->ContentObject->dataMap();

echo '<pre>';
print_r($result);
print_r($subscriptionDataMap);

exit;