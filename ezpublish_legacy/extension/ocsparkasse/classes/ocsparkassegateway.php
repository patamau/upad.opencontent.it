<?php
//
// Definition of eZPaypalGateway class
//
// Created on: <18-Jul-2004 14:18:58 dl>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Paypal Payment Gateway
// SOFTWARE RELEASE: 1.0
// COPYRIGHT NOTICE: Copyright (C) 1999-2006 eZ systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

/*! \file ocsparkassegateway.php
*/

/*!
  \class eZPaypalGateway ezpaypalgateway.php
  \brief The class eZPaypalGateway implements
  functions to perform redirection to the PayPal
  payment server.
*/

// include_once( 'kernel/shop/classes/ezpaymentobject.php' );
// include_once( 'kernel/shop/classes/ezredirectgateway.php' );

//__DEBUG__
// include_once( 'kernel/classes/workflowtypes/event/ezpaymentgateway/ezpaymentlogger.php' );
//___end____

define( "EZ_PAYMENT_GATEWAY_TYPE_SPARKASSE", "ocsparkasse" );

class ocSparkasseGateway extends eZPaymentGateway
{

    const GATEWAY_TYPE = "ocSparkasse";
    /*!
        Constructor.
    */
    function ocSparkasseGateway()
    {
        //__DEBUG__
            $this->logger   = eZPaymentLogger::CreateForAdd( "var/log/oCSparkasseType.log" );
            $this->logger->writeTimedString( 'oCSparkasseGateway::oCSparkasseGateway()' );
        //___end____
    }

    function _format_number( $str, $decimal_places='2', $decimal_padding="0" )
    {
        /* firstly format number and shorten any extra decimal places */
        /* Note this will round off the number pre-format $str if you dont want this fucntionality */
        $str =  number_format( $str, $decimal_places, '.', '');    // will return 12345.67
        $number = explode( '.', $str );
        $number[1] = ( isset( $number[1] ) )?$number[1]:''; // to fix the PHP Notice error if str does not contain a decimal placing.
        $decimal = str_pad( $number[1], $decimal_places, $decimal_padding );
        return (float) $number[0].$decimal;
    }

