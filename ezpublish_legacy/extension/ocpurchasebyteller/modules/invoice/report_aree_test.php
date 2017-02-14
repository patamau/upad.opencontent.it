<?php

$module = $Params['Module'];
$http   = eZHTTPTool::instance();
$tpl    = eZTemplate::factory();

$action   = $http->variable( 'action', 'view' );


switch ($action) {

    case 'search':
        $ente   = $http->variable( 'ente', false );
        $mese   = $http->variable( 'mese', false );
        $anno   = $http->variable( 'anno', false );
        $stato  = $http->variable( 'stato', false );

        $search_results = array();

        $firstDayTime    = strtotime('01-' . $mese .'-' . $anno . ' 00:00');
        $lastDayTime     =  strtotime(date('t',$firstDayTime) . '-' . $mese .'-' . $anno . ' 23:59');

        $firstDayTimeM1D = strtotime("-1 day", $firstDayTime);
        $lastDayTimeP1D = strtotime("+1 day", $lastDayTime);
        $firstDayYearTime = strtotime('01-01-' . $anno . ' 00:00');
        $lastDayYearTime = strtotime('31-12-' . $anno . ' 23:59');

        $fetch_parameters = array(
            'query'     => '',
            'class_id'  => array('codice_area'),
            'filter'    => array( 'submeta_ente___id____si:' . $ente),
            'limit'     => array(50),
            'sort_by'   => array('codice_area/titolo' => 'asc')
        );
        $result = eZFunctionHandler::execute('ezfind', 'search', $fetch_parameters);
        $report = UpadInvoiceMeta::getReport($ente, $firstDayTime, $lastDayTime);

        if ($result['SearchCount'] > 0)
        {
            foreach ($result['SearchResult'] as $key => $value)
            {
                if (isset($report[$value->ContentObjectID]))
                {
                    /** @var eZContentObject $area */
                    $area = $value->ContentObject;
                    $areaDataMap = $area->dataMap();
                    $search_results[$area->attribute('id')] = array(
                        'id'              => $area->attribute('id'),
                        'name'            => $areaDataMap['titolo']->content(),
                        'codice'          => $areaDataMap['codice']->content(),
                        'conto_contabile' => $areaDataMap['conto_contabile']->content(),
                        'centro_costo'    => $areaDataMap['centro_costo']->content(),
                        //'invoices'        => $area_inv['invoices'],
                        'total_amount'    => $report[$area->attribute('id')]
                    );
                }
            }
        }

        // Template
        $includeClasses = array( 'ente' );
        $params = array(
            'ClassFilterType' => 'include',
            'ClassFilterArray' => $includeClasses,
            'SortBy' => array( 'name', 'asc' ),
            'LoadDataMap' => false
        );

        $enti = eZContentObjectTreeNode::subTreeByNodeID( $params, 2 );

        $mesi = array(
           '1'  => 'Gennaio',
           '2'  => 'Febbraio',
           '3'  => 'Marzo',
           '4'  => 'Aprile',
           '5'  => 'Maggio',
           '6'  => 'Giugno',
           '7'  => 'Luglio',
           '8'  => 'Agosto',
           '9'  => 'Settembre',
           '10' => 'Ottobre',
           '11' => 'Novembre',
           '12' => 'Dicembre'
        );

        $stati = array(
            'all'      => 'Tutti',
            'active'   => 'Attivi',
            'archived' => 'Archiviati'
        );

        $anni = array();
        for ($i = 2014; $i <= date('Y'); $i++) {
            $anni []= $i;
        }

        $tpl->setVariable( "ente", $ente );
        $tpl->setVariable( "mese", $mese );
        $tpl->setVariable( "anno", $anno );
        $tpl->setVariable( "stato", $stato );
        $tpl->setVariable( "search_results", $search_results );

        $tpl->setVariable( "enti", $enti );
        $tpl->setVariable( "mesi", $mesi );
        $tpl->setVariable( "anni", $anni );
        $tpl->setVariable( "stati", $stati );

        $Result['path'] = array( array( 'text' => "Report aree", 'url' => false ) );
        $Result['content'] = $tpl->fetch( 'design:report-aree/test.tpl' );

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

        $mesi = array(
           '1'  => 'Gennaio',
           '2'  => 'Febbraio',
           '3'  => 'Marzo',
           '4'  => 'Aprile',
           '5'  => 'Maggio',
           '6'  => 'Giugno',
           '7'  => 'Luglio',
           '8'  => 'Agosto',
           '9'  => 'Settembre',
           '10' => 'Ottobre',
           '11' => 'Novembre',
           '12' => 'Dicembre'
        );

        $stati = array(
            'all'      => 'Tutti',
            'active'   => 'Attivi',
            'archived' => 'Archiviati'
        );

        $anni = array();
        for ($i = 2014; $i <= date('Y'); $i++) {
            $anni []= $i;
        }

        $tpl->setVariable( "enti", $enti );
        $tpl->setVariable( "mesi", $mesi );
        $tpl->setVariable( "anni", $anni );
        $tpl->setVariable( "stati", $stati );
        $Result['path'] = array( array( 'text' => "Report aree", 'url' => false ) );
        $Result['content'] = $tpl->fetch( 'design:report-aree/test.tpl' );
        break;
}
