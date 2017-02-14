<?php

class italianProvincesAndCitiesType extends eZDataType
{

    // Define the name of datatype string
    const DATA_TYPE_STRING = "italianprovincesandcities";

    private $tableProvinces = 'ocprovince';
    private $tableCities = 'occomuni';

    /*!
     Construction of the class, note that the second parameter in eZDataType
     is the actual name showed in the datatype dropdown list.
    */
    function __construct()
    {
      parent::__construct( self::DATA_TYPE_STRING, "Province e comune",
                             array( 'serialize_supported' => true,
                                    'object_serialize_map' => array( 'data_text' => 'text' ) ) );
    }

    function toString( $contentObjectAttribute )
    {

        $value = explode( ',', $contentObjectAttribute->attribute( "data_text" ) );
        if (count($value) > 1) {
            $db = eZDB::instance();
            $query = sprintf("SELECT provincia as label FROM %s WHERE id = %d", $this->tableProvinces, $value[0]);
            $result = $db->arrayQuery($query);
            $province = $result[0]['label'];

            $db = eZDB::instance();
            $query = sprintf("SELECT comune AS label FROM %s WHERE id = %d", $this->tableCities, $value[1]);
            $result = $db->arrayQuery($query);
            $city = $result[0]['label'];
            eZDebug::writeDebug('Doppia ' . $city . '-' . $province);

            return $city . ' (' . $province . ')';

        } else {
            $db = eZDB::instance();
            $query = sprintf("SELECT provincia as label FROM %s WHERE id = %d", $this->tableProvinces, $value[0]);
            $result = $db->arrayQuery($query);
            eZDebug::writeDebug('Singola ' . $result);
            if (is_array($result) && count($result) == 1) {
                return $result[0]['label'];
            }
        }
        //return $contentObjectAttribute->attribute( 'data_text' );
    }

    function fromString( $contentObjectAttribute, $string )
    {
        return $contentObjectAttribute->setAttribute( 'data_text', $string );
    }

    function initializeObjectAttribute( $contentObjectAttribute, $currentVersion, $originalContentObjectAttribute )
    {
        if ( $currentVersion != false )
        {
            $dataText = $originalContentObjectAttribute->attribute( "data_text" );
            $contentObjectAttribute->setAttribute( "data_text", $dataText );
        }
        else
        {
            $contentClassAttribute =& $contentObjectAttribute->contentClassAttribute();
            $default = $contentClassAttribute->attribute( EZ_DATATYPESTRING_DEFAULT_COUNTRY_FIELD );
            if ( $default !== "" )
            {
                $contentObjectAttribute->setAttribute( "data_text", $default );
            }
        }
    }

    /*!
      Validates the input and returns true if the input was
      valid for this datatype.
    */

