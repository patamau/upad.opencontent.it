<?php

class CSVSubscriptionsExporterFull extends AbstarctExporter
{
    private $CSVheaders = array();

    public function __construct( $parentNodeID, $classIdentifier )
    {
        $this->functionName = 'csv';
        parent::__construct( $parentNodeID, $classIdentifier );
    }

    function transformNode( eZContentObjectTreeNode $node )
    {
        if ( $node instanceof eZContentObjectTreeNode )
        {
            $object = $node->attribute( 'object' );
            $values = array();

            foreach( $object->attribute( 'contentobject_attributes' ) as $attribute )
            {

                $attributeIdentifier = $attribute->attribute( 'contentclass_attribute_identifier' );
                $datatypeString = $attribute->attribute( 'data_type_string' );

                if ( isset( $this->options['ExcludeAttributeIdentifiers'] ) && in_array( $attributeIdentifier, $this->options['ExcludeAttributeIdentifiers'] ) )
                    continue;
                if ( isset( $this->options['ExcludeDatatype'] ) && in_array( $datatypeString, $this->options['ExcludeDatatype'] ) )
                    continue;

                $attributeName = $attribute->attribute( 'contentclass_attribute_name' );
                if ( !isset( $this->CSVheaders[$attributeIdentifier] ) )
                {
                    if ($attributeIdentifier == 'user') {
                        $this->CSVheaders['user'] = 'Utente';
                        $this->CSVheaders['sesso'] = 'Sesso';
                        $this->CSVheaders['stato_nascita'] = 'Stato di nascita';
                        $this->CSVheaders['luogo_nascita'] = 'Luogo di nascita';
                        $this->CSVheaders['data_nascita'] = 'Data di nascita';
                        $this->CSVheaders['email'] = 'Email';
                        $this->CSVheaders['telefono'] = 'Telefono';
                        $this->CSVheaders['professione'] = 'Professione';
                        $this->CSVheaders['indirizzo_residenza'] = 'Indirizzo residenza';
                        $this->CSVheaders['luogo_residenza'] = 'Luogo di residenza';
                        $this->CSVheaders['cap_residenza'] = 'Cap';
                        $this->CSVheaders['codice_fiscale'] = 'Codice Fiscale';

                    } elseif($attributeIdentifier == 'invoices') {
                        $this->CSVheaders['numero_ricevute'] = 'Numero ricevute';
                        $this->CSVheaders['importo_ricevute'] = 'Importo ricevute';
                    } else {
                        $this->CSVheaders[$attributeIdentifier] = $attributeName;
                    }
                }

                if ($attributeIdentifier == 'invoices') {

                    $attributeContent = $attribute->content()->attribute('matrix');
                    $invoices = array();
                    $invices_amount = array();
                    $invoices_data = array();
                    foreach ( $attributeContent['rows']['sequential'] as $row) {
                        $invoice = eZUpadInvoice::fetch($row['columns'][0]);
                        $invoices []= $invoice->attribute('invoice_id') .'/'. $invoice->attribute('year');
                        $amount = new eZCurrency($invoice->attribute('total'));
                        $invices_amount[]= $amount->toString();
                    }
                    $invoices_data []= implode( ',', $invoices );
                    $invoices_data []= implode( ',', $invices_amount );
                    $attributeStringContent = $invoices_data;

                } elseif ($attributeIdentifier == 'user') {
                    $user = eZContentObject::fetch( $attribute->content()->attribute('id') );
                    $userDatamap = $user->dataMap();
                    //print_r($userDatamap);
                    $user_account = json_decode($userDatamap['user_account']->DataText);
                    $user_data = array();
                    $user_data[] = $userDatamap['first_name']->toString() . ' ' . $userDatamap['last_name']->toString();
                    $user_data[] = $userDatamap['sesso']->toString();
                    $user_data[] = $userDatamap['stato_nascita']->toString();
                    $user_data[] = $userDatamap['luogo_nascita']->toString();
                    $user_data[] = strftime('%d-%m-%Y', strtotime($userDatamap['data_nascita']->toString()));
                    $user_data[] = $user_account->email;
                    $user_data[] = $userDatamap['telefono']->toString();
                    $user_data[] = $userDatamap['professione']->toString();
                    $user_data[] = $userDatamap['indirizzo_residenza']->toString();
                    $user_data[] = $userDatamap['luogo_residenza']->toString();
                    $user_data[] = $userDatamap['cap_residenza']->toString();
                    $user_data[] = $userDatamap['codice_fiscale']->attribute('data_text');
                    $attributeStringContent = $user_data;
                } else {
                    switch ( $datatypeString )
                    {
                        case 'ezobjectrelation':
                        {
                            $attributeStringContent = $attribute->content()->attribute('name');
                        } break;

                        case 'ezobjectrelationlist':
                        {
                            $attributeContent = $attribute->content();
                            $relations = $attributeContent['relation_list'];

                            $relatedNames = array();
                            foreach ($relations as $relation)
                            {
                                $related = eZContentObject::fetch( $relation['contentobject_id'] );
                                if ( $related )
                                {
                                    $relatedNames[] = $related->attribute( 'name' );
                                    eZContentObject::clearCache( $related->attribute( 'id' ) );
                                }
                            }
                            $attributeStringContent = implode( ', ', $relatedNames );
                        } break;

                        case 'ezxmltext':
                        {
                            $text = str_replace( '"', "'", $attribute->content()->attribute('output')->outputText() );
                            $text = strip_tags( $text );
                            $text = str_replace( ';', ',', $text );
                            $text = str_replace( array("\n","\r"), "", $text );
                            $attributeStringContent = $text;
                        } break;

                        case 'ezbinaryfile':
                        {
                            $attributeStringContent = '';
                            if ( $attribute->hasContent() )
                            {
                                $file = $attribute->content();
                                $filePath = "content/download/{$attribute->attribute('contentobject_id')}/{$attribute->attribute('id')}/{$attribute->content()->attribute( 'original_filename' )}";
                                $attributeStringContent = eZSys::hostname() . '/' . $filePath;
                            }
                        } break;

                        default:
                            $attributeStringContent = '';
                            if ( $attribute->hasContent() )
                                $attributeStringContent = $attribute->toString();
                            break;
                    }
                }
                if (is_array($attributeStringContent)) {
                    $values = array_merge($values, $attributeStringContent);
                } else {
                    $values[] = $attributeStringContent;
                }
            }

            eZContentObject::clearCache( $object->attribute( 'id' ) );
        }
        return $values;
    }

