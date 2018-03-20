<?php

/*!
  \class   TemplateProva_operatorOperator templateprova_operatoroperator.php
  \ingroup eZTemplateOperators
  \brief   Gestisce l'operatore di template prova_operator. Usando prova_operator puoi... generare un csv
  \version 1.0
  \date    Lunedì, 16 Ottobre 2017 11:25:10
  \author  User Administrator (1984-02-02)

  

  Esempio:
\code
{$value|prova_operator|wash}
\endcode
*/

/*
If you want to have autoloading of this operator you should create
a eztemplateautoload.php file and add the following code to it.
The autoload file must be placed somewhere specified in AutoloadPathList
under the group TemplateSettings in settings/site.ini

$eZTemplateOperatorArray = array();
$eZTemplateOperatorArray[] = array( 'script' => 'templateprova_operatoroperator.php',
                                    'class' => 'TemplateProva_operatorOperator',
                                    'operator_names' => array( 'prova_operator' ) );

If your template operator is in an extension, you need to add the following settings:

To extension/YOUREXTENSION/settings/site.ini.append:
---
[TemplateSettings]
ExtensionAutoloadPath[]=YOUREXTENSION
---

To extension/YOUREXTENSION/autoloads/eztemplateautoload.php:
----
$eZTemplateOperatorArray = array();
$eZTemplateOperatorArray[] = array( 'script' => 'extension/YOUEXTENSION/YOURPATH/templateprova_operatoroperator.php',
                                    'class' => 'TemplateProva_operatorOperator',
                                    'operator_names' => array( 'prova_operator' ) );
---

Create the files if they don't exist, and replace YOUREXTENSION and YOURPATH with the correct values.

*/


class Orario_Operator
{
    /*!
      Costruttore, come impostazione predefinita non fa nulla.
    */
    function __construct()
    {
    }

    /*!
     \return an array with the template operator name.
    */
    function operatorList()
    {
        return array( 'get_orario' );
    }

    /*!
     \return true to tell the template engine that the parameter list exists per operator type,
             this is needed for operator classes that have multiple operators.
    */
    function namedParameterPerOperator()
    {
        return true;
    }

    /*!
     See eZTemplateOperator::namedParameterList
    */
    function namedParameterList()
    {
        return array( 'get_orario' => array( 'orario_stringa' => array( 'type' => 'string',
                                                                        'required' => true )));
    }


    
    
    /*!
     Esegue la funzione PHP per la pulizia dell'operatore e modifica \a $operatorValue.
    */
    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement )
    {
        $orario_stringa = $namedParameters['orario_stringa'];
        
        switch ( $operatorName )
        {
            case 'get_orario':
            {
                $removable = array(' ', '.',':','/','-');
                $orario_stringa = str_replace($removable,'',$orario_stringa);
                if(strlen($orario_stringa) == 4)
                {
                    $operatorValue = array( $orario_stringa[0].$orario_stringa[1].'00',
                                            $orario_stringa[2].$orario_stringa[3].'00');
                }
                elseif (strlen($orario_stringa) == 8){
                    $operatorValue = array(substr($orario_stringa,0,4),
                                           substr($orario_stringa,4,4));
                }
                else{
                    $operatorValue = array('0000','0000');
                }
            } break;
        }
    }
    
}

?>