<?php


class ezfIndexSubscriptionsInvoices implements ezfIndexPlugin
{
    /**
     * The modify method gets the current content object AND the list of
     * Solr Docs (for each available language version).
     *
     *
     * @param eZContentObject $contentObect
     * @param array $docList
     */
    public function modify(eZContentObject $contentObject, &$docList)
    {

        $dataMap = $contentObject->dataMap();
        $matrix = $dataMap['invoices']->attribute('content');
        $rows = $matrix->attribute('rows');

        foreach ($rows['sequential'] as $r) {
            $availableLanguages = $contentObject->currentVersion()->translationList( false, false );
            foreach ( $availableLanguages as $languageCode )
            {
                $docList[$languageCode]->addField('extra_invoice_id____si', $r['columns'][0] );
            }
        }
        /*
        $contentNode = $contentObject->attribute( 'main_node' );
        $parentNode = $contentNode->attribute( 'parent' );
        if ( $parentNode instanceof eZContentObjectTreeNode )
        {
            $parentObject       = $parentNode->attribute( 'object' );
            $parentVersion      = $parentObject->currentVersion();
            if( $parentVersion === false )
            {
                return;
            }
            $availableLanguages = $parentVersion->translationList( false, false );
            foreach ( $availableLanguages as $languageCode )
            {
                $docList[$languageCode]->addField('extra_parent_node_name_t', $parentObject->name( false, $languageCode ) );
            }
        }*/

    }
}


?>
