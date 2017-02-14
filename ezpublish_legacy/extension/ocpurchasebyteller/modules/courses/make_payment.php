<?php

$module = $Params['Module'];
$tpl = eZTemplate::factory();
$http = eZHTTPTool::instance();

$courseId = intval( $Params['CourseID'] );
$course = eZContentObject::fetch( $courseId );

$userId = intval( $Params['UserID'] );
$user = eZContentObject::fetch( $userId );

if ( !$course instanceof eZContentObject || !$user instanceof eZContentObject )
{
    return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );
}

if ( $http->hasPostVariable( "MakePaymentButton" ) )
{
    $value = $http->postVariable( "PaymentValue", false );
    $writeOff = $http->postVariable( "PaymentWriteOff", false );

    $value = str_replace(',', '.', $value);
    $value = floatval( $value );
    if ( $value > 0 )
    {

        $datamap = $course->dataMap();

        $description = $course->attribute( 'name' );
        //$description .= ' dal ' . strftime( '%d-%m-%Y',  $datamap['data_inizio']->attribute('data_int'));
        //$description .= ' al ' . strftime( '%d-%m-%Y',  $datamap['data_fine']->attribute('data_int'));

        $description .= ' <br /> ' . $datamap['short_title']->attribute('data_text');

        if ($datamap['orario']->attribute('data_text'))
        {
            $description .= ' ' . $datamap['orario']->attribute('data_text');
        }

        $list = array();
        $list[$courseId] = array(
            'description' =>  $description,
            'total' => $writeOff ? -$value : $value
        );

        $dataMap = $course->attribute( 'data_map' );
        if ( isset( $dataMap['ente'] ) && $dataMap['ente']->attribute( 'has_content' ) )
        {
            $enteIds = explode( '-', $dataMap['ente']->toString() );
            $enteId = array_shift( $enteIds );
            $ente = eZContentObject::fetch( $enteId );
            if ( $ente instanceof eZContentObject )
            {
                $invoice = UpadInvoice::createFromItemList( $list, $ente, eZUser::fetch( $userId ) );
                if ( $invoice instanceof eZUpadInvoice )
                {
                    UpadSubscription::instance( $courseId, $userId )->addInvoice( $invoice->attribute( 'id' ) );
                }
                $module->redirectTo( 'courses/make_payment/' . $courseId . '/' . $userId );
            }
        }
    }
}

$Result = array();
$tpl->setVariable( "course", $course );
$tpl->setVariable( "user", $user );
$Result['path'] = array(
    array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
    array( 'text' => $course->attribute( 'name' ), 'url' => false ),
);
$Result['content'] = $tpl->fetch( 'design:courses/make_payment.tpl' );
