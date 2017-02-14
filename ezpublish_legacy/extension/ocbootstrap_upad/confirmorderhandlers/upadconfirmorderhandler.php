<?php

class UpadConfirmOrderHandler
{
    /*!
     Constructor
    */
    function UpadConfirmOrderHandler()
    {
    }

    function execute( $params = array() )
    {
        $ini = eZINI::instance();
        $sendOrderEmail = $ini->variable( 'ShopSettings', 'SendOrderEmail' );
        if ( $sendOrderEmail == 'enabled' )
        {
            $this->sendOrderEmail( $params );
        }
    }

    function getEnteEmailFromCorso( $object, $order )
    {
        $result = array();
        $dataMap = $object->attribute( 'data_map' );
        switch( $order->attribute( 'status_id' ) )
        {
            case 1:
            case 2:
            case 3:
                $identifier = 'email_cartacredito';
                break;
            
            case 1001:
            case 1002:
                $identifier = 'email_bonifico';
                break;
            case 1000:
                $identifier = 'email_prenotazione';
                brek;
            default:
                $identifier = 'email_prenotazione';
                brek;
        }

        if ( isset( $dataMap['ente'] ) && $dataMap['ente']->hasContent() )
        {
            $entiIds = explode( '-', $dataMap['ente']->toString() );
            foreach( $entiIds as $enteId )
            {
                $ente = eZContentObject::fetch( $enteId );
                if ( $ente instanceof eZContentObject )
                {
                    $enteDataMap = $ente->attribute( 'data_map' );
                    
                    if ( isset( $enteDataMap[$identifier] ) && $enteDataMap[$identifier]->hasContent() )
                    {
                        $result[] = $enteDataMap[$identifier]->content();
                    }
                }
            }
        }
        return $result;
    }
    
    function sendOrderEmail( $params )
    {
        $ini = eZINI::instance();
        if ( isset( $params['order'] ) and
             isset( $params['email'] ) )
        {
            $order = $params['order'];
            $email = $params['email'];
            
            $products = $order->attribute( 'product_items' );            
            $emailEnti = array();
            foreach( $products as $product )
            {
                $object = $product['item_object']->contentObject();
                if ( $object instanceof eZContentObject && $object->attribute( 'class_identifier' ) == 'corso' )
                {
                    $emailEnti = array_merge( $emailEnti, $this->getEnteEmailFromCorso( $object, $order ) );
                }
            }
            $tpl = eZTemplate::factory();
            $tpl->setVariable( 'order', $order );
            $templateResult = $tpl->fetch( 'design:shop/orderemail.tpl' );

            $subject = $tpl->variable( 'subject' );

            $mail = new eZMail();

            $emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
            if ( !$emailSender )
                $emailSender = $ini->variable( "MailSettings", "AdminEmail" );

            if ( $tpl->hasVariable( 'content_type' ) )
                $mail->setContentType( $tpl->variable( 'content_type' ) );

            $mail->setReceiver( $email );
            $mail->setSender( $emailSender );
            $mail->setSubject( $subject );
            $mail->setBody( $templateResult );
            $mailResult = eZMailTransport::send( $mail );

            

            $mail = new eZMail();

                        
            $email = $ini->variable( 'MailSettings', 'AdminEmail' );
            $mail->setReceiver( $email );
            
            if ( !empty( $emailEnti ) )
            {
                foreach ( $emailEnti as $emailEnte )
                {
                    $mail->addReceiver( $emailEnte );
                }
            }
            
            if ( $tpl->hasVariable( 'content_type' ) )
                $mail->setContentType( $tpl->variable( 'content_type' ) );
            
            $mail->setSender( $emailSender );
            $mail->setSubject( $subject );
            $mail->setBody( $templateResult );
            $mailResult = eZMailTransport::send( $mail );
        }
    }
}

?>
