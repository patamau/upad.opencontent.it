<?php
ini_set('display_errors', 1);

$module     = $Params['Module'];
$http      = eZHTTPTool::instance();
$c         = $http->variable( 'c', false );
$transid   = $http->variable( 'transid', false );
$panc      = $http->variable( 'panc', false );
$expDate   = $http->variable( 'expdate', false );
$lingua    = $http->variable( 'lingua', false );
$controllo = $http->variable( 'controllo', false );
$termid    = $http->variable( 'termid', false );
$country   = $http->variable( 'country', false );

$t = explode('-', $transid);
$orderID = $t[0];

$order = eZOrder::fetch( $orderID );
if ( $order instanceof eZOrder )
{

    $sparkasseINI = eZINI::instance( 'sparkasse.ini' );
    $debug        = $sparkasseINI->variable( 'ServerSettings', 'Debug');
    $muaID        = $sparkasseINI->variable( 'EnteSetting', 'MuaID');
    $palladioID   = $sparkasseINI->variable( 'EnteSetting', 'PalladioID');
    $upadID       = $sparkasseINI->variable( 'EnteSetting', 'UpadID');
    $ente         = 0;

    $products = $order->attribute( 'product_items' );
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

    // Recupero la chiave md5 per verificare l'autenticità dell'esito
    switch ($ente) {
        case $muaID:
            $chiaveMD5       = $sparkasseINI->variable( 'SparkasseSettings', 'ChiaveMD5Mua' );
            break;

        case $palladioID:
            $chiaveMD5       = $sparkasseINI->variable( 'SparkasseSettings', 'ChiaveMD5Palladio' );
            break;

        case $upadID:
        default:
            $chiaveMD5       = $sparkasseINI->variable( 'SparkasseSettings', 'ChiaveMD5Upad' );
            break;
    }

    // Debug
    if ($debug == 1) {
        $chiaveMD5       = $sparkasseINI->variable( 'SparkasseSettings', 'ChiaveMD5' );
    }

    if ($controllo == md5($c . $transid . $panc . $expDate . $lingua . $chiaveMD5)) {
        // Se la somma della seconda, della quinta e della settima cifra del “parametro c” è pari, allora l'esito della transazione è OK
        $somma = (int) substr($c,1,1) + (int) substr($c,4,1) + (int) substr($c,6,1);
        if ( $somma % 2 == 0) {
            // Il pagamento è andato a buon fine
            $order->setStatus( eZOrderStatus::DELIVERED );
            $order->store();

            // Creo le iscrizioni
            //UpadSubscription::fromOrder( $order );

            $accountInfo = $order->accountInformation();

            // Invio l'email al cliente
            $siteINI     = eZINI::instance( 'site.ini' );
            $emailSender = $siteINI->variable( 'MailSettings', 'EmailSender');
            $adminEmail  = $siteINI->variable( 'MailSettings', 'AdminEmail');

            $mail = new ezcMailComposer();
            $mail->from = new ezcMailAddress( $emailSender, 'Sito Upad' );
            // Add one "to" mail address (multiple can be added)
            $mail->addTo( new ezcMailAddress( $order->accountEmail(), $order->accountName()));
            $mail->subject = "Conferma di prenotazione";
            $body = "Gentitle utente,\rGrazie per aver prenotato il Suo corso presso Fondazione UPAD\rDi seguito i dettagli della sua prenotazione:\r\r";
            foreach ($order->productItems() as $p) {
                $body .= $p['object_name'] . "\r";
            }
            $body.= "\rImporto " . $order->totalIncVAT() . "\r";
            $body.= "\rPer qualunque dubbio o informazione La preghiamo di consultare il nostro sito www.upad.it, chiamare il numero 0471 921023 o recarsi di persona presso inostri sportelli.\rUn cordiale saluto\r\rFondazione UPAD";
            $mail->plainText = $body;
            $mail->build();
            $transport = new ezcMailMtaTransport();
            $transport->send( $mail );

            // Invio l'email al gestore del negozio
            $sMail = new ezcMailComposer();
            $sMail->from = new ezcMailAddress( $emailSender, 'Sito Upad' );
            // Add one "to" mail address (multiple can be added)
            $sMail->addTo( new ezcMailAddress( $adminEmail));
            $sMail->subject = "Nuova iscrizione";
            $body = "E' stata effettuata una nuova iscrizione a nome:\r\r";
            $body .= "Nome: {$accountInfo['first_name']}\r";
            $body .= "Cognome: {$accountInfo['last_name']}\r";
            $body .= "Telefono: {$accountInfo['tel1']}\r";
            $body .= "Indirizzo: {$accountInfo['street1']} {$accountInfo['zip']} {$accountInfo['place']} ({$accountInfo['state']})\r";
            $body .= "Per i corsi:\r\r";
            foreach ($order->productItems() as $p) {
                $body .= $p['object_name'] . "\r";
            }
            $body.= "\rImporto " . $order->totalIncVAT() . "\r";
            $body.= "Il pagamento è avvenuto con successo.\r";
            $sMail->plainText = $body;
            $sMail->build();
            $transport->send( $sMail );

            $module->redirectTo( 'shop/checkout' );
        } else {

            //$order->setStatus( eZOrderStatus::PENDING );
            //$order->store();
            // Verifico il tipo di errore e restituisco il msg opportuno
            $error = 'Errore';

            if ((int) substr($c,0,2) == 90) {
                $error = 'I parametri inviati, errati o incompleti, sono stati filtrati prima di contattare la compagnia" i dati inviati sono evidentemente errati o assenti (es. abi errato, …).';
            }

            if ((int) substr($c,0,2) == 91) {
                $error = 'L\'autorizzazione per questo ordine è già stata concessa dalla compagnia di credito.';
            }

            if ((int) substr($c,0,1) == 8) {
                $error = 'Firma sui dati inviati al WebPOS non corretta.';
            }

            if ((int) substr($c,0,1) == 2) {
                $error = 'Errori relativi alla carta di credito.';
            }

            if ((int) substr($c,0,1) == 3) {
                $error = 'Errori nella connessione alla rete interbancaria. Riprovare più tardi.';
            }

            if ((int) substr($c,0,1) == 4) {
                $error = 'Errori di configurazione del terminale.';
            }

            $tpl = eZTemplate::factory();
            $tpl->setVariable ("error", $error );
            $tpl->setVariable ("order", $order);

            $Result['content'] = $tpl->fetch( "design:sparkasse/error.tpl" ) ;
            $Result['path'] = array( array( 'url' => false,
                                            'text' => ezpI18n::tr( 'kernel/shop', 'Checkout' ) ) );
            return;
        }
    } else {
        $error = 'MD5 errato, la firma sui dati WebPOS non corrisponde ai parametri ricevuti';
        $tpl = eZTemplate::factory();
        $tpl->setVariable ("error", $error );
        $tpl->setVariable ("order", $order);

        $Result['content'] = $tpl->fetch( "design:sparkasse/error.tpl" ) ;
        $Result['path'] = array( array( 'url' => false,
                                        'text' => ezpI18n::tr( 'kernel/shop', 'Checkout' ) ) );
        return;
    }
} else {
    $order->setStatus( eZOrderStatus::PENDING );
    $order->store();

    $error = 'Non esiste una procedura di pagamento attiva per questa transazione.';
    $tpl = eZTemplate::factory();
    $tpl->setVariable ("error", $error );
    $tpl->setVariable ("order", $order);
    $Result['content'] = $tpl->fetch( "design:sparkasse/error.tpl" ) ;
    $Result['path'] = array( array( 'url' => false,
                                    'text' => ezpI18n::tr( 'kernel/shop', 'Checkout' ) ) );
    return;
}


?>
