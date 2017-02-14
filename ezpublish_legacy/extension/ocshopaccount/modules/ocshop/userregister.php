<?php

$http = eZHTTPTool::instance();
$module = $Params['Module'];

$tpl = eZTemplate::factory();

if ( $module->isCurrentAction( 'Cancel' ) )
{
    $module->redirectTo( '/shop/basket/' );
    return;
}

$user = eZUser::currentUser();

$firstName = '';
$lastName = '';
$email = '';
// Valori di default
$street1 = $street2 = $zip = $place = $state = $country = $comment = '';
// Inririzzo di spedizione
$sendStreet = $sendZip = $sendPlace = $sendState = $sendCountry = '';
// Partita Iva e Telefono
$vat = $tel1 = $tel2 = '';



if ( $user->isLoggedIn() )
{
    $userObject = $user->attribute( 'contentobject' );
    $userMap = $userObject->dataMap();
    $firstName = $userMap['first_name']->content();
    $lastName = $userMap['last_name']->content();
    $email = $user->attribute( 'email' );


    $street1 = $userMap['indirizzo_residenza']->content();
    $zip = $userMap['cap_residenza']->content();
    //$place = $userMap['comune_residenza']->content();
    //$state = $userMap['provincia_residenza']->content();
    //$sendStreet = $accountInfo['send_street'];
    //$sendZip = $accountInfo['send_zip'];
    //$sendPlace = $accountInfo['send_place'];
    //$sendState = $accountInfo['send_state'];
    //$sendCountry = $accountInfo['send_country'];
    $vat = $userMap['codice_fiscale']->content();
    $tel1 = $userMap['telefono']->content();
    //$tel2 = $accountInfo['tel2'];


}

// Check if user has an earlier order, copy order info from that one
//$orderList = eZOrder::activeByUserID( $user->attribute( 'contentobject_id' ) );
//if ( count( $orderList ) > 0 and  $user->isLoggedIn() )
//{
//    $accountInfo = $orderList[0]->accountInformation();
//    $street1 = $accountInfo['street1'];
//    $street2 = $accountInfo['street2'];
//    $zip = $accountInfo['zip'];
//    $place = $accountInfo['place'];
//    $state = $accountInfo['state'];
//    $country = $accountInfo['country'];
//    //$sendStreet = $accountInfo['send_street'];
//    //$sendZip = $accountInfo['send_zip'];
//    //$sendPlace = $accountInfo['send_place'];
//    //$sendState = $accountInfo['send_state'];
//    //$sendCountry = $accountInfo['send_country'];
//    $vat = $accountInfo['vat'];
//    $tel1 = $accountInfo['tel1'];
//    //$tel2 = $accountInfo['tel2'];
//}

