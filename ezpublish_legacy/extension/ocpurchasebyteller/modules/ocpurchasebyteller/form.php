<?php

$module          = $Params['Module'];
$productObjectID = isset( $Params['productObjectID'] ) ? (int) $Params['productObjectID'] : 0;

// recupero il prodotto
$product = eZContentObjectTreeNode::fetchByContentObjectID( $productObjectID );

// recupero la lista di tutti gli utenti
$limit = 10;
$searchFor = $Params['Search'];
$offset = $Params['Offset'];
if ( !is_numeric( $offset ) ) $offset = 0;
$view_parameters = array( 'offset' => $offset );
if ( !empty( $searchFor ) )
{
    $view_parameters['s'] = $searchFor;    
}

$includeClasses = array( 'user' ); //please note this refers to content classes created in the CMS, rather than PHP files
$params = array(
    'ClassFilterType' => 'include',
    'ClassFilterArray' => $includeClasses,
    'SortBy' => array( 'name', 'asc' ),
    'ObjectNameFilter' => $searchFor,
    'LoadDataMap' => false    
);

// getting the ID of where the users sit in the cms (limiting the area eZ has to search for the objects):
$parent_node = eZContentObjectTreeNode::fetchByURLPath( 'users/members' );
$parent_node_id = $parent_node->attribute( 'node_id' );
$all_users = eZContentObjectTreeNode::subTreeByNodeID( array_merge( $params, array( 'Limit' => $limit, 'Offset' => $offset ) ), $parent_node_id );
$all_user_count = eZContentObjectTreeNode::subTreeCountByNodeID( $params, $parent_node_id );

$basket = eZBasket::currentBasket();

$tpl = eZTemplate::factory();
if ( isset( $Params['Error'] ) )
{
    $tpl->setVariable( 'error', $Params['Error'] );
    if ( $Params['Error'] == 'options' )
    {
        $tpl->setVariable( 'error_data', $http->sessionVariable( 'BasketError') );
        $http->removeSessionVariable( 'BasketError');
    }
}
//$tpl->setVariable( "removed_items", $removedItems);
$tpl->setVariable( "basket", $basket );
$tpl->setVariable( "module_name", 'shop' );
$tpl->setVariable( "vat_is_known", $basket->isVATKnown() );
$tpl->setVariable( "users", $all_users );
$tpl->setVariable( "users_count", $all_user_count );
$tpl->setVariable( "limit", $limit );
$tpl->setVariable( "view_parameters", $view_parameters );
$tpl->setVariable( "product", $product );

// Add shipping cost to the total items price and store the sum to corresponding template vars.
$shippingInfo = eZShippingManager::getShippingInfo( $basket->attribute( 'productcollection_id' ) );
if ( $shippingInfo !== null )
{
    // to make backwards compability with old version, allways set the cost inclusive vat.
    if ( ( isset( $shippingInfo['is_vat_inc'] ) and $shippingInfo['is_vat_inc'] == 0 ) or
         !isset( $shippingInfo['is_vat_inc'] ) )
    {
        $additionalShippingValues = eZShippingManager::vatPriceInfo( $shippingInfo );
        $shippingInfo['cost'] = $additionalShippingValues['total_shipping_inc_vat'];
        $shippingInfo['is_vat_inc'] = 1;
    }

    $totalIncShippingExVat  = $basket->attribute( 'total_ex_vat'  ) + $shippingInfo['cost'];
    $totalIncShippingIncVat = $basket->attribute( 'total_inc_vat' ) + $shippingInfo['cost'];

    $tpl->setVariable( 'shipping_info', $shippingInfo );
    $tpl->setVariable( 'total_inc_shipping_ex_vat', $totalIncShippingExVat );
    $tpl->setVariable( 'total_inc_shipping_inc_vat', $totalIncShippingIncVat );
}

$Result = array();
$Result['content'] = $tpl->fetch( "design:purchasebyteller/form.tpl" ) ;
$Result['path'] = array( array( 'url' => false,
                                'text' => 'form' ) );

return;

?>
