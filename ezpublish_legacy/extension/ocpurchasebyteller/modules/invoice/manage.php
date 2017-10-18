<?php

$module = $Params['Module'];
$http   = eZHTTPTool::instance();
$tpl    = eZTemplate::factory();

$action   = $http->variable( 'action', 'view' );


switch ($action) {

    case 'search':
        $ente     = $http->variable( 'ente', false );
        $corso    = $http->variable( 'corso', false );
        $da       = $http->variable( 'da', false );
        $a        = $http->variable( 'a', false );

        $conditions = array();
        if ($ente && $ente != 'all') {
            $conditions ['ente_id']= $ente;
        }

        if (!$a) {
            $conditions ['date'] = array();
            $conditions ['date'][]= 'range';
            $conditions ['date'][]= array(strtotime($da . ' 00:00'), strtotime($da . ' 23:59'));
        } else {
            $conditions ['date'] = array();
            $conditions ['date'][]= 'range';
            $conditions ['date'][]= array(strtotime($da . ' 00:00'), strtotime($a . ' 23:59'));
        }


        $invoices = eZUpadInvoice::fetchList($conditions);
        $tpl->setVariable( "ente", $ente );
        $tpl->setVariable( "corso", $corso );
        $tpl->setVariable( "da", $da );
        $tpl->setVariable( "a", $a );
        $tpl->setVariable( "invoices", $invoices );


        $includeClasses = array( 'ente' );
        $params = array(
            'ClassFilterType' => 'include',
            'ClassFilterArray' => $includeClasses,
            'SortBy' => array( 'name', 'asc' ),
            'LoadDataMap' => false
        );

        $enti = eZContentObjectTreeNode::subTreeByNodeID( $params, 2 );
        $tpl->setVariable( "enti", $enti );

        $Result['path'] = array( array( 'text' => "Gestione Fatture", 'url' => false ) );
        $Result['content'] = $tpl->fetch( 'design:invoices-manager/view.tpl' );

        break;

    case 'view':
    default:

        $includeClasses = array( 'ente' );
        $params = array(
            'ClassFilterType' => 'include',
            'ClassFilterArray' => $includeClasses,
            'SortBy' => array( 'name', 'asc' ),
            'LoadDataMap' => false
        );

        $enti = eZContentObjectTreeNode::subTreeByNodeID( $params, 2 );
        $tpl->setVariable( "enti", $enti );

        $Result['path'] = array( array( 'text' => "Gestione Fatture", 'url' => false ) );
        $Result['content'] = $tpl->fetch( 'design:invoices-manager/view.tpl' );

        break;
}
