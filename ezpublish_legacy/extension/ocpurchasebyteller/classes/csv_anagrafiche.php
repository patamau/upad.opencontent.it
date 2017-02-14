<?php
#  php extension/occhangeobjectdate/bin/php/walkobjects.php --handler=csv_anagrafiche -s backend --params="12;10;1"
class CsvAnagrafiche implements InterfaceWalkObjects
{

    public $params = array(
        'Limitation'  => array(),
        'ClassFilterType' => 'include',
        'LoadDataMap' => false
    );

    public $parentNodeID = 2;
    //public $classIdentifier = array('societa', 'persona' );
    public $classIdentifier = array( 'user' );
    public $limit;
    public $depth = 1;


    public $logFile = 'csv_anagrafiche.log'; #cambiare nome
    public $logDir = 'var/log';
    public $errors = array();

    public static function help()
    {
        return '--handler=csv_anagrafiche -s<siteaccess> --params="<parentNodeID>;<limit>;<depth>"';
    }

    public function __construct( $globalParams = array() )
    {

        $globalParams = explode( ';', $globalParams );

        //controllo che sia impostato il nodo padre e che esista
        if($globalParams[0]!=null){


            $node = eZContentObjectTreeNode::fetch($globalParams[0]);

            if ( !$node instanceof eZContentObjectTreeNode )
            {
                array_push($this->errors, 'Non esiste un nodo con id '.$globalParams[0]);
            }else{
                $this->parentNodeID = $globalParams[0];
            }

        }else{
            array_push($this->errors, 'Valorizzare parentNodeID: --params="<parentNodeID>;<fromObjectStateId>;<toObjectStateId>;<limit>;<depth>"');
        }

        //limit
        if($globalParams[1]!=null){

            if (!is_numeric($globalParams[1]))
            {
                array_push($this->errors, $globalParams[1].' non è un valore intero per gestire il limit della query');
            }else{
                $this->limit = $globalParams[1];
            }

        }

        //depth
        if($globalParams[2]!=null){

            if (!is_numeric($globalParams[2]))
            {
                array_push($this->errors, $globalParams[2].' non è un valore intero per gestire il depth della query');
            }else{
                $this->depth = $globalParams[2];
            }

        }

        if(count($this->errors) > 0){

            echo "\n"."-----------------------------------------------------------------";
            foreach($this->errors as $error){
                echo "\n".$error;
            }
            echo "\n"."-----------------------------------------------------------------"."\n";

            die();
        }


        // Sposto nel construct dal fetch perchè cablati nelle proprietà dell'oggetto
        $this->params['ClassFilterArray'] = $this->classIdentifier;


    }

    public function fetchCount()
    {
        $count =  eZContentObjectTreeNode::subTreeCountByNodeID( $this->params, $this->parentNodeID );
        if ( $count == NULL )
        {
            $count = 0;
        }
        return $count;
    }

    public function setFetchParams( $array )
    {
        $this->params = array_merge( $this->params, $array );
    }

    public function fetch()
    {
        //se l'ho passato setto il limit --- credo vada eliminato
        /*if($this->limit > 0){
            $this->params['Limit'] = (int)$this->limit;
        }

        if($this->depth > 0){
            $this->params['Depth'] = (int)$this->depth;
        }*/

        // Per mantenere la compatibilità al walkobjects.php generale resetto l'offset sempre a 0 perchè le fetch consecutive ai cambiamenti di stato coinvolgono un numero differente di nodi
        //$this->params['Offset'] = 0;
        //return eZContentObjectTreeNode::subTreeByNodeID( $this->params, $this->parentNodeID );

        //se l'ho passato setto il limit
        if($this->limit > 0){
            $this->params['Limit'] = (int)$this->limit;
        }

        if($this->depth > 0){
            $this->params['Depth'] = (int)$this->depth;
        }

        return eZContentObjectTreeNode::subTreeByNodeID( $this->params, $this->parentNodeID );


    }

    public function modify( &$item, $cli )
    {
        try{
            /** @var eZContentObject $object */
            $object = $item->attribute( 'object' );

            //echo '"remote_id";"ragione_sociale";"indirizzo";"cap";"frazione";"comune";"destinatario_pa"'. "\n";
            $dataMap = $object->dataMap();

            //$recapiti = $dataMap['recapiti']->toString();
            //$recapitiArray = explode('&', $recapiti);

            $localita = $this->fixStringValue($dataMap['luogo_residenza']->toString());
            $localitaArray = explode(' (', $localita);

            $data = array(
                'remote_id' => $object->remoteID(),
                //'ragione_sociale' => $this->fixStringValue($object->name()),
                'nome' => $this->fixStringValue($dataMap['first_name']->toString()),
                'cognome' => $this->fixStringValue($dataMap['last_name']->toString()),
                //'cf'  => $object->attribute('class_identifier') == 'societa' ? $this->fixStringValue($dataMap['iva']->toString()) : $this->fixStringValue($dataMap['iva']->toString())
                'indirizzo'  => $this->fixStringValue($dataMap['indirizzo_residenza']->toString()),
                'cap' => $this->fixStringValue($dataMap['cap_residenza']->toString()),
                'localita'  => $localitaArray[0],
                'provincia'  => str_replace(array(')'), array(''), $localitaArray[1]),
                'data_iscrizione'  => $this->fixStringValue(strftime( '%d/%m/%Y', $object->attribute( 'published' )))
            );

            /*if (!empty($recapitiArray))
            {
                $row = explode('|', $recapitiArray[0]);
                $data['indirizzo'] = $this->fixStringValue($row[1]);
                $data['cap'] = $this->fixStringValue($row[2]);
                $data['frazione'] = $this->fixStringValue($row[3]);
                $data['comune'] = $this->fixStringValue($row[4]);
                $data['provincia'] = $this->fixStringValue($row[5]);
                $data['destinatario_pa'] = $this->fixStringValue($row[12]);
            }
            else
            {
                $data['indirizzo'] = ' ';
                $data['cap'] = ' ';
                $data['frazione'] = ' ';
                $data['comune'] = ' ';
                $data['provincia'] = ' ';
                $data['destinatario_pa'] = ' ';
            }*/

            echo '"' . implode('";"',$data ) . '"' . "\n";

        } catch (Exception $e) {
            echo "\n"."Eccezione: ".  $e->getMessage();
        }

        return;
    }

    public function fixStringValue( $string )
    {
        return trim(str_replace(array('"'), '', $string));
    }

}

?>