<?php
class UserImportHandler extends SQLIImportAbstractHandler implements ISQLIImportHandler
{
    protected $rowIndex = 0;

    protected $rowCount;

    protected $currentGUID;

    public function __construct( SQLIImportHandlerOptions $options = null )
    {
        parent::__construct( $options );
        $this->remoteIDPrefix = $this->getHandlerIdentifier().'-';
        $this->currentRemoteIDPrefix = $this->remoteIDPrefix;
        $this->options = $options;
    }

    public function initialize()
    {
		$this->tree = array();
        $csvFile = $this->handlerConfArray['CsvFile'];
        $options = new SQLICSVOptions( array(
			'csv_path' => $csvFile,
            'delimiter' => ';',
			'enclosure'   => '"'
		) );
        $csvDoc = new SQLICSVDoc( $options );
		$csvDoc->parse();
        $this->dataSource = $csvDoc->rows;
    }

    public function getProcessLength()
    {
        if( !isset( $this->rowCount ) )
        {
            $this->rowCount = count( $this->dataSource );
            $this->maxRowCount = $this->rowCount;
        }
        return $this->rowCount;
    }

    public function getNextRow()
    {
        if( $this->rowIndex < $this->rowCount )
        {
            $row = $this->dataSource[$this->rowIndex];
            $this->rowIndex++;
        }
        else
        {
            $row = false; // We must return false if we already processed all rows
        }
        return $row;
    }

    public function process( $row )
    {

        // "codice";"tipo";"nominativo";"indirizzo";"cap";"localita";"prov";"partiva";"codfiscale";"telefono";"mail"
        //print( var_dump($row) );

        /*if (empty($row->codicefiscale)) {

            // Get cURL resource
            $curl = curl_init();
            // Set some options - we are passing in a useragent too here
            curl_setopt_array($curl, array(
                CURLOPT_RETURNTRANSFER => 1,
                CURLOPT_URL => "http://webservices.dotnethell.it/codicefiscale.asmx/CalcolaCodiceFiscale?Nome=Raffaele&Cognome=Luccisano&ComuneNascita=L'Aquila&DataNascita=12/11/1983&Sesso=M",
                CURLOPT_USERAGENT => 'Sample cURL Request'
            ));
            // Send the request & save response to $resp
            $resp = curl_exec($curl);
            // Close request to clear up some resources
            curl_close($curl);

            print($resp);


            require_once(dirname(__FILE__).'/../cf/cod_fis.php');
            $codfis = new cf();
            $codicefiscale = $codfis->estrai_CF( 'Raffaele', 'Luccisano', 12, 11, 1983, 'M', 'L\'Aquila' ) ;

            print $codicefiscale;

        }*/

        if (!empty($row->codicefiscale)){
            $this->currentGUID = $remote_id = $row->codicefiscale;
            $contentOptions = new SQLIContentOptions( array(
                'class_identifier'      => 'user',
                'remote_id'				=> $remote_id,
                'language'              => 'ita-IT'
            ) );


            $content = SQLIContent::create( $contentOptions );
            $content->fields->first_name = (string) $row->nome;
            $content->fields->last_name = (string) $row->cognome;
            $content->fields->sesso = (string) $row->sesso;


            $codiceCatastale = substr($row->codicefiscale, -5, 4);
            $db = eZDB::instance();
            //$query = sprintf("SELECT sigla FROM %s WHERE id = %d LIMIT 1", $this->tableProvinces, $value[0]);
            //$result = $db->arrayQuery($query);

            $query = sprintf("SELECT id, provincia FROM occomuni WHERE codice_catasto LIKE '%s'", $codiceCatastale);
            $result = $db->arrayQuery($query);
            $comune = $result[0]['id'];

            $query = sprintf("SELECT id FROM ocprovince WHERE sigla LIKE '%s'", $result[0]['provincia']);
            $result = $db->arrayQuery($query);
            $provincia = $result[0]['id'];

            $content->fields->luogo_nascita = (string) $provincia.','.$comune;

            $content->fields->data_nascita = strtotime(str_replace('/', '-', $row->datanascita));
            $content->fields->stato_nascita = (string) $row->nazionalita;

            $time = time();
            $username = (empty($row->codicefiscale) ? $time : (string) $row->codicefiscale);
            $email = (empty($row->email) ? $time.'@upad.it' : (string) $row->email);

            // Build the password hash
            // md5_user is a concatenation of login and password with a \n, md5 hashed
            $passwordHash = md5( $usernma."\n".$time );

            // Format for ezuser is userLogin|userEmail|passwordHash|hashType|isActivated
            $content->fields->user_account = $username.'|'.$email.'|'.$passwordHash.'|md5_user';

            $content->fields->telefono = '';
            $content->fields->professione = (string) $row->professione;
            $content->fields->indirizzo_residenza = (string) $row->indirizzo;

            //$content->fields->provincia_residenza = (string) $row->provincia;
            //$content->fields->comune_residenza = (string) $row->comuneresidenza;


            $query = sprintf("SELECT id FROM ocprovince WHERE sigla LIKE '%s'", $row->provincia);
            $result = $db->arrayQuery($query);
            $provinciaRes = $result[0]['id'];

            $query = sprintf("SELECT id FROM occomuni WHERE provincia LIKE '%s' AND comune LIKE '%s'", $row->provincia, $row->comuneresidenza);
            $result = $db->arrayQuery($query);
            $comuneRes = $result[0]['id'];

            $content->fields->luogo_residenza = (string) $provinciaRes.','.$comuneRes;





            $content->fields->cap_residenza = (string) $row->cap;

            $content->fields->codice_fiscale = (string) $row->codicefiscale;

            //$content->fields->image = self::getImage( (string) $row->pictureUrl );
            //$content->fields->abstract = strip_tags( (string) $row->shortDescriptionIt );
            //$content->fields->description = SQLIContentUtils::getRichContent( (string) $row->htmlDescriptionIt );
            //$content->fields->classifications = trim( $row->classifications );

            $parentNodeId = $this->handlerConfArray['DefaultParentNodeID'];
            $content->addLocation( SQLILocation::fromNodeID( $parentNodeId ) );
            $publisher = SQLIContentPublisher::getInstance();
            $publisher->publish( $content );
            unset( $content );
        }
    }

    public static function getImage( $string )
    {
        return '[full path to image]' . $string;
    }

    public function cleanup()
    {
        return;
    }

    public function getHandlerName()
    {
        return 'User Import Handler';
    }

    public function getHandlerIdentifier()
    {
        return 'userimporthandler';
    }

    public function getProgressionNotes()
    {
        return 'Currently importing : '.$this->currentGUID;
    }
}
