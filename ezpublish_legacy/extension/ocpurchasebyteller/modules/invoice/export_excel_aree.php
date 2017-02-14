<?php

$module = $Params['Module'];
$http   = eZHTTPTool::instance();
$tpl    = eZTemplate::factory();

$action   = $http->variable( 'action', 'view' );

switch ($action) {

    case 'search':
        $ente           = $http->variable( 'ente', false );
        $da             = $http->variable( 'da', false );
        $a              = $http->variable( 'a', false );
        $stato          = $http->variable( 'stato', false );
        $search_results = array();

        $firstDayTime = strtotime($da . ' 00:00');
        $lastDayTime  = strtotime($a . ' 23:59');

        $enteObject = eZContentObject::fetch($ente);
        $enteDataMap = $enteObject->dataMap();

        $aree = array();
        $fetch_parameters = array(
            'query'     => '',
            'class_id'  => array('codice_area'),
            'filter'    => array( 'submeta_ente___id____si:' . $ente),
            'limit'     => array(100),
            'sort_by'   => array('codice_area/titolo' => 'asc')
        );

        $result = eZFunctionHandler::execute('ezfind', 'search', $fetch_parameters);
        $report = UpadInvoiceMeta::getReportByCourseAndArea($ente, $firstDayTime, $lastDayTime);

        if ($result['SearchCount'] > 0)
        {
            foreach ($result['SearchResult'] as $ar)
            {
                if (isset($report[$ar->ContentObjectID]))
                {
                    /** @var eZContentObject $area */
                    $area = $ar->ContentObject;
                    $areaDataMap = $area->dataMap();
                    $search_results[$area->attribute('id')] = array(
                        'id'              => $area->attribute('id'),
                        'name'            => $areaDataMap['titolo']->content(),
                        'codice'          => $areaDataMap['codice']->content(),
                        'conto_contabile' => $areaDataMap['conto_contabile']->content(),
                        'centro_costo'    => $areaDataMap['centro_costo']->content(),
                        //'invoices'        => $area_inv['invoices'],
                        'total_amount'    => 0
                    );

                    foreach ($report[$ar->ContentObjectID] as $k => $v)
                    {
                        /** @var eZContentObject $course */
                        $course = eZContentObject::fetch( $k );
                        if ( $course instanceof eZContentObject )
                        {
                            // Cerco le iscrizioni
                            $includeClasses = array( 'subscription' );
                            $attributefilter = array();
                            $attributefilter[]= 'and';
                            $attributefilter[]= array('subscription/course', '=', $course->attribute('id'));
                            $attributefilter[]= array('subscription/annullata', '=', false);
                            $params = array(
                                'ClassFilterType' => 'include',
                                'ClassFilterArray' => $includeClasses,
                                'AttributeFilter' => $attributefilter
                            );
                            $subscriptionsCount = eZContentObjectTreeNode::subTreeCountByNodeID( $params, 1 );

                            $courseDataMap = $course->dataMap();
                            $search_results[$area->attribute('id')]['courses'][$course->attribute('id')] = array(
                                'id' => $course->attribute('id'),
                                'name' => $course->Name,
                                'data_inizio' => strftime('%d/%m/%Y', $courseDataMap['data_inizio']->toString()),
                                'data_fine' => strftime('%d/%m/%Y', $courseDataMap['data_fine']->toString()),
                                'anno' => $courseDataMap['anno']->toString(),
                                'codice' => $courseDataMap['codice']->toString(),
                                'edizione' => $courseDataMap['edizione']->toString(),
                                'numero_lezioni' => $courseDataMap['numero_lezioni']->toString(),
                                'docente' => $courseDataMap['docente']->toString(),
                                'costo_docente' => $courseDataMap['costo_docente']->toString(),
                                'price' => $courseDataMap['price']->content()->Price,
                                'subscriptions' => $subscriptionsCount,
                                'total_amount' => $v
                            );

                            //$search_results[$area->attribute('id')]['courses'][$course->attribute( 'id' )]['total_amount'] += $i->attribute( 'total' );
                            $search_results[$area->attribute('id')]['total_amount'] += $v;
                        }
                    }

                }
            }
        }

        /*
        $conditions = array();
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
                eZLog::write( 'No subscription for invoice ' . $i->attribute('id'), 'export_excell_aree.log' );
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

                if (!isset($search_results[$area->attribute('id')]['courses'][$course->attribute( 'id' )])) {
                    $search_results[$area->attribute('id')]['courses'][$course->attribute('id')] = array(
                        'id' => $course->attribute('id'),
                        'name' => $course->Name,
                        'data_inizio' => strftime('%d/%m/%Y', $courseDataMap['data_inizio']->toString()),
                        'data_fine' => strftime('%d/%m/%Y', $courseDataMap['data_fine']->toString()),
                        'anno' => $courseDataMap['anno']->toString(),
                        'codice' => $courseDataMap['codice']->toString(),
                        'edizione' => $courseDataMap['edizione']->toString(),
                        'numero_lezioni' => $courseDataMap['numero_lezioni']->toString(),
                        'docente' => $courseDataMap['docente']->toString(),
                        'costo_docente' => $courseDataMap['costo_docente']->toString(),
                        'price' => $courseDataMap['price']->content()->Price
                    );
                }

                $search_results[$area->attribute('id')]['courses'][$course->attribute( 'id' )]['invoices'][] = array(
                    'id'        => $i->attribute( 'id' ),
                    'course_id' => $course->attribute( 'id' ),
                    'date'      => $i->attribute( 'date' ),
                    'amount'    => $i->attribute( 'total' )
                );

                $search_results[$area->attribute('id')]['courses'][$course->attribute( 'id' )]['total_amount'] += $i->attribute( 'total' );
                $search_results[$area->attribute('id')]['total_amount'] += $i->attribute( 'total' );
                //$area_inv['total_amount'] += $invoice->Total;

//                if ( !isset($search_results[$area->attribute('id')]['total_amount']) )
//                {
//                    $search_results[$area->attribute('id')]['total_amount'] = $i->attribute( 'total' );
//                }
//                else
//                {
//                    $search_results[$area->attribute('id')]['total_amount'] += $i->attribute( 'total' );
//                }
            }
        }*/

        $data = array();
        $amonutRows = array();
        $data []= array(
            'Area',
            'Titolo corso',
            'Edizione dal',
            'Edizione al',
            'Numero lezioni',
            'Prezzo',
            'Nr Partecipanti',
            'Entrate',
            '    ',
            'Incarico',
            'Docente',
            'Codice corso'
        );

        $locale = eZLocale::instance();

        $count = 1;
        foreach ($search_results as $s)
        {
            foreach ($s['courses'] as $c)
            {
                /*
                $price         = new eZCurrency($c['price']);
                $courseAmount  = new eZCurrency($c['total_amount']);
                $docenteAmount = new eZCurrency($c['costo_docente']);
                */
                $price         = number_format($c['price'], 2,'.','');//$locale->formatNumber($c['price']);
                $courseAmount  = number_format($c['total_amount'], 2,'.','');//$locale->formatNumber($c['total_amount']);
                $docenteAmount = number_format($c['costo_docente'], 2,'.','');//$locale->formatNumber($c['costo_docente']);

                //{$codice_area.data_map.codice.content}-{$ente.data_map.codice.content}-{$course.data_map.anno.content}-{$course.data_map.codice.content}-{$course.data_map.edizione.content}

                $data []= array(
                    $s['name'], $c['name'], $c['data_inizio'], $c['data_fine'], $c['numero_lezioni'], $price,  $c['subscriptions'],
                    $courseAmount, '', $docenteAmount, $c['docente'], $s['codice'] . '-' . $enteDataMap['codice']->toString() . '-' . $c['anno'] . '-' . $c['codice'] . '-' . $c['edizione']
                );
                $count ++;
            }

            /*
            $totalAmount        = new eZCurrency($s['total_amount']);
            $docenteTotalAmount = new eZCurrency($s['costo_docente']);
            */
            $totalAmount        = number_format($s['total_amount'], 2,'.','');//$locale->formatNumber($s['total_amount']);
            $docenteTotalAmount = number_format($s['costo_docente'], 2,'.','');//$locale->formatNumber($s['costo_docente']);

            $data []= array(
                strtoupper('Totale ' . $s['name']), '', '', '', '', '', '',
                $totalAmount, '',  $docenteTotalAmount, '', ''
            );
            $count ++;
            $amonutRows []= $count;
        }

        $objPHPExcel = new PHPExcel();

        $objPHPExcel->getActiveSheet()->getStyle('F')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_NUMBER_00);
        $objPHPExcel->getActiveSheet()->getStyle('H')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_NUMBER_00);
        $objPHPExcel->getActiveSheet()->getStyle('J')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_NUMBER_00);

        $objPHPExcel->getProperties()->setCreator('upad.it')
            ->setLastModifiedBy('upad.it')
            ->setTitle('PHPExcel Test Document')
            ->setSubject('PHPExcel Test Document')
            ->setDescription('Test document for PHPExcel, generated using PHP classes.');

        $objPHPExcel->getActiveSheet()->fromArray($data);


        $headerStyle = array(
            'font'  => array(
                'bold'  => true,
                'color' => array('rgb' => '000000')
                //'size'  => 15,
                //'name'  => 'Verdana'
            ),
            'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_SOLID,
                'color' => array('rgb' => 'fffe00')
            )
        );

        $amountStyle = array(
            'font'  => array(
                'bold'  => true,
                'color' => array('rgb' => 'ff0000')
                //'size'  => 15,
                //'name'  => 'Verdana'
            ),
            'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_SOLID,
                'color' => array('rgb' => 'eaf1d7')
            )
        );

        $borderStyle = array(
            'borders' => array(
                'allborders' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN
                )
            )
        );

        for ($i = 1; $i <= $count; $i++)
        {
            $objPHPExcel->getActiveSheet()->getStyle("A$i:L$i")->applyFromArray($borderStyle);
        }

        $objPHPExcel->getActiveSheet()->getStyle("A1:L1")->applyFromArray($headerStyle);
        foreach ($amonutRows as $am)
        {
            $objPHPExcel->getActiveSheet()->getStyle("A$am:L$am")->applyFromArray($amountStyle);
        }
        foreach(range('A','L') as $columnID) {
            $objPHPExcel->getActiveSheet()->getColumnDimension($columnID)->setAutoSize(true);
        }

        $filename = $enteObject->Name . '_' . $da . '_' . $a . '.xlsx';

        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="' . $filename . '"');
        header('Cache-Control: max-age=0');
        // If you're serving to IE 9, then the following may be needed
        header('Cache-Control: max-age=1');
        // If you're serving to IE over SSL, then the following may be needed
        header ('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
        header ('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT'); // always modified
        header ('Cache-Control: cache, must-revalidate'); // HTTP/1.1
        header ('Pragma: public'); // HTTP/1.0
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        eZExecution::cleanExit();

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

        $stati = array(
            'all'      => 'Tutti',
            'active'   => 'Attivi',
            'archived' => 'Archiviati'
        );

        $tpl->setVariable( "enti", $enti );
        $tpl->setVariable( "stati", $stati );
        
        $Result['path'] = array( array( 'text' => "Report excel centro di costo", 'url' => false ) );
        $Result['content'] = $tpl->fetch( 'design:report-aree/view_excel.tpl' );
        break;
}
