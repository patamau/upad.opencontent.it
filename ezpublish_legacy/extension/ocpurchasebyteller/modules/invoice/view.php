<?php

$module = $Params['Module'];
$tpl = eZTemplate::factory();
$ID = intval( $Params['ID'] );

$invoice = eZUpadInvoice::fetch( $ID );
if ( !$invoice instanceof eZUpadInvoice )
{
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );
}
$invoice->increaseDownloadCount();
$tpl->setVariable( 'invoice', $invoice );

$Result = array();
$Result['path'] = array();
$Result['content'] = $tpl->fetch( 'design:invoice/invoice.tpl' );