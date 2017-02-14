<?php

class OCUserShopAccountHandler
{
    function OCUserShopAccountHandler()
    {

    }

    /*!
     Will verify that the user has supplied the correct user information.
     Returns true if we have all the information needed about the user.
    */
    function verifyAccountInformation()
    {
        return false;
    }

    /*!
     Redirectes to the user registration page.
    */
    function fetchAccountInformation( &$module )
    {
        $module->redirectTo( '/ocshop/userregister/' );
    }

    /*!
     \return the account information for the given order
    */
    function email( $order )
    {
        $email = false;
        $xmlString = $order->attribute( 'data_text_1' );
        if ( $xmlString != null )
        {
            $dom = new DOMDocument( '1.0', 'utf-8' );
            $success = $dom->loadXML( $xmlString );
            $emailNode = $dom->getElementsByTagName( 'email' )->item( 0 );
            if ( $emailNode )
            {
                $email = $emailNode->textContent;
            }
        }

        return $email;
    }

    /*!
     \return the account information for the given order
    */
    function accountName( $order )
    {
        $accountName = '';
        $xmlString = $order->attribute( 'data_text_1' );
        if ( $xmlString != null )
        {
            $dom = new DOMDocument( '1.0', 'utf-8' );
            $success = $dom->loadXML( $xmlString );
            $firstNameNode = $dom->getElementsByTagName( 'first-name' )->item( 0 );
            $lastNameNode = $dom->getElementsByTagName( 'last-name' )->item( 0 );
            $accountName = $firstNameNode->textContent . ' ' . $lastNameNode->textContent;
        }

        return $accountName;
    }

    function accountInformation( $order )
    {
        $firstName = '';
        $lastName = '';
        $email = '';
        $street1 = '';
        $street2 = '';
        $zip = '';
        $place = '';
        $country = '';
        $comment = '';
        $state = '';

        $dom = new DOMDocument( '1.0', 'utf-8' );
        $xmlString = $order->attribute( 'data_text_1' );
        if ( $xmlString != null )
        {
            $dom = new DOMDocument( '1.0', 'utf-8' );
            $success = $dom->loadXML( $xmlString );

            $firstNameNode = $dom->getElementsByTagName( 'first-name' )->item( 0 );
            if ( $firstNameNode )
            {
                $firstName = $firstNameNode->textContent;
            }

            $lastNameNode = $dom->getElementsByTagName( 'last-name' )->item( 0 );
            if ( $lastNameNode )
            {
                $lastName = $lastNameNode->textContent;
            }

            $emailNode = $dom->getElementsByTagName( 'email' )->item( 0 );
            if ( $emailNode )
            {
                $email = $emailNode->textContent;
            }

            $street1Node = $dom->getElementsByTagName( 'street1' )->item( 0 );
            if ( $street1Node )
            {
                $street1 = $street1Node->textContent;
            }

            $street2Node = $dom->getElementsByTagName( 'street2' )->item( 0 );
            if ( $street2Node )
            {
                $street2 = $street2Node->textContent;
            }

            $zipNode = $dom->getElementsByTagName( 'zip' )->item( 0 );
            if ( $zipNode )
            {
                $zip = $zipNode->textContent;
            }

            $placeNode = $dom->getElementsByTagName( 'place' )->item( 0 );
            if ( $placeNode )
            {
                $place = $placeNode->textContent;
            }

            $stateNode = $dom->getElementsByTagName( 'state' )->item( 0 );
            if ( $stateNode )
            {
                $state = $stateNode->textContent;
            }

            $countryNode = $dom->getElementsByTagName( 'country' )->item( 0 );
            if ( $countryNode )
            {
                $country = $countryNode->textContent;
            }

            $commentNode = $dom->getElementsByTagName( 'comment' )->item( 0 );
            if ( $commentNode )
            {
                $comment = $commentNode->textContent;
            }
            
            $sendStreet = false;
            $sendStreetNode = $dom->getElementsByTagName( 'send-street' )->item( 0 );
            if ( $sendStreetNode )
            {
                $sendStreet = $sendStreetNode->textContent;
            }
            
            $sendPlace = false;
            $sendPlaceNode = $dom->getElementsByTagName( 'send-place' )->item( 0 );
            if ( $sendPlaceNode )
            {
                $sendPlace = $sendPlaceNode->textContent;
            }
            
            $sendState = false;
            $sendStateNode = $dom->getElementsByTagName( 'send-state' )->item( 0 );
            if ( $sendStateNode )
            {
                $sendState = $sendStateNode->textContent;
            }
            
            $sendCountry = false;
            $sendCountryNode = $dom->getElementsByTagName( 'send-country' )->item( 0 );
            if ( $sendCountryNode )
            {
                $sendCountry = $sendCountryNode->textContent;
            }
            
            $sendZip = false;
            $sendZipNode = $dom->getElementsByTagName( 'send-zip' )->item( 0 );
            if ( $sendZipNode )
            {
                $sendZip = $sendZipNode->textContent;
            }
            
            $vat = false;
            $vatNode = $dom->getElementsByTagName( 'vat' )->item( 0 );
            if ( $vatNode )
            {
                $vat = $vatNode->textContent;
            }
            
            $tel1 = false;
            $tel1Node = $dom->getElementsByTagName( 'tel1' )->item( 0 );
            if ( $tel1Node )
            {
                $tel1 = $tel1Node->textContent;
            }
            
            $tel2 = false;
            $tel2Node = $dom->getElementsByTagName( 'tel2' )->item( 0 );
            if ( $tel2Node )
            {
                $tel2 = $tel2Node->textContent;
            }
        }

        return array( 'first_name' => $firstName,
                      'last_name' => $lastName,
                      'email' => $email,
                      'street1' => $street1,
                      'street2' => $street2,
                      'zip' => $zip,
                      'place' => $place,
                      'state' => $state,
                      'country' => $country,
                      'comment' => $comment,
                      'send_street' => $sendStreet,
                      'send_zip' => $sendZip,
                      'send_place' => $sendPlace,
                      'send_state' => $sendState,
                      'send_country' => $sendCountry,
                      'vat' => $vat,
                      'tel1' => $tel1,
                      'tel2' => $tel2
                      );
    }
}

?>