<?php


class italianTaxCode extends eZDataType
{

    const DEBUG = 0;
    const DATA_TYPE_STRING = 'italiantaxcode';
    const MAX_LENGTH = 16;


    /**
     * Construct
     *
     */
    public function __construct()
    {
        parent::__construct( self::DATA_TYPE_STRING, 'Codice Fiscale',
                array( 'serialize_supported' => true,
                                  'object_serialize_map' => array( 'data_text' => 'text' ) ) );
    }

    function toString( $contentObjectAttribute )
    {
        return $contentObjectAttribute->attribute( 'data_text' );
    }

    function fromString( $contentObjectAttribute, $string )
    {
        return $contentObjectAttribute->setAttribute( 'data_text', $string );
    }

    function initializeObjectAttribute( &$contentObjectAttribute, $currentVersion, &$originalContentObjectAttribute )
    {
        if ( $currentVersion != false )
        {
            $dataText = $originalContentObjectAttribute->attribute( "data_text" );
            $contentObjectAttribute->setAttribute( "data_text", $dataText );
        }
        else
        {
            $contentClassAttribute =& $contentObjectAttribute->contentClassAttribute();
            $default = $contentClassAttribute->attribute( '' );
            if ( $default !== "" )
            {
                $contentObjectAttribute->setAttribute( "data_text", $default );
            }
        }
    }

