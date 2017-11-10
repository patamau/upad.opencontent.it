<?php



$module = $Params['Module'];
$http   = eZHTTPTool::instance();
$tpl    = eZTemplate::factory();

$type   = $Params['type'];
$ente   = $Params['ente'];
$corso  = $Params['corso'];
$da     = $Params['da'];
$a      = $Params['a'];

$conditions = array();
$invoices = array();

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
if ($corso && $corso != 'all') {
    $invoices = eZUpadInvoice::fetchInvoicesByCourse($corso, $da, $a); 
	//$invoices = eZUpadInvoice::fetchList($conditions);
}else{
	$invoices = eZUpadInvoice::fetchList($conditions);	
}
$tpl->setVariable( "da", $da );
$tpl->setVariable( "a", $a );
$tpl->setVariable( "invoices", $invoices );
$tpl->setVariable( "corso", $corso);
$tpl->setVariable( "ente", $ente);


switch ($type) {
    case 'courses':
        break;

    case 'customers':

        $Result['path'] = array(
            array( 'text' => "Gestione Fatture", 'url' => 'invoices/list' ),
            array( 'text' => 'invoices-customers-exports', 'url' => false )
        );
        $Result['content'] = $tpl->fetch( 'design:invoices-manager/customers-export.tpl' );

        break;

    case 'print':
        eZDebug::writeWarning( "SONO NELLA PRINT", "PRINT" );
        $Result['path'] = array(
            array( 'text' => "Gestione Fatture", 'url' => 'invoices/list' ),
            array( 'text' => 'invoices-print', 'url' => false )
        );
        $Result['content'] = $tpl->fetch( 'design:invoices-manager/print.tpl' );

        break;

    default:
        break;
}

