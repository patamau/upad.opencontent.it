<?php

$module = $Params['Module'];

$tpl = eZTemplate::factory();

$offset = $Params['Offset'];
$limit = 15;


$orderArray = eZPersistentObject::fetchObjectList( eZOrder::definition(),
                                                    null,
                                                    array( "user_id" => eZUser::currentUserID(), 'is_temporary' => 0 ),
                                                    array( "created" => "desc" ),
                                                    array( "limit" => $limit, "offset" => $offset ),
                                                    true );
$orderCount = 10;

$tpl->setVariable( 'order_list', $orderArray );
$tpl->setVariable( 'order_list_count', $orderCount );
$tpl->setVariable( 'limit', $limit );

$viewParameters = array( 'offset' => $offset );
$tpl->setVariable( 'view_parameters', $viewParameters );
$tpl->setVariable( 'sort_field', false );
$tpl->setVariable( 'sort_order', false );

$Result = array();
$Result['path'] = array( array( 'text' => ezpI18n::tr( 'kernel/shop', 'Order list' ),
                                'url' => false ) );

$Result['content'] = $tpl->fetch( 'design:ocorder/orderlist.tpl' );