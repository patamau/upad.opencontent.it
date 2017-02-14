<?php

$module = $Params['Module'];
$http   = eZHTTPTool::instance();
$tpl    = eZTemplate::factory();

$ente   = $Params['ente'];
$mese   = $Params['mese'];
$anno   = $Params['anno'];
$stato  = $Params['stato'];

$code = explode('-', $codice);
$search_results = array();

$firstDayTime = strtotime('1-' . $mese .'-' . $anno . ' 00:00');
$lastDayTime  =  strtotime(date('t',$firstDayTime) . '-' . $mese .'-' . $anno . ' 23:59');

$firstDayTimeM1D = strtotime("-1 day", $firstDayTime);
$lastDayTimeP1D = strtotime("+1 day", $lastDayTime);
$firstDayYearTime = strtotime('01-01-' . $anno . ' 00:00');
$lastDayYearTime = strtotime('31-12-' . $anno . ' 23:59');

$fetch_parameters = array(
    'query'     => '',
    'class_id'  => array('codice_area'),
    'filter'    => array( 'submeta_ente___id____si:' . $ente),
    'limit'     => array(100),
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

/*$conditions = array();
if ($ente) {
    $conditions ['ente_id']= $ente;
}

$conditions ['date'] = array();
$conditions ['date'][]= 'range';
$conditions ['date'][]= array($firstDayTime, $lastDayTime);
$invoices = eZUpadInvoice::fetchList($conditions);

foreach ($invoices as $i)
{
    $s_fetch_parameters = array(
        'query'     => '',
        'class_id'  => array('subscription'),
        'filter'    => array( 'extra_invoice_id____si:' . $i->attribute('id')),
        'limit'     => array(1)
    );
    $result = eZFunctionHandler::execute('ezfind', 'search', $s_fetch_parameters);

    if ($result['SearchCount'] <= 0) {
        $error []= $i->attribute('id');
        //throw new Exception('No subscription for invoice ' . $i->attribute('id'));
        eZLog::write( 'No subscription for invoice ' . $i->attribute('id'), 'export_aree.log' );
        continue;
    }

    $subscription = $result['SearchResult'][0];
    $subscriptionDataMap = $subscription->ContentObject->dataMap();

    $course = eZContentObject::fetch($subscriptionDataMap['course']->toString());
    if ( $course instanceof eZContentObject )
    {

        if ( ($stato == 'active' && $course->mainNode()->attribute( 'is_hidden' )) || ($stato == 'archived' && !$course->mainNode()->attribute( 'is_hidden' )))
        {
            continue;
        }

        $courseDataMap = $course->dataMap();

        // Codice Area
        $relArea = $courseDataMap['codice_area']->content();
        $area = eZContentObject::fetch( $relArea['relation_list'][0]['contentobject_id'] );
        $areaDataMap = $area->dataMap();

        if (!isset($search_results[$area->attribute('id')]))
        {
            $search_results[$area->attribute('id')] = array(
                'id'              => $area->attribute('id'),
                'name'            => $areaDataMap['titolo']->content(),
                'codice'          => $areaDataMap['codice']->content(),
                'conto_contabile' => $areaDataMap['conto_contabile']->content(),
                'centro_costo'    => $areaDataMap['centro_costo']->content()
                //'invoices'        => $area_inv['invoices'],
                //'total_amount'    => $area_inv['total_amount']
            );
        }

        $search_results[$area->attribute('id')]['invoices'][] = array(
            'id'        => $i->attribute( 'id' ),
            'course_id' => $course->attribute( 'id' ),
            'date'      => $i->attribute( 'date' ),
            'amount'    => $i->attribute( 'total' )
        );

        if ( !isset($search_results[$area->attribute('id')]['total_amount']) )
        {
            $search_results[$area->attribute('id')]['total_amount'] = $i->attribute( 'total' );
        }
        else
        {
            $search_results[$area->attribute('id')]['total_amount'] = $search_results[$area->attribute('id')]['total_amount'] + $i->attribute( 'total' );
        }
    }
}*/

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

$tpl->setVariable( "ente", $ente );
$tpl->setVariable( "mesi", $mesi );
$tpl->setVariable( "mese", $mese );
$tpl->setVariable( "anno", $anno );
$tpl->setVariable( "search_results", $search_results );

$Result['path'] = array( array( 'text' => "Report aree", 'url' => false ) );
$Result['content'] = $tpl->fetch( 'design:report-aree/print.tpl' );
