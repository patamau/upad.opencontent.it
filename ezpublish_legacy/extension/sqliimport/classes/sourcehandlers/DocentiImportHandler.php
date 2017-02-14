<?php
class DocentiImportHandler extends SQLIImportAbstractHandler implements ISQLIImportHandler
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

        $this->currentGUID = $remote_id = $row->codfiscale;

        $contentOptions = new SQLIContentOptions( array(
            'class_identifier'      => 'docente',
            'remote_id'				=> $remote_id,
            'language'              => 'ita-IT'
        ) );


        $content = SQLIContent::create( $contentOptions );
		$content->fields->codice = (string) $row->codice;
		$content->fields->tipo = (string) $row->tipo;
        $content->fields->nominativo = (string) $row->nominativo;
        $content->fields->indirizzo = (string) $row->indirizzo;
        $content->fields->cap = (string) $row->cap;
        $content->fields->localita = (string) $row->localita;
        $content->fields->provincia = (string) $row->prov;
        $content->fields->piva = (string) $row->partiva;
        $content->fields->codice_fiscale = (string) $row->codfiscale;
        $content->fields->telefono = (string) $row->telefono;
        $content->fields->email = (string) $row->mail;

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
        return 'Docenti Import Handler';
    }

    public function getHandlerIdentifier()
    {
        return 'docentiimporthandler';
    }

    public function getProgressionNotes()
    {
        return 'Currently importing : '.$this->currentGUID;
    }
}
