<?php

$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] = array( 'script' => 'extension/ocbootstrap/autoloads/ezkeywordlist.php',
                                    'class' => 'eZKeywordList',
                                    'operator_names' => array( 'ezkeywordlist' ) );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ocbootstrap/autoloads/ezarchive.php',
                                    'class' => 'eZArchive',
                                    'operator_names' => array( 'ezarchive' ) );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ocbootstrap/autoloads/eztagcloud.php',
                                    'class' => 'eZTagCloud',
                                    'operator_names' => array( 'eztagcloud' ) );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ocbootstrap/autoloads/ezpagedata.php',
                                    'class' => 'eZPageData',
                                    'operator_names' => array( 'ezpagedata', 'ezpagedata_set', 'ezpagedata_append' ) );

?>
