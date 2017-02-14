<?php

class UpadInvoice
{
    protected $number;
    protected $currency;
    protected $locale;
    protected $symbol;
    protected $products;
    protected $items;
    protected $reference_order;
    protected $ente;
    protected $user;
    protected $product_total_ex_vat;
    protected $product_total_inc_vat;

    public static function createFromProductList( array $productList, eZOrder $order, eZContentObject $ente, eZUser $user )
    {
        $invoice = new UpadInvoice( $ente, $user );
        $invoice->setProductList( $productList, $order );
        return $invoice->storeProductsInvoice();
    }

    public static function createFromItemList( array $itemList, eZContentObject $ente, eZUser $user )
    {
        $invoice = new UpadInvoice( $ente, $user );
        $invoice->setItemList( $itemList );
        return $invoice->storeItemsInvoice();
    }

    protected function __construct( eZContentObject $ente, eZUser $user )
    {
        $this->ente = $ente;
        $this->user = $user;
    }

    public function setProductList( array $productList, eZOrder $order )
    {
        $this->products = $productList;
        $this->reference_order = $order;

        $this->currency = eZFunctionHandler::execute( 'shop', 'currency', array( 'code' => $this->reference_order->attribute( 'productcollection' )->attribute( 'currency_code' ) ) );
        if ( $this->currency )
        {
            $this->locale = $this->currency->attribute( 'locale' );
            $this->symbol = $this->currency->attribute( 'symbol' );
        }

        $total1 = 0.0;
        $total2 = 0.0;
        foreach ( $this->products as $item )
        {
            $total1 += $item['total_price_ex_vat'];
            $total2 += $item['total_price_inc_vat'];
        }
        $this->product_total_ex_vat = round( $total1, 2 );
        $this->product_total_inc_vat = round( $total2, 2 );

    }

    public function storeProductsInvoice()
    {
        $tpl = eZTemplate::factory();
        $tpl->resetVariables();
        $tpl->setVariable( "invoice", $this );
        $data = $tpl->fetch( "design:invoice/data_products.tpl" );
        return eZUpadInvoice::create( $this->reference_order->attribute( 'id' ), $this->ente->attribute( 'id' ), $this->user->id(), $data, $this->product_total_inc_vat );
    }

    public function setItemList( array $itemList )
    {
        $this->items = $itemList;

        $this->currency = eZFunctionHandler::execute( 'shop', 'currency', array( 'code' => 'EUR' ) ); //@todo
        if ( $this->currency )
        {
            $this->locale = $this->currency->attribute( 'locale' );
            $this->symbol = $this->currency->attribute( 'symbol' );
        }

        $total1 = 0.0;
        foreach ( $this->items as $item )
        {
            $total1 += $item['total'];
        }
        $this->product_total_inc_vat = round( $total1, 2 );
    }

    public function storeItemsInvoice()
    {
        $tpl = eZTemplate::factory();
        $tpl->resetVariables();
        $tpl->setVariable( "invoice", $this );
        $data = $tpl->fetch( "design:invoice/data_items.tpl" );
        $invoice =  eZUpadInvoice::create( 0, $this->ente->attribute( 'id' ), $this->user->id(), $data, $this->product_total_inc_vat );
        // Creo i meta per la fattura
        UpadInvoiceMeta::createFromItems($invoice, $this->items);
        return $invoice;
    }

    public function attributes()
    {
        return array(
            'number',
            'currency',
            'locale',
            'symbol',
            'products',
            'items',
            'reference_order',
            'ente',
            'user',
            'product_total_ex_vat',
            'product_total_inc_vat',
        );
    }

    public function hasAttribute( $key )
    {
        return in_array( $key, $this->attributes() );
    }

    public function attribute( $key )
    {
        if ( isset( $this->{$key} ) )
        {
            return $this->{$key};
        }
        eZDebug::writeError( "Attribute $key not found", __METHOD__ );
        return false;
    }
}
