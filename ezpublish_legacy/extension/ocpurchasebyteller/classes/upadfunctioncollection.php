<?php

class UpadFunctionCollection
{
    public static function fetchInvoice( $id )
    {
        return array( 'result' => eZUpadInvoice::fetch( $id ) );
    }
}