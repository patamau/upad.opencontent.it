<?php
// take current object of type eZModule
$Module =& $Params['Module'];
// read parameter Ordered View
// http://.../modul1/list/ $Params['ParamOne'] / $Params['ParamTwo']
// for example .../modul1/list/view/5
$valueParamOne = $Params['ParamOne'];
$valueParamTwo = $Params['ParamTwo'];
// read parameter UnOrdered View
// http://.../modul1/list/param4/$Params['4Param']/param3/$Params['3Param']
// for example.../modul1/list/.../.../param4/141/param3/131
$valueParam3 = $Params['3Param'];
$valueParam4 = $Params['4Param'];
// show values of the View parameter
/*echo 'Example: modul1/list/'.
$valueParamOne .'/ '.
$valueParamTwo .'/param4/'.
$valueParam4 .'/ param3/'.
$valueParam3;*/

// library for template functions
//include_once( "kernel/common/template.php" );

// inicialize Templateobject
$tpl = eZTemplate::factory();
// create view array parameter to put in the template

/*$viewParameters = array( 'param_one' => $valueParamOne,
    'param_two' => $valueParamTwo,
    'unordered_param3' => $valueParam3,
    'unordered_param4' => $valueParam4 );
// transport the View parameter Array to the template
$tpl->setVariable( 'view_parameters', $viewParameters );*/
// create example Array in the template => {$data_array}


$params = array(
    'ClassFilterType' => 'include',
    'ClassFilterArray' => array( 'corso' ),
    'AttributeFilter' => array(array(
        'corso/data_inizio','>', time() ))
); // assuming that CommandLine is the identifier of your class

$nodeList =& eZContentObjectTreeNode::subTreeByNodeID( $params , 2 ); // where $parentNodeId is the root node or whatever...
$tpl->setVariable( 'corsi_attivi', $nodeList );
// use find/replace (parsing) in the template and save the result for $module_result.content

header('Content-type: application/xml');

$Result ['content'] = $tpl->fetch ( 'design:mod_xml_corsi/list.tpl' );

?>