    function execute( $process, $event )
    {

        //__DEBUG__
        $this->logger->writeTimedString("execute gateway");
        //___end____

        $processParams  = $process->attribute( 'parameter_list' );
        $processID      = $process->attribute( 'id' );
        $orderID        = $processParams['order_id'];
        $order          = eZOrder::fetch( $orderID );

        //$paymentObject  = eZPaymentObject::fetchByOrderID( $orderID );
        //if ( !$paymentObject instanceof eZPaymentObject )
        //{
        //    $paymentObject  = eZPaymentObject::createNew( $processID, $orderID, 'Sparkasse' );
        //    $paymentObject->store();
        //}

        if ( $order->attribute( 'is_temporary' ) == 0 ) {
            //$paymentObject->remove();
            return eZWorkflowType::STATUS_ACCEPTED;
        } else {

            $basket = eZBasket::currentBasket();
            $ente = 0;

            // Recupero l'ente associato ai corsi
            $products = $basket->items();
            foreach ($products as $p) {
                $tempObject = $p['item_object']->ContentObject;
                if ($tempObject->attribute( 'class_identifier' ) == 'corso') {
                    $tempDatamap = $tempObject->dataMap();
                    $tempRel_ente = $tempDatamap['ente']->content();
                    //$ente = eZContentObject::fetch( $tempRel_ente['relation_list'][0]['contentobject_id'] );
                    $ente = $tempRel_ente['relation_list'][0]['contentobject_id'];
                    break;
                }
            }

            // Attivo l'ordine
            $order->activate();
            // Svuoto il carrello per la sessione corrente
            $basket = eZBasket::cleanupCurrentBasket(false);
            // Imposto lo stato dell'ordine su pending
            $order->setStatus( eZOrderStatus::PENDING );
            $order->store();

            $sparkasseINI    = eZINI::instance( 'sparkasse.ini' );
            $sparkasseServer = $sparkasseINI->variable( 'ServerSettings', 'ServerName');
            $requestURI      = $sparkasseINI->variable( 'ServerSettings', 'RequestURI');

            $muaID = $sparkasseINI->variable( 'EnteSetting', 'MuaID');
            $palladioID = $sparkasseINI->variable( 'EnteSetting', 'PalladioID');
            $upadID = $sparkasseINI->variable( 'EnteSetting', 'UpadID');

            // Recupero i dati per il webpos in base all'ente
            switch ($ente) {
                case $muaID:
                    $abi             = $sparkasseINI->variable( 'SparkasseSettings', 'AbiMua' );
                    $termID          = $sparkasseINI->variable( 'SparkasseSettings', 'TermidMua' );
                    $chiaveMD5       = $sparkasseINI->variable( 'SparkasseSettings', 'ChiaveMD5Mua' );
                    $info            = $sparkasseINI->variable( 'SparkasseSettings', 'InfoMua' );
                    break;

                case $palladioID:
                    $abi             = $sparkasseINI->variable( 'SparkasseSettings', 'AbiPalladio' );
                    $termID          = $sparkasseINI->variable( 'SparkasseSettings', 'TermidPalladio' );
                    $chiaveMD5       = $sparkasseINI->variable( 'SparkasseSettings', 'ChiaveMD5Palladio' );
                    $info            = $sparkasseINI->variable( 'SparkasseSettings', 'InfoPalladio' );
                    break;

                case $upadID:
                default:
                    $abi             = $sparkasseINI->variable( 'SparkasseSettings', 'AbiUpad' );
                    $termID          = $sparkasseINI->variable( 'SparkasseSettings', 'TermidUpad' );
                    $chiaveMD5       = $sparkasseINI->variable( 'SparkasseSettings', 'ChiaveMD5Upad' );
                    $info            = $sparkasseINI->variable( 'SparkasseSettings', 'InfoUpad' );
                    break;
            }

            $indexDir        = eZSys::indexDir();
            $localHost       = eZSys::serverURL();
            $localURI        = eZSys::serverVariable( 'REQUEST_URI' );

            $amount          = $this->_format_number($order->attribute( 'total_inc_vat' ));
            $currency        = $order->currencyCode();
            $locale          = eZLocale::instance();
            $countryCode     =  $locale->countryCode();

            $maxDescLen      = 255;
            $itemName        = urlencode( $this->createShortDescription( $order, $maxDescLen ) );

            $accountInfo     = $order->attribute( 'account_information' );
            $first_name      = $accountInfo['first_name'] ;
            $last_name       = $accountInfo['last_name'] ;
            $street          = $accountInfo['street2'] ;
            $zip             = $accountInfo['zip'] ;
            $state           = $accountInfo['state'] ;
            $place           = $accountInfo['place'] ;

            $xml  = '<?xml version="1.0" encoding="utf-8"?><WEBPOS><PAY_REQ>';
            $xml .= '<COD_ABI>'.$abi.'</COD_ABI>';
            $xml .= '<TERMINAL_ID>'.$termID.'</TERMINAL_ID>';
            $xml .= '<TRANSACTION_ID>'.$orderID.'</TRANSACTION_ID>';
            $xml .= '<AQUIRER>04</AQUIRER>';
            $xml .= '<CURRENCY>'.$currency.'</CURRENCY>';
            // TODO: In produzione passare $amount e non 001
            $xml .= '<AMOUNT>001</AMOUNT>';
            $xml .= '<DESTPAGE>'.$localHost . $indexDir . '/sparkasse/checkout/' .'</DESTPAGE>';
            $xml .= '<CLIENT_IP>'.$_SERVER['REMOTE_ADDR'].'</CLIENT_IP>';
            $xml .= '<CLIENT_DATA>'. $first_name . ' ' . $last_name .'</CLIENT_DATA>';
            $xml .= '<LANGUAGE>1</LANGUAGE>';
            $xml .= '</PAY_REQ></WEBPOS>';
            $xmlEncoded = urlencode(trim($xml));
            $vars = array(
                'xml'  => $xmlEncoded,
                'hash' => md5( $xmlEncoded.$chiaveMD5),
                'url'  => $sparkasseServer . $requestURI
            );

            //__DEBUG__
            $this->logger->writeTimedString("server         = $sparkasseServer$requestURI");
            $this->logger->writeTimedString("abi            = $abi");
            $this->logger->writeTimedString("termID         = $termID");
            $this->logger->writeTimedString("chiaveMD5      = $chiaveMD5");
            $this->logger->writeTimedString("amount         = $amount");
            $this->logger->writeTimedString("info           = $info");
            $this->logger->writeTimedString("item_name      = $itemName");
            $this->logger->writeTimedString("xml            = $xml");
            $this->logger->writeTimedString("encodedXml     = $xmlEncoded");
            $this->logger->writeTimedString("return         = $localHost"    . $indexDir . "/sparkasse/checkout/");
            //___end____

            $process->Template = array();
            $process->Template['templateName'] = 'design:sparkasse/pushpayment.tpl';
            $process->Template['path'] = array (
                                            array (
                                                'url' => false,
                                                'text' =>  'Payment Information'
                                            )
                                        );
            $process->Template['templateVars'] = array (
                'event'       => $event,
                'order'       => $order,
                'sparkasse'   => $vars
            );
            return eZWorkflowType::STATUS_FETCH_TEMPLATE_REPEAT;
        }
    }

    function needCleanup()
    {
        return true;
    }

    function cleanup( $process, $event )
    {
        return false;
    }
}

eZPaymentGatewayType::registerGateway( EZ_PAYMENT_GATEWAY_TYPE_SPARKASSE, "ocSparkasseGateway", "Carta di credito" );

?>
