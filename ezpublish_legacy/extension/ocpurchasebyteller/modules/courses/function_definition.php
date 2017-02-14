<?php

$FunctionList = array();
$FunctionList['invoice'] = array(
    'name' => 'invoice',
    'operation_types' => array( 'read' ),
    'call_method' => array(
        'class' => 'UpadFunctionCollection',
        'method' => 'fetchInvoice'
    ),
    'parameter_type' => 'standard',
    'parameters' => array( array(
        'name' => 'id',
        'type' => 'integer',
        'required' => true,
        'default' => false
    ) )
);