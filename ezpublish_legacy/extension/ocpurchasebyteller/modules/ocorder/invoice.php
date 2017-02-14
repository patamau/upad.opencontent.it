<?php

$module = $Params['Module'];
$ini = eZINI::instance();
$http = eZHTTPTool::instance();
$user = eZUser::currentUser();
$access = false;
$OrderID = $Params['OrderID'];
$includePackingSlip = $Params['includePackingSlip'] == 1 ? true : false;

$order = eZOrder::fetch( $OrderID );
if ( $order instanceof eZOrder )
{
    
    $accessToAdministrate = $user->hasAccessTo( 'shop', 'administrate' );
    $accessToAdministrateWord = $accessToAdministrate['accessWord'];
    
    $accessToBuy = $user->hasAccessTo( 'shop', 'buy' );
    $accessToBuyWord = $accessToBuy['accessWord'];
    
    $error = false;
    
    if ( $accessToAdministrateWord != 'no' )
    {
        $access = true;
    }
    elseif ( $accessToBuyWord != 'no' )
    {
        if ( $user->id() == $ini->variable( 'UserSettings', 'AnonymousUserID' ) )
        {
            if ( $OrderID != $http->sessionVariable( 'UserOrderID' ) )
            {
                $access = false;
            }
            else
            {
                $access = true;
            }
        }
        else
        {
            if ( $order->attribute( 'user_id' ) == $user->id() )
            {
                $access = true;
            }
            else
            {
                $access = false;
            }
        }
    }
    if ( !$access )
    {
        $error = true;
    }
    
    if ( !in_array( $order->attribute( 'status_id' ), array( 3, 1000, 1002 ) ) )
    {
        $error = true;
    }
}
else
{
    $error = "Ordine $OrderID non trovato";
}

if ( !$error )
{
    try
    {
        $invoiceHelper = new UpadInvoiceHelper( $order );
        $invoiceHelper->increaseDownloadCount();
    }
    catch( Exception $e )
    {        
        $error = $e->getMessage();
    }
}

if ( $error )
{
    $tpl = eZTemplate::factory();
    $tpl->setVariable( "error", $error );
    $Result['content'] = $tpl->fetch( "design:ocorder/order_invoices_error.tpl" );
    $Result['path'] = array();
}
else
{
    $tpl = eZTemplate::factory();
    $tpl->setVariable( "helper", $invoiceHelper );
    $Result['content'] = $tpl->fetch( "design:ocorder/order_invoices.tpl" );
    $Result['path'] = array();
}


?>
