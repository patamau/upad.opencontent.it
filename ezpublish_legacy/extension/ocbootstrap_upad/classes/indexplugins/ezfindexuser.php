<?php

class ezfIndexUser implements ezfIndexPlugin
{
    public function modify( eZContentObject $contentObject, &$docList )
    {
            
        $version = $contentObject->currentVersion();
        if( $version === false )
        {
            return;
        }
        $availableLanguages = $version->translationList( false, false );
        foreach ( $availableLanguages as $languageCode )
        {
            //$docList[$languageCode]->addField('extra_test_t', $contentObject->attribute( 'name' ) );
        }

    }
}