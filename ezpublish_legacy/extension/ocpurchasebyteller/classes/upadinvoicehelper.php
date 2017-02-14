<?php

class UpadInvoiceHelper
{
    protected $order;

    protected $invoices = array();
    
    public function __construct( eZOrder $order )
    {
        $this->order = $order;
        if ( !$this->order instanceof eZOrder )
        {
            throw new Exception( "Order not found" );
        }
        $this->invoices = eZUpadInvoice::fetchByOrder( $this->order->attribute( 'id' ) );
        if ( !$this->invoices )
        {
            $this->invoices = $this->generateInvoices();
        }
    }
    
    public function increaseDownloadCount()
    {
        foreach( $this->invoices as $invoice )
        {
            $invoice->increaseDownloadCount();
        }
    }
    
    protected function generateInvoices()
    {
        $invoices = array();
        $data = $this->parseOrder();        
        foreach( $data as $enteId => $products )
        {
            $ente = eZContentObject::fetch( $enteId );
            $invoices[] = UpadInvoice::createFromProductList( $products, $this->order, $ente, $this->order->attribute( 'user' ) );
        }
        return $invoices;
    }
    
    public function attributes()
    {
        return array( 'invoices' );
    }
    
    public function hasAttribute( $key )
    {
        return in_array( $key, $this->attributes() );
    }
    
    public function attribute( $key )
    {
        if ( $key == 'invoices' )
        {
            return $this->invoices;
        }
        eZDebug::writeError( "Attribute $key not found", __METHOD__ );
        return false;
    }
    
    public function parseOrder()
    {
        $data = array();
        $products = $this->order->attribute( 'product_items' );
        foreach( $products as $product )
        {
            $object = $product['item_object']->attribute( 'contentobject' );
            if ( $object instanceof eZContentObject )
            {
                $dataMap = array();
                if ( $object->attribute( 'class_identifier' ) == 'corso' )
                {
                    $dataMap = $object->attribute( 'data_map' );
                }
                elseif ( $object->attribute( 'class_identifier' ) == 'materiale_didattico' )
                {
                    $node = eZContentObjectTreeNode::fetch( $item['node_id'] );
                    if ( $node instanceof eZContentObjectTreeNode )
                    {
                        $dataMap = $node->attribute( 'parent' )->attribute( 'data_map' );
                    }
                }
                if ( isset( $dataMap['ente'] ) && $dataMap['ente']->attribute( 'has_content' ) )
                {
                    $enteIds = explode( '-', $dataMap['ente']->toString() );
                    $enteId = array_shift( $enteIds );
                    $ente = eZContentObject::fetch( $enteId );
                    if ( $ente instanceof eZContentObject )
                    {
                        if ( !isset( $data[$ente->attribute( 'id' )] ) )
                        {
                            $data[$ente->attribute( 'id' )] = array( $product );
                        }
                        else
                        {
                            $data[$ente->attribute( 'id' )][] = $product;   
                        }                        
                    }
                }
            }
        }
        
        $testCount = 0;
        foreach( $data as $id => $products )
        {
            $testCount += count( $products );
        }
        
        if ( $testCount != count( $this->order->attribute( 'product_items' ) ) )
        {
            throw new Exception( "Non è possibile generare la fattura" );
        }
        return $data;
    }
}
