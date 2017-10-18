<?php

/*

CREATE TABLE IF NOT EXISTS `upad_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `ente_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `text` longtext NOT NULL,
  `download_count` int(11) NOT NULL,
  `total` varchar(255) DEFAULT '0'
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoice_id` (`invoice_id`,`year`,`ente_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE  `upad_invoice` ADD  `invoice_id_string` VARCHAR( 255 ) NOT NULL AFTER  `invoice_id`

*/
class eZUpadInvoice extends eZPersistentObject
{
    /**
     * Schema definition
     * @see kernel/classes/ezpersistentobject.php
     * @return array
     */
    public static function definition()
    {
        return array(
            'fields' => array(
                'id' => array(
                    'name' => 'ID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'invoice_id' => array(
                    'name' => 'InvoiceID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'invoice_id_string' => array(
                    'name' => 'InvoiceIDString',
                    'datatype' => 'string',
                    'default' => '',
                    'required' => true
                ),
                'order_id' => array(
                    'name' => 'OrderID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'ente_id' => array(
                    'name' => 'EnteID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'user_id' => array(
                    'name' => 'UserID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'year' => array(
                    'name' => 'Year',
                    'datatype' => 'integer',
                    'default' => null,
                    'required' => true
                ),
                'date' => array(
                    'name' => 'date',
                    'datatype' => 'integer',
                    'default' => null,
                    'required' => true
                ),
                'text' => array(
                    'name' => 'Text',
                    'datatype' => 'text',
                    'default' => '',
                    'required' => true
                ),
                'download_count' => array(
                    'name' => 'DownloadCount',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'total' => array(
                    'name' => 'Total',
                    'datatype' => 'text',
                    'default' => '0',
                    'required' => false
                ),
            ),
            "increment_key" => "id",
            'keys' => array( 'invoice_id', 'year', 'ente_id' ),
            'class_name' => 'eZUpadInvoice',
            'name' => 'upad_invoice',
            'function_attributes' => array( "ente" => "ente",
                                            "order" => "order" )
        );
    }

    public static function fetch( $id )
    {
        $result = parent::fetchObject( self::definition(), null, array( 'id' => $id ) );
        return $result;
    }

    function eZUpadInvoice( $row )
    {
        $this->eZPersistentObject( $row );
    }

    public static function checkInvoiceIdArrayConsistency( $idArray )
    {
        $data = array();
        $idArray = array_unique( $idArray );
        foreach( $idArray as $id )
        {
            if ( self::fetch( $id ) )
            {
                $data[] = $id;
            }
        }
        return $data;
    }

    public static function create( $orderId, $enteId, $userId, $text, $total )
    {
        $date = time();
        $year = date( 'Y', $date );
        $invoiceId = self::getNewID( $enteId, $year );
        $invoiceIdString = self::getNewIDString( $invoiceId );
        $row = array(
          'invoice_id' => $invoiceId,
          'invoice_id_string' => $invoiceIdString,
          'order_id' => $orderId,
          'ente_id' => $enteId,
          'user_id' => $userId,
          'year' => $year,
          'date' => $date,
          'text' => $text,
          'total' => $total,
        );
        $invoice = new eZUpadInvoice( $row );
        $invoice->store();
        return $invoice;
    }

    public static function getNewID( $enteId, $year )
    {
        $number = 1;
        $result = parent::fetchObjectList(
            self::definition(),
            null,
            array( 'ente_id' => $enteId, 'year' => $year ),
            array( 'invoice_id' => 'desc' ),
            array( 'length' => 1, 'offset' => 0 ),
            false
        );
        if ( !empty( $result ) )
        {
            $number = $result[0]['invoice_id'];
            $number++;
        }
        return $number;
    }

    public function getNewIdString ($invoiceId)
    {
        return 'A' . str_repeat('0', 4 - strlen($invoiceId)) . $invoiceId;
    }

    public function ente()
    {
        return eZContentObject::fetch( $this->attribute( 'ente_id' ) );
    }

    public function order()
    {
        return eZOrder::fetch( $this->attribute( 'order_id' ) );
    }

    public static function fetchByOrder( $orderId )
    {
        $result = parent::fetchObjectList( self::definition(), null, array( 'order_id' => $orderId ) );
        return $result;
    }

    public static function countList($cond)
    {
        $result = parent::count( self::definition(), $cond );
        return $result;
    }

    public static function fetchList($cond)
    {
        $result = parent::fetchObjectList( self::definition(), null, $cond );
        return $result;
    }

    public function increaseDownloadCount()
    {
        $invoiceID = $this->attribute( 'invoice_id' );
        $db = eZDB::instance();
        $db->query( "UPDATE upad_invoice SET download_count=(download_count+1)
                     WHERE
                     invoice_id=$invoiceID" );
    }
    
    public static function  fetchInvoicesByCourse($corso, $da, $a, $quick=false){
        
        //ESCAPE DEI DATI IN INPUT
        $corso = intval($corso); //l'id del corso
        //$da = mysql_real_escape_string($da); // la data di partenza -> no escape perchè dopo strtotime()
        //$a = mysql_real_escape_string($a); //la data di fine
        
        //CREAZIONE INTERVALLO DI DATE
        $da = strtotime($da .  ' 00:00');
        if (!$a  || $a = "") {
            $a =  strtotime($da . ' 23:59');
        }
        else{
            $a =  strtotime($a . ' 23:59');
        }
        
        $siteConfig = eZINI::instance( 'site.ini' );
        $bd_user = $siteConfig->variable( 'DatabaseSettings', 'User' );
        $db_pwd = $siteConfig->variable( 'DatabaseSettings', 'Password' );
        
        
        $myQuery = "
        SELECT  invoices.id 
        FROM upad_invoice as invoices JOIN upad_invoice_meta as invoices_info ON (invoices.id = invoices_info.invoice_id)
            JOIN ezcontentobject as users ON (invoices.user_id =  users.id)
            JOIN ezcontentobject as courses ON (invoices_info.course_id = courses.id)
                
        WHERE   courses.id = ". $corso ."
                AND invoices.date >= ". $da ."
                AND invoices.date <= ". $a  ."
        ";
        
        $error   = "";
        
        $link;
        if (!$link = mysql_connect('localhost', $bd_user, $db_pwd)) {
            $error .=  'Could not connect to mysql';
            //exit;
        }
        
        //selezione del db
        if (!mysql_select_db('ez_upad', $link)) {
            $error .= 'Could not select database';
            //exit;
        }
        
        /*esecuzione della query*/
        $result = mysql_query($myQuery, $link);
        
        $invoices = array();
        
        if (!$result) {
            $error .= "DB Error, could not query the database\n";
            $error .= 'MySQL Error: ' . mysql_error(). "\n";
            $error .= 'Contatta l\'amministratore del sito.\n';
            //exit;
        }
        else{
            while ($row = mysql_fetch_assoc($result)) {
            	if($quick){
                	$invoices[] = new eZUpadInvoice( $row );
            	}else{
                	$invoices[] = eZUpadInvoice::fetch($row["id"]);
            	}
            }
        }
        
        mysql_free_result($result);
        
        if($error) eZDebug::writeError($error);
        
        return $invoices;
    }
}
