
<?php

$module = $Params['Module'];
$http   = eZHTTPTool::instance();
$tpl    = eZTemplate::factory();

$action = $http->variable( 'action', 'view' );
$ente   = $http->variable( 'ente', false );
$da     = $http->variable( 'da', strftime('%d-%m-%Y') );
$a      = $http->variable( 'a', strftime('%d-%m-%Y', strtotime("+1 week")) );

$includeClasses = array( 'ente' );
$params = array(
    'ClassFilterType' => 'include',
    'ClassFilterArray' => $includeClasses,
    'SortBy' => array( 'name', 'asc' ),
    'LoadDataMap' => false
);
$enti = eZContentObjectTreeNode::subTreeByNodeID( $params, 2 );

$tpl->setVariable( "enti", $enti );
$tpl->setVariable( "da", $da );
$tpl->setVariable( "a", $a );


switch ($action) {
    case 'export':

        $limit = 50;
        $firstDayTime = strtotime($da . ' 00:00');
        $lastDayTime  =  strtotime($a . ' 23:59');

        // Cerco le iscrizioni
        $includeClasses = array( 'subscription' );
        $attributefilter = array();
        $attributefilter[]= 'and';
        $attributefilter[]= array('published', '>=', $firstDayTime);
        $attributefilter[]= array('published', '<=', $lastDayTime);
        $attributefilter[]= array('subscription/annullata', '=', false);

        $params = array(
            'ClassFilterType' => 'include',
            'ClassFilterArray' => $includeClasses,
            'AttributeFilter' => $attributefilter,
            'SortBy' => array( 'published', 'asc' ),
            'LoadDataMap' => false
        );

        $count  = eZContentObjectTreeNode::subTreeCountByNodeID( $params, 1 );

        $data []= array(
            'Id',
            'Nome',
        	'Cognome',
        	'Tessera',
            'Indirizzo',
            'Cap',
            'Città',
            'Nazione',
            'Data Iscrizione',
            'Telefono',
            'Email',
            'Ente'
        );

        if ( $count > 0)
        {
            if ($count > 500)
            {
                $tpl->setVariable( "too_many", true );
                $Result['path'] = array(
                    array( 'text' => "Gestione Utenti", 'url' => 'utenti/list' ),
                    array( 'text' => 'Esportazione utenti', 'url' => false )
                );
                $Result['content'] = $tpl->fetch( 'design:utenti/export.tpl' );
                return;
            }


            $offset = 0;
            $params['Limit'] = $limit;

            while( $offset <= $count )
            {
                $params[ 'Offset' ] = $offset;
                $subscriptions = eZContentObjectTreeNode::subTreeByNodeID( $params, 1 );

                foreach ($subscriptions as $s)
                {
                    $sDataMap = $s->dataMap();
                    /** @var eZContentObject $user */
                    $user = $sDataMap['user']->content();
                    /** @var eZContentObject $course */
                    $course = $sDataMap['course']->content();
                    if (!array_key_exists($user->ID, $data))
                    {
                        $uDataMap = $user->dataMap();
                        $cDataMap = $course->dataMap();
                        $e = eZContentObject::fetch($cDataMap['ente']->toString());

                        $temp = array(
                            'id'  => $user->attribute('id'),
                            'name' => $uDataMap['first_name']->toString(),
                        	'lastname' => $uDataMap['last_name']->toString(),
                        	'card' => $uDataMap['card']->toString(),
                            'address' => $uDataMap['indirizzo_residenza']->toString(),
                            'cap'    => $uDataMap['cap_residenza']->toString(),
                            'city'=> $uDataMap['luogo_residenza']->toString(),
                            'country' => $uDataMap['stato_nascita']->toString(),
                            'published' => strftime('%d/%m/%Y', $s->object()->Published),
                            'phone' => $uDataMap['telefono']->toString(),
                            'email' => $uDataMap['user_account']->content()->Email,
                            'ente'  => $e->Name

                        );

                        if ($cDataMap['ente']->toString() == $ente || $ente == 'all') {
                            $data[] = $temp;
                        }
                    }

                    $ids = array($user->attribute('id'), $course->attribute('id'), $e->attribute('id'));
                    unset($sDataMap, $course, $user, $e, $uDataMap, $cDataMap);
                    //eZContentObject::clearCache($ids);
                }
                // Increment the offset until we've gone through every user
                $offset += $limit;
            }


            $filename = 'utenti_iscritti_' . $da . '_' . $a . '.csv';
            header('X-Powered-By: eZ Publish');
            header('Content-Description: File Transfer');
            header('Content-Type: text/csv; charset=utf-8');
            header("Content-Disposition: attachment; filename=$filename");
            header("Pragma: no-cache");
            header("Expires: 0");

            $output = fopen('php://output', 'w');
            foreach ($data as $d)
            {
                fputcsv($output, $d, ';', '"');
                flush();
            }


            /*$objPHPExcel = new PHPExcel();
            $objPHPExcel->getProperties()->setCreator('upad.it')
                ->setLastModifiedBy('upad.it')
                ->setTitle('Export Utenti')
                ->setSubject('Export Utenti')
                ->setDescription('Utenti iscritti ai corsi dal ' . $da);

            $objPHPExcel->getActiveSheet()->fromArray($data);

            $filename = 'utenti_iscritti_' . $da . '_' . $a . '.xlsx';

            // Redirect output to a client’s web browser (Excel2007)
            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8');
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
            $objWriter->save('php://output');*/
            eZExecution::cleanExit();

        }
        break;

    case 'view':
    default:
        $Result['path'] = array(
            array( 'text' => "Gestione Utenti", 'url' => 'utenti/list' ),
            array( 'text' => 'Esportazione utenti', 'url' => false )
        );
        $Result['content'] = $tpl->fetch( 'design:utenti/export.tpl' );
        break;
}

