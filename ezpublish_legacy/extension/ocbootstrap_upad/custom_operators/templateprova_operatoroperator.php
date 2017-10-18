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


class TemplateProva_operatorOperator
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
        return array( 'prova_operator' );
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
        return array( 'prova_operator' => array( 'first_param' => array( 'type' => 'string',
                                                                         'required' => false,
                                                                         'default' => 'default text' ),
                                                 'second_param' => array( 'type' => 'integer',
                                                                          'required' => false,
                                                                          'default' => 0 ) ) );
    }


    /*!
     Esegue la funzione PHP per la pulizia dell'operatore e modifica \a $operatorValue.
    */
    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement )
    {
        $firstParam = $namedParameters['first_param'];
        $secondParam = $namedParameters['second_param'];
        // Codice di esempio. Questo codice deve essere modificato per fare ciò che l'operatore deve fare. Al momento toglie solo gli spazi iniziali e finali al testo.
        switch ( $operatorName )
        {
            case 'prova_operator':
            {
            	$siteConfig = eZINI::instance( 'site.ini' );
		        $db_user = $siteConfig->variable( 'DatabaseSettings', 'User' );
		        $db_pwd = $siteConfig->variable( 'DatabaseSettings', 'Password' );
		        $db_server = $siteConfig->variable( 'DatabaseSettings', 'Server' );
		        $db_name = $siteConfig->variable( 'DatabaseSettings', 'Database' );
                $operatorValue = ''; /*INSERISCO NELLA VARIABILE DI INPUT LA STRINGA CSV RISULTANTE*/
                
                /* QUERY CHE SELEZIONA GLI UTENTI ISCRITTI AD UN CORSO (cio� che hanno una sottoscrizione non ancora scaduta)
                 * CHE PREVEDE UN TESSERAMENTO E CHE NON HANNO ANCORA ASSOCIATA UNA TESSERA MAGNETICA
                 */
                $myQuery = " SELECT users.id as id, first_name_attr.data_text as first_name, last_name_attr.data_text as last_name, data_nascita_attr.data_text as data_nascita, 
    email_attr.data_text as email, DATE_ADD(from_unixtime(subscriptions.published), INTERVAL 1 YEAR) as scadenza, annullato_attr.data_int as annullata       
    FROM ezcontentobject as subscriptions, ezcontentobject as users, ezcontentobject as courses, 
	ezcontentobject_link as user_link, ezcontentobject_link as course_link, ezcontentobject_link as areatematica_link,  
    ezcontentobject_attribute as card_attribute, ezcontentobject_attribute as first_name_attr, ezcontentobject_attribute as last_name_attr,  
    ezcontentobject_attribute as data_nascita_attr, ezcontentobject_attribute as email_attr, ezcontentobject_attribute as annullato_attr 
 
	WHERE subscriptions.contentclass_id=49 AND user_link.from_contentobject_version=subscriptions.current_version  

    AND first_name_attr.version = users.current_version AND first_name_attr.contentobject_id = users.id AND first_name_attr.contentclassattribute_id = 8 
    AND last_name_attr.version = users.current_version AND last_name_attr.contentobject_id = users.id AND last_name_attr.contentclassattribute_id = 9
    AND data_nascita_attr.version = users.current_version AND data_nascita_attr.contentobject_id = users.id AND data_nascita_attr.contentclassattribute_id = 462
    AND email_attr.version = users.current_version AND email_attr.contentobject_id = users.id AND email_attr.contentclassattribute_id = 12
    AND annullato_attr.version = subscriptions.current_version AND annullato_attr.contentobject_id = subscriptions.id AND annullato_attr.contentclassattribute_id = 465

	AND user_link.from_contentobject_id=subscriptions.id AND users.id=user_link.to_contentobject_id
	AND card_attribute.contentobject_id=users.id AND card_attribute.version=users.current_version
    AND annullato_attr.data_int=0
    AND DATE_ADD(from_unixtime(subscriptions.published), INTERVAL 1 YEAR) >= NOW() 
	AND card_attribute.contentclassattribute_id=483 AND (card_attribute.data_text LIKE '' OR card_attribute.data_text IS NULL)
	 AND course_link.from_contentobject_id=subscriptions.id AND courses.id=course_link.to_contentobject_id AND course_link.from_contentobject_version=subscriptions.current_version AND areatematica_link.from_contentobject_id=courses.id AND areatematica_link.from_contentobject_version=courses.current_version
	 AND areatematica_link.contentclassattribute_id=390 AND areatematica_link.to_contentobject_id=15903";
                
                /*connessione al dbms*/
                $link;
                if (!$link = mysql_connect($db_server, $db_user, $db_pwd)) {
                    $operatorValue .=  'Could not connect to mysql';
                    //exit;
                }
                
                /*selezione del db*/
                if (!mysql_select_db($db_name, $link)) {
                    $operatorValue .= 'Could not select database';
                    //exit;
                }
                
                /*esecuzione della query*/
                $result = mysql_query($myQuery, $link);
                
                if (!$result) {
                    $operatorValue .= "DB Error, could not query the database\n";
                    $operatorValue .= 'MySQL Error: ' . mysql_error(). "\n";
                    $operatorValue .= 'Contatta l\'amministratore del sito.\n';
                    //exit;
                }
                
                while ($row = mysql_fetch_assoc($result)) {
                    $operatorValue .= $row['id'] . ',';
                    $operatorValue .= $row['first_name'] . ',';
                    $operatorValue .= $row['last_name']  . ',';
                    $operatorValue .= $row['data_nascita'] . ',';
                    $operatorValue .= json_decode($row['email'])->email . ','; //da tirare fuori
                    $operatorValue .= ','; //campo tessera vuoto
                    $operatorValue .= $row['scadenza'] . ','; 
                    $operatorValue .= $row['annullata'] . ','; 
                    $operatorValue .= "\n";
                    
                }
                
                mysql_free_result($result);
                
                trim($operatorValue);
                
            } break;
        }
    }
}

?>