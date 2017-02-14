<?php

class italianProvincesType extends eZDataType
{

    // Define the name of datatype string
    const DATA_TYPE_STRING = "italianprovinces";

    private $table = 'ocprovince';

    /*!
     Construction of the class, note that the second parameter in eZDataType
     is the actual name showed in the datatype dropdown list.
    */
    function __construct()
    {
      parent::__construct( self::DATA_TYPE_STRING, "Province Italiane",
                             array( 'serialize_supported' => true,
                                    'object_serialize_map' => array( 'data_int' => 'value' ) ) );
    }


  /*!
    Validates the input and returns true if the input was
    valid for this datatype.
  */
  function validateObjectAttributeHTTPInput( $http, $base,
                                               $contentObjectAttribute )
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

  function deleteStoredObjectAttribute( $contentObjectAttribute, $version = null )
  {
    $contentObjectID = $contentObjectAttribute->ContentObjectID;
  }


 /*!
 */

   function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
   {
     $variable = $base . "_data_int_" . $contentObjectAttribute->attribute( "id" );
     if ( $http->hasPostVariable($variable ) )
     {
       $data = $http->postVariable( $base . "_data_int_" .
                                     $contentObjectAttribute->attribute( "id" )
                                   );
       if (! is_numeric($data))
         $data = null;
       $contentObjectAttribute->setAttribute( "data_int", $data );
       return true;
     }
     return false;
   }

   /*!
    Fetches the http post variables for collected information
   */
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
    //
    $index_value = $contentObjectAttribute->attribute( "data_int" );
    $result=array();
    if (is_numeric($index_value))
    {
      //$table = $contentClassAttribute->attribute( 'data_text1' );
      //$index = $contentClassAttribute->attribute( 'data_text2' );
      //$name  = $contentClassAttribute->attribute( 'data_text3' );
      $table = $this->table;
      $index = 'id';
      $name  = 'provincia';
      $db = eZDB::instance();
      $query = "SELECT $name as label FROM $table WHERE $index = ".$contentObjectAttribute->attribute( "data_int" );
      $result = $db->arrayQuery($query);
    }
    if (is_array($result) && count($result) == 1)
      return $result[0]['label'];
    else
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
    return is_numeric($contentObjectAttribute->attribute( "data_int" ));
  }


  /*!
   Returns the content.
  */
  function objectAttributeContent( $contentObjectAttribute )
  {
      $contentClassAttribute = $contentObjectAttribute->contentClassAttribute();
      //
      //$table = $contentClassAttribute->attribute( 'data_text1' );
      //$index = $contentClassAttribute->attribute( 'data_text2' );
      //$name  = $contentClassAttribute->attribute( 'data_text3' );
      $table = $this->table;
      $index = 'id';
      $name  = 'provincia';
      $default  = $contentClassAttribute->attribute( 'data_int1' );
      $db = eZDB::instance();
      $query = "SHOW COLUMNS FROM $table";
      $result = $db->arrayQuery($query);
      $order = 'ORDER BY label';
      foreach ($result as $row)
      {
        if ($row['Field'] == 'order')
        {
          $order = 'ORDER BY `order`, label';
          break;
        }
      }
      $query = "SELECT $index as val, $name as label, sigla FROM $table ".$order;
      $result = $db->arrayQuery($query);
      $output['options'] = $result;
      $output['default'] = $default;
      $output['value'] = $contentObjectAttribute->attribute( "data_int" );
      return $output;
  }

  function classAttributeContent($classAttribute)
  {
    //$table = $classAttribute->attribute( 'data_text1' );
    //$index = $classAttribute->attribute( 'data_text2' );
    //$name  = $classAttribute->attribute( 'data_text3' );
    $table = $this->table;
    $index = 'id';
    $name  = 'provincia';
    $default  = $classAttribute->attribute( 'data_int1' );
    $db = eZDB::instance();
      $query = "SHOW COLUMNS FROM $table";
      $result = $db->arrayQuery($query);
      $order = 'ORDER BY label';
      foreach ($result as $row)
      {
        if ($row['Field'] == 'order')
        {
          $order = 'ORDER BY `order`, label';
          break;
        }
      }
      $query = "SELECT $index as val, $name as label FROM $table ".$order;
    $result = $db->arrayQuery($query);
    $output['options'] = $result;
    $output['default'] = $default;
    return $output;
  }


    /*!
     Sets the default value.
    */

    /*
    Not sure I need this
    */
    function initializeObjectAttribute( $contentObjectAttribute, $currentVersion, $originalContentObjectAttribute )
    {
        if ( $currentVersion == false )
        {
          $contentClassAttribute = $contentObjectAttribute->contentClassAttribute();
          //
          //$table = $contentClassAttribute->attribute( 'data_text1' );
          //$index = $contentClassAttribute->attribute( 'data_text2' );
          //$name  = $contentClassAttribute->attribute( 'data_text3' );
          $db = eZDB::instance();
          $query = sprintf("SELECT id AS val, provincia AS label, sigla FROM %s ORDER BY label", $this->table);
          $result = $db->arrayQuery($query);
          $contentObjectAttribute->setContent( $result );
        }
    }


  function fetchClassAttributeHTTPInput( $http, $base, $classAttribute )
  {
    $defaultValueTable = $base . '_italianprovinces_table_'  . $classAttribute->attribute( 'id' );
    $defaultValueIndex = $base . '_italianprovinces_index_'  . $classAttribute->attribute( 'id' );
    $defaultValueName = $base . '_italianprovinces_name_'  . $classAttribute->attribute( 'id' );
    $defaultValueDefault = $base . '_italianprovinces_default_'  . $classAttribute->attribute( 'id' );
    $returnvalue = false;
    if ( $http->hasPostVariable( $defaultValueTable ) )
    {
      $defaultValueTableValue = $http->postVariable( $defaultValueTable);

      if ($defaultValueTableValue == "")
      {
        $defaultValueTableValue = "";
      }
      $classAttribute->setAttribute( 'data_text1', $defaultValueTableValue );
      $returnvalue=true;
    }

    if ( $http->hasPostVariable( $defaultValueIndex ) )
    {
      $defaultValueIndexValue = $http->postVariable( $defaultValueIndex);

      if ($defaultValueIndexValue == "")
      {
        $defaultValueIndexValue = "";
      }
      $classAttribute->setAttribute( 'data_text2', $defaultValueIndexValue );
      $returnvalue=true;
    }

    if ( $http->hasPostVariable( $defaultValueName ) )
    {
      $defaultValueNameValue = $http->postVariable( $defaultValueName);

      if ($defaultValueNameValue == "")
      {
        $defaultValueNameValue = "";
      }
      $classAttribute->setAttribute( 'data_text3', $defaultValueNameValue );
      $returnvalue=true;
    }

    if ( $http->hasPostVariable( $defaultValueDefault ) )
    {
      $defaultValueDefaultValue = $http->postVariable( $defaultValueDefault);
      if (is_numeric($defaultValueDefaultValue))
        $classAttribute->setAttribute( 'data_int1', $defaultValueDefaultValue );
      else
        $returnvalue=false;
    }
    return $returnvalue;
  }

}

eZDataType::register( italianProvincesType::DATA_TYPE_STRING, "italianProvincesType" );

?>
