<?php

class UpadSubscription
{
    public static function instance( $courseId, $userId )
    {
        $rootNodeId = eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'SubscriptionRootNode' );
        $rootNode = eZContentObjectTreeNode::fetch( $rootNodeId );
        if ( !$rootNode instanceof eZContentObjectTreeNode )
        {
            throw new Exception( "SubscriptionRootNode not found" );
        }
        $remoteId = "subscription_{$courseId}_{$userId}";
        $subscription = eZContentObject::fetchByRemoteID( $remoteId );
        if ( !$subscription instanceof eZContentObject )
        {
            $params = array();
            $params['class_identifier'] = 'subscription';
            $params['remote_id'] = $remoteId;
            $params['parent_node_id'] = $rootNodeId;
            $params['attributes'] = array( 'user' => $userId, 'course' => $courseId );

            $loggedUser = eZUser::currentUser();
            $admin = eZUser::fetchByName( 'admin' );
            if ( $admin instanceof eZUser ) eZUser::setCurrentlyLoggedInUser( $admin, $admin->attribute( 'contentobject_id' ), 1 );
            $subscription = eZContentFunctions::createAndPublishObject( $params );
            eZUser::setCurrentlyLoggedInUser( $loggedUser, $loggedUser->attribute( 'contentobject_id' ), 1 );
        }

        if ( !$subscription instanceof eZContentObject )
        {
            throw new Exception( "Fail on subscription creation" );
        }

        return new UpadSubscription( $subscription );
    }

    public static function fromOrder( eZOrder $order )
    {
        if ( $order instanceof eZOrder )
        {
            if ( in_array( $order->attribute( 'status_id' ), array( 3, 1000, 1002, 1003 ) ) )
            {
                $user = $order->attribute( 'user' );
                if ( $user instanceof eZUser )
                {
                    $userId = $user->id();
                    try
                    {
                        $invoiceHelper = new UpadInvoiceHelper( $order );
                        $invoices = $invoiceHelper->attribute( 'invoices' );
                        $data = $invoiceHelper->parseOrder();
                        $count = 0;
                        foreach( $data as $id => $products )
                        {
                            $courseIds = array();
                            foreach( $products as $product )
                            {
                                if ( $product['item_object']->attribute( 'contentobject' ) instanceof eZContentObject )
                                {
                                    if ( $product['item_object']->attribute( 'contentobject' )->attribute( 'class_identifier' ) == 'corso' )
                                    {
                                        $courseIds[] = $product['item_object']->attribute( 'contentobject' )->attribute( 'id' );
                                    }
                                }
                            }
                            foreach( $courseIds as $courseId )
                            {
                                if ( $invoices[$count] instanceof eZUpadInvoice )
                                    UpadSubscription::instance( $courseId, $userId )->addInvoice( $invoices[$count]->attribute( 'id' ) );
                                else
                                    UpadSubscription::instance( $courseId, $userId );
                            }
                            $count++;
                        }
                        return true;
                    }
                    catch( Exception $e )
                    {
                        eZLog::write( 'Exception: ' . $e->getMessage(), 'subscription.log' );
                    }
                }
                else
                {
                   eZLog::write( "User order not found", 'subscription.log' );
                }
            }
            else
            {
               eZLog::write( "Order {$order->attribute( 'id' )} not complete", 'subscription.log' );
            }
        }
        else
        {
            eZLog::write( "Order not found or not complete", 'subscription.log' );
        }
        return false;
    }

    protected $subscription;

    protected function __construct( eZContentObject $object )
    {
        $this->subscription = $object;
    }

    public function addInvoice( $id )
    {
        $id = intval( $id );
        $dataMap = $this->subscription->attribute( 'data_map' );
        if ( isset( $dataMap['invoices'] ) && eZUpadInvoice::fetch( $id ) instanceof eZUpadInvoice )
        {
            $invoiceIds = explode( '&', $dataMap['invoices']->toString() );
            $invoiceIds[] = $id;
            $invoiceIds = eZUpadInvoice::checkInvoiceIdArrayConsistency( $invoiceIds );
            //$dataMap['invoices']->fromString( implode( '&', $invoiceIds ) );
            //$dataMap['invoices']->store();


            $params = array();
            $params['attributes'] = array(
                'invoices' => implode( '&', $invoiceIds )
            );
            eZContentFunctions::updateAndPublishObject( $this->subscription, $params );
            // Fix Luca 23/08/2016
            $this->subscription->resetDataMap();
            eZContentObject::clearCache( array( $this->subscription->attribute( 'id' ) ) );
            $this->subscription = eZContentObject::fetch($this->subscription->attribute( 'id' ));
            eZSearch::addObject( $this->subscription, true );


            /*eZContentOperationCollection::registerSearchObject( $this->subscription->attribute( 'id' ), $this->subscription->attribute( 'current_version' ) );
            eZContentCacheManager::clearObjectViewCache( $this->subscription->attribute( 'id' ) );*/
        }
    }

    /**
     * Clona le iscrizioni di un corso in iscrizioni di un altro corso
     *
     * @param eZContentObject $sourceCourse
     * @param eZContentObject $targetCourse
     */
    public static function cloneFromCourse( eZContentObject $sourceCourse,  eZContentObject $targetCourse )
    {
        if ( $sourceCourse instanceof eZContentObject && $targetCourse instanceof eZContentObject
            && $sourceCourse->attribute('class_identifier') == 'corso'  && $targetCourse->attribute('class_identifier') == 'corso')
        {
            $includeClasses = array( 'subscription' );
            $attributefilter = array();
            $attributefilter[]= 'and';
            $attributefilter[]= array('subscription/course', '=', $sourceCourse->ID);
            $attributefilter[]= array('subscription/annullata', '=', false);
            $params = array(
                'ClassFilterType' => 'include',
                'ClassFilterArray' => $includeClasses,
                'AttributeFilter' => $attributefilter,
                'SortBy' => array( 'name', 'asc' ),
                'LoadDataMap' => false
            );
            $subscriptions = eZContentObjectTreeNode::subTreeByNodeID( $params, 1 );
            if (!empty($subscriptions)) {
                foreach ($subscriptions as $s) {

                    /** @var eZContentObject $subscriptionObject */
                    $subscriptionObject = $s->ContentObject;
                    $subscriptionDataMap = $subscriptionObject->dataMap();
                    UpadSubscription::instance($targetCourse->ID, $subscriptionDataMap['user']->content()->ID);
                }
            }
        }
    }
}