    function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
      $variable = $base . "_data_int_" . $contentObjectAttribute->attribute( "id" );
      eZDebug::writeDebug( $contentObjectAttribute );
      if ( $http->hasPostVariable( $variable ))
      {
        $data = $http->postVariable( $variable );
        eZDebug::writeDebug( $data );
        if( !$contentObjectAttribute->validateIsRequired() && ( $data == "" ) )
        {
          return eZInputValidator::STATE_ACCEPTED;
        }
        if (is_numeric($data))
          return eZInputValidator::STATE_ACCEPTED;
        else
          $contentObjectAttribute->setValidationError( ezi18n( 'kernel/classes/datatypes', 'You must select an option' ));
      }
      else
      {
        return eZInputValidator::STATE_ACCEPTED;
      }
      return eZInputValidator::STATE_INVALID;
    }



    /*
    function validateCollectionAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        $variable = $base . "_data_int_" . $contentObjectAttribute->attribute( "id" );
        eZDebug::writeDebug( $contentObjectAttribute );
        if ( $http->hasPostVariable($variable ))
        {
          $data = $http->postVariable($variable );
          eZDebug::writeDebug( $data );
          if( !$contentObjectAttribute->validateIsRequired() && ( $data == "" ) )
          {
            return eZInputValidator::STATE_ACCEPTED;
          }
          if (is_numeric($data))
            return eZInputValidator::STATE_ACCEPTED;
          else
            $contentObjectAttribute->setValidationError( ezi18n( 'kernel/classes/datatypes', 'You must select an option' ));
        }
        else
        {
          return eZInputValidator::STATE_ACCEPTED;
        }
        return eZInputValidator::STATE_INVALID;
    }
    */

    function validateCollectionAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        return $this->validateAttributeHTTPInput( $http, $base, $contentObjectAttribute, true );
    }




    function deleteStoredObjectAttribute( $contentObjectAttribute, $version = null )
    {
        $contentObjectID = $contentObjectAttribute->ContentObjectID;
    }


 /*!
 */

    /*
    function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        $variable = $base . "_data_int_" . $contentObjectAttribute->attribute( "id" );
        if ( $http->hasPostVariable($variable ) )
        {
          $data = $http->postVariable( $base . "_data_int_" . $contentObjectAttribute->attribute( "id" ));
          if (! is_numeric($data))
            $data = null;
          $contentObjectAttribute->setAttribute( "data_int", $data );
          return true;
        }
        return false;
    }
    */

    function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        if ( $http->hasPostVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) )  &&
             $http->hasPostVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) . '_city' ))
        {
            $data = array();
            $data []= $http->postVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) );
            $data [] = $http->postVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" )  . '_city' );

            $dataString = implode( ',', $data );

            $contentObjectAttribute->setAttribute( "data_text", $dataString );

            eZDebug::writeDebug('Doppia ' . $contentObjectAttribute->attribute( 'data_text' ));

            return true;
        } else {

            if ( $http->hasPostVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) ) ){
                $data = $http->postVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) );
                $contentObjectAttribute->setAttribute( "data_text", $data );
            }

            eZDebug::writeDebug('Singola ' . $contentObjectAttribute->attribute( 'data_text' ));


            return true;
        }
        return false;
    }


    /*!
     Fetches the http post variables for collected information
    */
    /*
    function fetchCollectionAttributeHTTPInput( $collection, $collectionAttribute, $http, $base, $contentObjectAttribute )
    {
      $variable = $base . "_data_int_" . $contentObjectAttribute->attribute( "id" );
      if ( $http->hasPostVariable($variable ) )
      {
        $data = $http->postVariable( $base . "_data_int_" .
                                      $contentObjectAttribute->attribute( "id" )
                                    );
        if (! is_numeric($data))
          $data = null;
        $collectionAttribute->setAttribute( "data_int", $data );
        return true;
      }
      return false;
    }
    */

    function fetchCollectionAttributeHTTPInput( $collection, $collectionAttribute, $http, $base, $contentObjectAttribute )
    {
        if ( $http->hasPostVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) )  &&
             $http->hasPostVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) . '_city' ))
        {
            $data = array();
            $data []= $http->postVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) );
            $data [] = $http->postVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" )  . '_city' );

            $dataString = implode( ',', $data );

            $collectionAttribute->setAttribute( "data_text", $dataString );

            return true;
        } else {
            if ( $http->hasPostVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) ) ){

                $data = $http->postVariable( $base . '_data_int_' . $contentObjectAttribute->attribute( "id" ) );
                $collectionAttribute->setAttribute( "data_text", $data );
            }
            return true;
        }
        return false;
    }

    /*!
     Store the content. Since the content has been stored in function
     fetchObjectAttributeHTTPInput(), this function is with empty code.
    */
    function storeObjectAttribute( $contentObjectattribute )
    {
    }

    /*!
     Returns the meta data used for storing search indices.
    */
    function metaData( $contentObjectAttribute )
    {
        $contentClassAttribute = $contentObjectAttribute->contentClassAttribute();
        $value = explode( ',', $contentObjectAttribute->attribute( "data_text" ) );

        if (count($value) > 1) {
            $db = eZDB::instance();
            $query = sprintf("SELECT provincia as label FROM %s WHERE id = %d", $this->tableProvinces, $value[0]);
            $result = $db->arrayQuery($query);
            $province = $result[0]['label'];

            $db = eZDB::instance();
            $query = sprintf("SELECT comune AS label FROM %s WHERE id = %d", $this->tableCities, $value[1]);
            $result = $db->arrayQuery($query);
            $city = $result[0]['label'];


            eZDebug::writeDebug('Doppia ' . $city . '-' . $province);

            return $city . '-' . $province;

        } else {
            $db = eZDB::instance();
            $query = sprintf("SELECT provincia as label FROM %s WHERE id = %d", $this->tableProvinces, $value[0]);
            $result = $db->arrayQuery($query);

            eZDebug::writeDebug('Singola ' . $result);

            if (is_array($result) && count($result) == 1) {
                return $result[0]['label'];
            }

        }
        return '';
    }

    /*!
     Returns the text.
    */
    function title( $contentObjectAttribute, $name = null )
    {
      return $this->metaData($contentObjectAttribute);
    }

    function isIndexable()
    {
      return true;
    }

    function isInformationCollector()
    {
      return true;
    }

    function sortKey( $contentObjectAttribute )
    {
      return $this->metaData($contentObjectAttribute);
    }

    function sortKeyType()
    {
      return 'string';
    }

    function hasObjectAttributeContent( $contentObjectAttribute )
    {
      return trim( $contentObjectAttribute->attribute( 'data_text' ) ) != '';
    }


    /*!
     Returns the content.
    */
    function objectAttributeContent( $contentObjectAttribute )
    {
        $contentClassAttribute = $contentObjectAttribute->contentClassAttribute();
        $value = explode( ',', $contentObjectAttribute->attribute( "data_text" ) );


        // Province
        $table = $this->tableProvinces;
        $default  = $contentClassAttribute->attribute( 'data_int1' );
        $db = eZDB::instance();
        $query = "SELECT id AS val, provincia AS label, sigla FROM $table ORDER BY label ASC";
        $result = $db->arrayQuery($query);
        $output['provinces']['options'] = $result;
        $output['provinces']['default'] = $default;
        $output['provinces']['value']   = $value[0];

        if ($value[0]) {
            //Comuni
            $default  = $contentClassAttribute->attribute( 'data_int1' );
            $db = eZDB::instance();

            $query = sprintf("SELECT sigla FROM %s WHERE id = %d LIMIT 1", $this->tableProvinces, $value[0]);
            $result = $db->arrayQuery($query);

            $query = sprintf("SELECT id AS val, comune AS label
                              FROM {$this->tableCities}
                              WHERE provincia LIKE '%s'
                              ORDER BY label ASC", $result[0]['sigla']);
            $result = $db->arrayQuery($query);
            $output['cities']['options'] = $result;
            $output['cities']['default'] = $default;
            $output['cities']['value']   = $value[1];
        }
        return $output;
    }

    function fetchClassAttributeHTTPInput( $http, $base, $classAttribute )
    {
        $attributeContent = $this->classAttributeContent( $classAttribute );
        $classAttributeID = $classAttribute->attribute( 'id' );

        // Cap
        if ( $http->hasPostVariable( $base . "_ipac_cap_field_". $classAttributeID ) )
        {
            $value = $http->postVariable( $base . "_ipac_cap_field_". $classAttributeID );
            $classAttribute->setAttribute( 'data_text1', $value );
        }

        return true;
    }


    function classAttributeContent($classAttribute)
    {

      $output['cap_field'] = $classAttribute->attribute( 'data_text1' );
      return $output;
    }


}

eZDataType::register( italianProvincesAndCitiesType::DATA_TYPE_STRING, "italianProvincesAndCitiesType" );

?>