    function handleDownload()
    {
        $filename = $this->filename . '.csv';
        header( 'X-Powered-By: eZ Publish' );
        header( 'Content-Description: File Transfer' );
        header( 'Content-Type: text/csv; charset=utf-8' );
        header( "Content-Disposition: attachment; filename=$filename" );
        header( "Pragma: no-cache" );
        header( "Expires: 0" );

        $count = $this->fetchCount();
        $length = 50;
        // Sovrascrive l'attribute filter
        //$this->setFetchParameters( array( 'Offset' => 0 , 'Limit' => $length ) );
        $this->fetchParameters['Offset'] = 0;
        $this->fetchParameters['Limit'] = $length;


        $output = fopen('php://output', 'w');
        $runOnce = false;
        do
        {

            $items = $this->fetch();

            foreach ( $items as $item )
            {
                $values = $this->transformNode( $item );
                if ( !$runOnce )
                {
                    fputcsv( $output, array_values( $this->CSVheaders ), $this->options['CSVDelimiter'], $this->options['CSVEnclosure'] );
                    $runOnce = true;
                }
                fputcsv( $output, $values, $this->options['CSVDelimiter'], $this->options['CSVEnclosure'] );
                flush();
            }
            $this->fetchParameters['Offset'] += $length;

        } while ( count( $items ) == $length );
    }
}

?>