$tpl->setVariable( "input_error", false );
if ( $module->isCurrentAction( 'Store' ) )
{
    $inputIsValid = true;
    $firstName = $http->postVariable( "FirstName" );
    if ( trim( $firstName ) == "" )
        $inputIsValid = false;
    $lastName = $http->postVariable( "LastName" );
    if ( trim( $lastName ) == "" )
        $inputIsValid = false;
    $email = $http->postVariable( "EMail" );
    if ( ! eZMail::validate( $email ) )
        $inputIsValid = false;

    //$street1 = $http->postVariable( "Street1" );
    $street1 = $http->postVariable( "Street1" );
        if ( trim( $street1 ) == "" )
            $inputIsValid = false;

    $zip = $http->postVariable( "Zip" );
    if ( trim( $zip ) == "" )
        $inputIsValid = false;

    $place = $http->postVariable( "Place" );
    if ( trim( $place ) == "" )
        $inputIsValid = false;

    $state = $http->postVariable( "State" );
    if ( trim( $state ) == "" )
        $inputIsValid = false;

    $comment = $http->postVariable( "Comment" );

    //$sendStreet = $http->postVariable( "SendStreet" );
    //$sendZip = $http->postVariable( "SendZip" );
    //$sendPlace = $http->postVariable( "SendPlace" );
    //$sendState = $http->postVariable( "SendState" );
    //$sendCountry = $http->postVariable( "SendCountry" );

    $tel1 = $http->postVariable( "Tel1" );
    if ( trim( $tel1 ) == "" )
        $inputIsValid = false;

    //$tel2 = $http->postVariable( "Tel2" );

    $vat = $http->postVariable( "Vat" );
    if ( trim( $vat ) == "" )
        $inputIsValid = false;

    if ( $inputIsValid == true )
    {
        // Check for validation
        $basket = eZBasket::currentBasket();

        $db = eZDB::instance();
        $db->begin();
        $order = $basket->createOrder();

        $doc = new DOMDocument( '1.0', 'utf-8' );

        $root = $doc->createElement( "shop_account" );
        $doc->appendChild( $root );

        $firstNameNode = $doc->createElement( "first-name", $firstName );
        $root->appendChild( $firstNameNode );

        $lastNameNode = $doc->createElement( "last-name", $lastName );
        $root->appendChild( $lastNameNode );

        $emailNode = $doc->createElement( "email", $email );
        $root->appendChild( $emailNode );

        $street1Node = $doc->createElement( "street1", $street1 );
        $root->appendChild( $street1Node );

        $street2Node = $doc->createElement( "street2", $street2 );
        $root->appendChild( $street2Node );

        $zipNode = $doc->createElement( "zip", $zip );
        $root->appendChild( $zipNode );

        $placeNode = $doc->createElement( "place", $place );
        $root->appendChild( $placeNode );

        $stateNode = $doc->createElement( "state", $state );
        $root->appendChild( $stateNode );

        $countryNode = $doc->createElement( "country", $country );
        $root->appendChild( $countryNode );

        $commentNode = $doc->createElement( "comment", $comment );
        $root->appendChild( $commentNode );

        //$sendStreetNode = $doc->createElement( "send-street", $sendStreet );
        //$root->appendChild( $sendStreetNode );
        //
        //$sendPlaceNode = $doc->createElement( "send-place", $sendPlace );
        //$root->appendChild( $sendPlaceNode );
        //
        //$sendStateNode = $doc->createElement( "send-state", $sendState );
        //$root->appendChild( $sendStateNode );
        //
        //$sendCountryNode = $doc->createElement( "send-country", $sendCountry );
        //$root->appendChild( $sendCountryNode );
        //
        //$sendZipNode = $doc->createElement( "send-zip", $sendZip );
        //$root->appendChild( $sendZipNode );

        $sendVatNode = $doc->createElement( "vat", $vat );
        $root->appendChild( $sendVatNode );

        $sendTel1Node = $doc->createElement( "tel1", $tel1 );
        $root->appendChild( $sendTel1Node );

        //$sendTel2Node = $doc->createElement( "tel2", $tel2 );
        //$root->appendChild( $sendTel2Node );

        $xmlString = $doc->saveXML();

        $order->setAttribute( 'data_text_1', $xmlString );
        $order->setAttribute( 'account_identifier', "oc" );

        $order->setAttribute( 'ignore_vat', 0 );

        $order->store();
        $db->commit();
        eZShopFunctions::setPreferredUserCountry( $country );
        $http->setSessionVariable( 'MyTemporaryOrderID', $order->attribute( 'id' ) );

        $module->redirectTo( '/shop/confirmorder/' );
        return;
    }
    else
    {
        $tpl->setVariable( "input_error", true );
    }
}

$tpl->setVariable( "first_name", $firstName );
$tpl->setVariable( "last_name", $lastName );
$tpl->setVariable( "email", $email );
$tpl->setVariable( "street1", $street1 );
//$tpl->setVariable( "street2", $street2 );
$tpl->setVariable( "zip", $zip );
$tpl->setVariable( "place", $place );
$tpl->setVariable( "state", $state );
//$tpl->setVariable( "country", $country );
$tpl->setVariable( "comment", $comment );


//$tpl->setVariable( "send_street", $sendStreet );
//$tpl->setVariable( "send_zip", $sendZip );
//$tpl->setVariable( "send_place", $sendPlace );
//$tpl->setVariable( "send_state", $sendState );
//$tpl->setVariable( "sendCountry", $sendCountry );
$tpl->setVariable( "vat", $vat );
$tpl->setVariable( "tel1", $tel1 );
//$tpl->setVariable( "tel2", $tel2 );


$Result = array();
$Result['content'] = $tpl->fetch( "design:ocshop/userregister.tpl" );
$Result['path'] = array( array( 'url' => false,
                                'text' => ezpI18n::tr( 'kernel/shop', 'Enter account information' ) ) );
?>
