#!/usr/bin/env php
<?php
/**
 *
 */

// script initializing
require_once 'autoload.php';

$cli = eZCLI::instance();
$script = eZScript::instance( array( 'description' => ( "Resetta l'ecommerce" ),
    'use-session' => false,
    'use-modules' => true,
    'use-extensions' => true ) );

$script->startup();

$options = $script->getOptions();
$script->initialize();
$script->setUseDebugAccumulators( true );


$ini = eZINI::instance();
// Get user's ID who can remove subtrees. (Admin by default with userID = 14)
$userCreatorID = $ini->variable( "UserSettings", "UserCreatorID" );
$user = eZUser::fetch( $userCreatorID );
if ( !$user )
{
    $cli->error( "Script Error!\nCannot get user object by userID = '$userCreatorID'.\n(See site.ini[UserSettings].UserCreatorID)" );
    $script->shutdown( 1 );
}
eZUser::setCurrentlyLoggedInUser( $user, $userCreatorID );

$i = 0;
$conditions = null;
//$invoices = eZUpadInvoice::fetchList($conditions);


$count = (int) eZUpadInvoice::countList($conditions);

/*
 * To avoid fatal errors due to memory exhaustion, pending actions are fetched by packets
 */

$totalLimit = 2000;



$offset = 8050;
$length = 50;
$i = 0;
$limit = array(
    'offset' => $offset,
    'length' => $length
);

$cli->notice('Total invoices : ' . $count);

while( $offset <= $count && $i < $totalLimit )
{
    $limit[ 'offset' ] = $offset;
    $invoices = eZPersistentObject::fetchObjectList(eZUpadInvoice::definition(), null, $conditions, null, $limit);

    foreach( $invoices as $invoice )
    {
        $cli->notice('Aggiorno invoice : ' . $invoice->attribute('id'));
        $s_fetch_parameters = array(
            'query'     => '',
            'class_id'  => array('subscription'),
            'filter'    => array( 'extra_invoice_id____si:' . $invoice->attribute('id')),
            'limit'     => array(1)
        );
        $result = eZFunctionHandler::execute('ezfind', 'search', $s_fetch_parameters);

        if ($result['SearchCount'] <= 0) {
            $error []= $invoice->attribute('id');
            $cli->error('No subscription for invoice ' . $invoice->attribute('id'));
            continue;
        }

        $subscription = $result['SearchResult'][0];
        $subscriptionDataMap = $subscription->ContentObject->dataMap();

        $courseID = $subscriptionDataMap['course']->toString();
        $cli->notice('Corso: ' . $courseID);

        /** @var eZContentObject $course */
        try {
            $course = eZContentObject::fetch($courseID);
            if ($course instanceof eZContentObject) {

                $courseDataMap = $course->dataMap();

                // Codice Area
                $relArea = $courseDataMap['codice_area']->content();
                $areaID = $relArea['relation_list'][0]['contentobject_id'];
                eZUpadInvoiceMeta::create($invoice->attribute('id'), $subscription->ContentObject->attribute('id'), $courseID, $areaID, $invoice->attribute('total'));
            }
        }
        catch (\Exception $e)
        {
            $cli->error($e->getMessage());
        }
        $i++;
        unset($subscription, $subscriptionDataMap, $course);
    }
    // Increment the offset until we've gone through every user
    $offset += $length;
}


$script->shutdown();

?>
