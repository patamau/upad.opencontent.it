<?php

$module          = $Params['Module'];
$http            = eZHTTPTool::instance();
$productObjectID = $http->variable( 'productObjectID', false );
$userID          = $http->variable( 'userID', false );

if ( $http->hasPostVariable( "SearchUserButton" ) )
{
    $module->redirectTo( "ocpurchasebyteller/form/(s)/" . $http->postVariable( "SearchUser", '*' ) );
    return;
}
$user = eZUser::fetch($userID);
if ( !$user instanceof eZUser )
{
    $module->redirectTo( "ocpurchasebyteller/form" );
    return;
}
$basket = eZBasket::currentBasket();
if ( $http->hasPostVariable( "CheckoutButton" ) or ( $doCheckout === true ) )
{
    if ( $http->hasPostVariable( "ProductItemIDList" ) )
    {
        $itemCountList = $http->postVariable( "ProductItemCountList" );

        $counteditems = 0;
        foreach ($itemCountList as $itemCount)
        {
            $counteditems = $counteditems + $itemCount;
        }
        $zeroproduct = false;
        if ( $counteditems == 0 )
        {
            $zeroproduct = true;
            return $module->redirectTo( $module->functionURI( "basket" ) );
        }

        $itemIDList = $http->postVariable( "ProductItemIDList" );

        if ( is_array( $itemCountList ) && is_array( $itemIDList ) && count( $itemCountList ) == count( $itemIDList ) && is_object( $basket ) )
        {
            $productCollectionID = $basket->attribute( 'productcollection_id' );
            $db = eZDB::instance();
            $db->begin();

            for ( $i = 0, $itemCountError = false; $i < count( $itemIDList ); ++$i )
            {
                // If item count of product <= 0 we should show the error
                if ( !is_numeric( $itemCountList[$i] ) or $itemCountList[$i] <= 0 )
                {
                    $itemCountError = true;
                    continue;
                }
                $item = eZProductCollectionItem::fetch( $itemIDList[$i] );
                if ( is_object( $item ) && $item->attribute( 'productcollection_id' ) == $productCollectionID )
                {
                    $item->setAttribute( "item_count", $itemCountList[$i] );
                    $item->store();
                }
            }
            $db->commit();
            if ( $itemCountError )
            {
                // Redirect to basket
                $module->redirectTo( $module->functionURI( "basket" ) . "/(error)/invaliditemcount" );
                return;
            }
        }
    }

    // Creates an order and redirects
    
    $productCollectionID = $basket->attribute( 'productcollection_id' );

    $verifyResult = eZProductCollection::verify( $productCollectionID  );

    $db = eZDB::instance();
    $db->begin();
    $basket->updatePrices();

    if ( $verifyResult === true )
    {        
        $time = time();
        $order = new eZOrder( array( 'productcollection_id' => $productCollectionID,
                                     'user_id' => $userID,
                                     'is_temporary' => 1,
                                     'created' => $time,
                                     'status_id' => eZOrderStatus::PENDING,
                                     'status_modified' => $time,
                                     'status_modifier_id' => $userID
                                     ) );
        $order->store();

        $orderID = $order->attribute( 'id' );
        $order->setAttribute( 'order_id', $orderID );
        $order->store();
        $db->commit();

        /* Riempio i dati per la fatturazione */
        $userObject = $user->attribute( 'contentobject' );
        $userMap = $userObject->dataMap();
        $firstName = $userMap['first_name']->content();
        $lastName = $userMap['last_name']->content();
        $email = $user->attribute( 'email' );
        $street1 = $userMap['indirizzo_residenza']->content();
        $zip = $userMap['cap_residenza']->content();
        $place = $userMap['comune_residenza']->content();
        $state = $userMap['provincia_residenza']->content();
        $vat = $userMap['codice_fiscale']->content();
        $tel1 = $userMap['telefono']->content();

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

        $sendVatNode = $doc->createElement( "vat", $vat );
        $root->appendChild( $sendVatNode );

        $sendTel1Node = $doc->createElement( "tel1", $tel1 );
        $root->appendChild( $sendTel1Node );

        $xmlString = $doc->saveXML();
        $order->setAttribute( 'data_text_1', $xmlString );
        $order->setAttribute( 'account_identifier', "oc" );
        $order->setAttribute( 'ignore_vat', 0 );
        $order->store();

        //$operationResult = eZOperationHandler::execute( 'shop', 'confirmorder', array( 'order_id' => $order->attribute( 'id' ) ) );
        $order->detachProductCollection();
        // Attivo l'ordine
        $order->activate();
        $order->setStatus( 1000 );        
        // Svuoto il carrello per la sessione corrente
        $basket = eZBasket::cleanupCurrentBasket(false);
        $order->store();
        UpadSubscription::fromOrder( $order );
    }
    else
    {
        $basket = eZBasket::currentBasket();
        $removedItems = array();
        foreach ( $itemList as $item )
        {
            $removedItems[] = $item;
            $basket->removeItem( $item->attribute( 'id' ) );
        }
    }
    $db->commit();
}

$tpl = eZTemplate::factory();

$Result = array();
$Result['content'] = $tpl->fetch( "design:purchasebyteller/assign.tpl" ) ;
$Result['path'] = array( array( 'url' => false,
                                'text' => 'assign' ) );

return;

?>