    function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        return $this->validateAttributeHTTPInput( $http, $base, $contentObjectAttribute, false );
    }

    function validateCollectionAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        return $this->validateAttributeHTTPInput( $http, $base, $contentObjectAttribute, true );
    }

    function validateAttributeHTTPInput( $http, $base, $contentObjectAttribute, $isInformationCollector )
    {
        if ( $http->hasPostVariable( $base . '_cf_data_text_' . $contentObjectAttribute->attribute( 'id' ) ) )
        {
            $cf = $http->postVariable( $base . '_cf_data_text_' . $contentObjectAttribute->attribute( 'id' ) );
            $classAttribute = $contentObjectAttribute->contentClassAttribute();

            // Elimino controllo formale e unicità (Richiesta settembre 2015)
            /*
            if ( strlen($cf) > self::MAX_LENGTH && self::MAX_LENGTH > 0 )
            {
                $contentObjectAttribute->setValidationError( sprintf( 'Il valore inserito è troppo lungo. Il massimo numero di caratteri ammessi è %d.' ), $maxLen );
                return eZInputValidator::STATE_INVALID;
            }
            return self::validateUniqueStringHTTPInput( $cf, $contentObjectAttribute );
            */
        }
        return eZInputValidator::STATE_ACCEPTED;
    }

    function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        if ( $http->hasPostVariable( $base . '_cf_data_text_' . $contentObjectAttribute->attribute( "id" ) ) )
        {
            $data = $http->postVariable( $base . '_cf_data_text_' . $contentObjectAttribute->attribute( "id" ) );
            $contentObjectAttribute->setAttribute( "data_text", $data );
            return true;
        }
        return false;
    }

    function fetchCollectionAttributeHTTPInput( $collection, $collectionAttribute, $http, $base, $contentObjectAttribute )
    {
        if ( $http->hasPostVariable( $base . '_cf_data_text_' . $contentObjectAttribute->attribute( "id" ) ) )
        {
            $data = $http->postVariable( $base . '_cf_data_text_' . $contentObjectAttribute->attribute( "id" ) );
            $collectionAttribute->setAttribute( "data_text", $data );
            return true;
        }
        return false;
    }

    function fetchClassAttributeHTTPInput( $http, $base, $classAttribute )
    {
        $attributeContent = $this->classAttributeContent( $classAttribute );
        $classAttributeID = $classAttribute->attribute( 'id' );

        // Name
        if ( $http->hasPostVariable( $base . "_cf_name_field_". $classAttributeID ) )
        {
            $value = $http->postVariable( $base . "_cf_name_field_". $classAttributeID );
            $classAttribute->setAttribute( 'data_text1', $value );
        }

        // Lastname
        if ( $http->hasPostVariable( $base . "_cf_lastname_field_". $classAttributeID ) )
        {
            $value = $http->postVariable( $base . "_cf_lastname_field_". $classAttributeID );
            $classAttribute->setAttribute( 'data_text2', $value );
        }

        // Date
        if ( $http->hasPostVariable( $base . "_cf_date_field_". $classAttributeID ) )
        {
            $value = $http->postVariable( $base . "_cf_date_field_". $classAttributeID );
            $classAttribute->setAttribute( 'data_text3', $value );
        }

        // Gender
        if ( $http->hasPostVariable( $base . "_cf_gender_field_". $classAttributeID ) )
        {
            $value = $http->postVariable( $base . "_cf_gender_field_". $classAttributeID );
            $classAttribute->setAttribute( 'data_text4', $value );
        }

        // City
        if ( $http->hasPostVariable( $base . "_cf_city_field_". $classAttributeID ) )
        {
            $value = $http->postVariable( $base . "_cf_city_field_". $classAttributeID );
            $classAttribute->setAttribute( 'data_text5', $value );
        }

        return true;
    }


    function classAttributeContent($classAttribute)
    {

      $output['name_field'] = $classAttribute->attribute( 'data_text1' );
      $output['lastname_field'] = $classAttribute->attribute( 'data_text2' );
      $output['date_field'] = $classAttribute->attribute( 'data_text3' );
      $output['gender_field'] = $classAttribute->attribute( 'data_text4' );
      $output['city_field'] = $classAttribute->attribute( 'data_text5' );
      return $output;
    }


    function hasObjectAttributeContent( $contentObjectAttribute )
    {
        return trim( $contentObjectAttribute->attribute( 'data_text' ) ) != '';
    }

    /*!
     Store the content.
    */
    function storeObjectAttribute( $attribute )
    {
    }

    /*!
     Returns the content.
    */
    function objectAttributeContent( $contentObjectAttribute )
    {
        return $contentObjectAttribute->attribute( "data_text" );
    }

    /*!
     Returns the meta data used for storing search indeces.
    */
    function metaData( $contentObjectAttribute )
    {
        return $contentObjectAttribute->attribute( "data_text" );
    }

    /*!
     Returns the text.
    */
    function title( $contentObjectAttribute )
    {
        return  $contentObjectAttribute->attribute( "data_text" );
    }

    function isIndexable()
    {
        return true;
    }

    function isInformationCollector()
    {
        return true;
    }


    /**
     * This method checks if given string does exist in any content object
     * attributes with the same id, with the exception for those being versions
     * of the same content object. If given string exists anywhere, in published
     * or unpublished versions, drafts, trash, this string will be excluded.
     *
     * More information in the ini file uniquedatatypes.ini.append.php
     *
     * @param string $data
     * @param object $contentObjectAttribute
     * @return integer
     */
    private static function validateUniqueStringHTTPInput( $data, $contentObjectAttribute )
    {
        $contentObjectID = $contentObjectAttribute->ContentObjectID;
        $contentClassAttributeID = $contentObjectAttribute->ContentClassAttributeID;
        $db = eZDB::instance();

        if( true )
        {
            $query = "SELECT COUNT(*) AS datacounter
				FROM ezcontentobject co, ezcontentobject_attribute coa
				WHERE co.id = coa.contentobject_id
				AND co.current_version = coa.version
				AND coa.contentobject_id <> ".$db->escapeString( $contentObjectID )."
				AND coa.contentclassattribute_id = ".$db->escapeString( $contentClassAttributeID )."
				AND coa.data_text = '".$db->escapeString( $data )."'";
        }
        else
        {
            $query = "SELECT COUNT(*) AS datacounter
				FROM ezcontentobject_attribute
				WHERE contentobject_id <> ".$db->escapeString( $contentObjectID )."
				AND contentclassattribute_id = ".$db->escapeString( $contentClassAttributeID )."
				AND data_text = '".$db->escapeString( $data )."'";
        }

        if( self::DEBUG )
        {
            eZDebug::writeDebug('Query: '.$query, 'italianTaxCode::validateUniqueStringHTTPInput');
        }

        $result = $db->arrayQuery( $query );
        $resultCount = $result[0]['datacounter'];

        if( $resultCount )
        {
            $contentObjectAttribute->setValidationError( 'Il Codice fiscale inserito è già prensente');
            return eZInputValidator::STATE_INVALID;
        }

        return eZInputValidator::STATE_ACCEPTED;
    }
}

eZDataType::register( italianTaxCode::DATA_TYPE_STRING, "italianTaxCode" );

?>
