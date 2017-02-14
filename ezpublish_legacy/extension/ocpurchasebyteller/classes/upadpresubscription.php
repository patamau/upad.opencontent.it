<?php

class UpadPreSubscription
{
    public static function instance( $courseId, $userId )
    {
        $rootNodeId = eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'PreSubscriptionRootNode' );
        $rootNode = eZContentObjectTreeNode::fetch( $rootNodeId );
        if ( !$rootNode instanceof eZContentObjectTreeNode )
        {
            throw new Exception( "PreSubscriptionRootNode not found" );
        }
        $remoteId = "presubscription_{$courseId}_{$userId}";
        $subscription = eZContentObject::fetchByRemoteID( $remoteId );
        if ( !$subscription instanceof eZContentObject )
        {
            $params = array();
            $params['class_identifier'] = 'pre_subscription';
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
            throw new Exception( "Fail on presubscription creation" );
        }

        return new UpadPreSubscription( $subscription );
    }

    /**
     * Clona le iscrizioni di un corso in preiscrizioni di un altro corso
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
                    UpadPreSubscription::instance($targetCourse->ID, $subscriptionDataMap['user']->content()->ID);
                }
            }
        }
    }


    public static function confirm( $objectID )
    {
        $preSubscription = eZContentObject::fetch( $objectID );
        if ($preSubscription instanceof eZContentObject && $preSubscription->attribute( 'class_identifier' ) == 'pre_subscription')
        {
            $preSubscriptionDataMap = $preSubscription->dataMap();
            $subscription = UpadSubscription::instance( $preSubscriptionDataMap['course']->content()->ID, $preSubscriptionDataMap['user']->content()->ID);

            if ($subscription instanceof UpadSubscription)
            {
                $params = array();
                $params['attributes'] = array(
                    'confirmed' => 1 ,
                    'confirmed_date' => time()
                );
                eZContentFunctions::updateAndPublishObject( $preSubscription, $params );
            }
        }
    }

    protected $subscription;

    protected function __construct( eZContentObject $object )
    {
        $this->subscription = $object;
    }

}
