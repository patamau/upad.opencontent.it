<?php

class WsCourse {
    private $wsUrl;
    private $wsUsername;
    private $wsPassword;
    private $wsPasswordType = 'PasswordText';
    private $wsLogFile = '';

    public function __construct($url, $username, $password, $logFile) {
        $this->wsUrl = $url;
        $this->wsUsername = $username;
        $this->wsPassword = $password;
        $this->wsLogFile = $logFile;
    }

    protected function log( $message ) {
        eZLog::write( $message, $this->wsLogFile );
        eZCLI::instance()->output( $message );
    }

    protected function getClient( $path, $trace = 0 )
    {
        $context = stream_context_create(
            array(
                'ssl' => array(
                    'ciphers' => 'ALL',
                    'disable_compression' => true,
                    'crypto_method' => STREAM_CRYPTO_METHOD_TLS_CLIENT,
                    'verify_peer' => true,
                    'cafile' => '/etc/pki/tls/certs/ca-bundle.crt'
                )
            )
        );

        $options = array(
            'stream_context' => $context,
            'cache_wsdl' => WSDL_CACHE_NONE
        );

        if ($trace)
        {
            $options['trace'] = 1;
        }

        $client = new WSSoapClient($this->wsUrl . $path, $options);
        $client->__setUsernameToken($this->wsUsername, $this->wsPassword, $this->wsPasswordType);

        return $client;
    }

    //public function getKeyword($string) {
    //    $path = 'wsdl/KeywordEntity.wsdl';
    //    $client = new WSSoapClient($this->wsUrl . $path);
    //    $client->__setUsernameToken($this->wsUsername, $this->wsPassword, $this->wsPasswordType);
    //
    //    $keywords = array();
    //
    //    $parameters = array(
    //        'keywordSamples' => array(
    //            'id' => '',
    //            'value' => array(
    //                'languageCode' => 'it',
    //                'value' => $string
    //            )
    //        )
    //    );
    //
    //    try {
    //        $res = $client->get($parameters);
    //        //
    //        //$this->log(print_r($res, true));
    //    } catch (Exception $e) {
    //        $this->log($e->getMessage());
    //    }
    //
    //    if (isset($res->keywords)) {
    //        if (is_array($res->keywords)) {
    //            //foreach ($res->keywords as $r) {
    //                //echo '###';
    //                //print_r($r);
    //                //$keywords[$r->id] = $r->value[1]->value;
    //            //}
    //            return $res->keywords[0]->id;
    //        } else {
    //            return $res->keywords->id;
    //        }
    //    } else {
    //        // Se non ho corrispondenze ripeto un'altra volta la chiamata al ws aggiungento % alla stringa di ricerca
    //        $parameters = array(
    //            'keywordSamples' => array(
    //                'id' => '',
    //                'value' => array(
    //                    'languageCode' => 'it',
    //                    'value' => '%' . $string . '%'
    //                )
    //            )
    //        );
    //
    //        try {
    //            $res = $client->get($parameters);
    //            //
    //            //$this->log(print_r($res, true));
    //        } catch (Exception $e) {
    //            $this->log($e->getMessage());
    //        }
    //
    //        if (isset($res->keywords)) {
    //            if (is_array($res->keywords)) {
    //                return $res->keywords[0]->id;
    //            } else {
    //                return $res->keywords->id;
    //            }
    //        }
    //    }
    //    return '1';
    //}

    public function getKeyword($string) {
        $path = 'wsdl/KeywordEntity.wsdl';
        $client = $this->getClient( $path );

        $result = 1;
        $keywords = array();
        $parameters = array(
            'keywordSamples' => array(
                'id' => '',
                'value' => array(
                    'languageCode' => 'it',
                    'value' => ''
                )
            )
        );

        try {
            $res = $client->get($parameters);
        } catch (Exception $e) {
            var_dump($e);
            $this->log( $e->getMessage());
        }

        if (isset($res->keywords)) {
            foreach ($res->keywords as $r) {
                $keywords[$r->id] = strtolower($r->value[1]->value);
            }
            ksort($keywords);
            //$this->log(print_r($keywords, 1));
            $key = array_search(strtolower($string), $keywords);

            if (!$key) {
                $search_terms = explode(" ", $string);
                if (count($search_terms) > 0) {
                    $i = 0;
                    $find = false;
                    while ($i < count($search_terms)) {
                        if (strlen($search_terms[$i]) >= 3) {
                            //$key = array_search('%' . strtolower($search_terms[$i]) . '%', $topics);
                            $key = $this->array_find(strtolower($search_terms[$i]), $keywords);
                            if ($key) {
                                $find = true;
                                $result = $key;
                            }
                        }
                        $i++;
                    }
                }
            } else {
                $result = $key;
            }
        }
        //$this->log( $key . ' ----- ' . $keywords[$key]);
        return $result;
    }

    public function getOrganization($enteID) {
        $path = 'wsdl/CourseManagementTasks.wsdl';
        $client = $this->getClient( $path );

        try {
            $res = $client->getMyOrganizations();
            // $this->log(print_r($res, true));
        } catch (Exception $e) {
            $this->log($e->getMessage());
        }

        if (isset($res->organizations)) {
            return $res->organizations->id;
        } else {
            // Id assegnato ad upad, non cambiare nel tempo
            return 226;
        }
    }


    public function getTargetGroup($data) {
        $path = 'wsdl/CourseManagementTasks.wsdl';
        $client = $this->getClient( $path );

        $targets = array();

        foreach ($data as $d) {

            $parameters = array(
                'targetGroupSamples' => array(
                    'id' => '',
                    'value' => array(
                        'languageCode' => 'it',
                        'value' => $d
                    )
                )
            );

            try {
                $res = $client->getMyTargetGroups($parameters);
                //$this->log(print_r($res, true));
            } catch (Exception $e) {
                $this->log($e->getMessage());
            }

            if (isset($res->targetGroups)) {
                if (is_array($res->targetGroups)) {
                    $targets[]= array(
                        'id' => $res->targetGroups[0]->id,
                        'value' => ''
                    );
                } else {
                    $targets[]= array(
                        'id' => $res->targetGroups->id,
                        'value' => ''
                    );
                }
            } else {
                $targets[]= array(
                    'id' => '',
                    'value' => $d
                );
            }

            //$this->log(print_r($targets, true));
            //$this->log
        }
        return $targets;
    }

    public function getTypeOfCourse() {
        $path = 'wsdl/TypeOfCourseEntity.wsdl';
        $client = $this->getClient( $path );

        try {
            $res = $client->get();
            //
            //$this->log(print_r($res, true));
        } catch (Exception $e) {
            $this->log($e->getMessage());
        }

        if (isset($res->courseTypes)) {
            return $res->courseTypes[0]->id;
        } else {
            // Default 1
            return 1;
        }
    }

    public function getTypeOfTraining() {
        $path = 'wsdl/TypeOfTrainingEntity.wsdl';
        $client = $this->getClient( $path );

        try {
            $res = $client->get();
            //
            //$this->log(print_r($res, true));
        } catch (Exception $e) {
            $this->log($e->getMessage());
        }

        if (isset($res->trainingTypes)) {
            return $res->trainingTypes[1]->id;
        } else {
            // Default 2
            return 2;
        }
    }

    //public function getMarketingTopic() {
    //    $path = 'wsdl/MarketingTopicEntity.wsdl';
    //    $client = new WSSoapClient($this->wsUrl . $path);
    //    $client->__setUsernameToken($this->wsUsername, $this->wsPassword, $this->wsPasswordType);
    //
    //    try {
    //        $res = $client->get();
    //        //
    //        //$this->log(print_r($res, true));
    //    } catch (Exception $e) {
    //        $this->log($e->getMessage());
    //    }
    //
    //    if (isset($res->topics)) {
    //        return $res->topics[1]->id;
    //    } else {
    //        // Default 1
    //        return 1;
    //    }
    //}

    public function getMarketingTopic($string) {
        $path = 'wsdl/MarketingTopicEntity.wsdl';
        $client = $this->getClient( $path );

        $result = 1;
        $topics = array();

        try {
            $res = $client->get();
            //echo '<pre>';
            //print_r($res);
        } catch (Exception $e) {
            var_dump($e);
        }

        if (isset($res->topics)) {
            foreach ($res->topics as $r) {
                $topics[$r->id] = strtolower($r->value[1]->value);
            }
            echo '<pre>';
            ksort($topics);
            //$this->log(print_r($topics, true));

            $key = array_search(strtolower($string), $topics);
            if (!$key) {
                $search_terms = explode(" ", $string);
                if (count($search_terms) > 0) {
                    $i = 0;
                    $find = false;
                    while ($i < count($search_terms)) {
                        if (strlen($search_terms[$i]) >= 3) {
                            //$key = array_search('%' . strtolower($search_terms[$i]) . '%', $topics);
                            $key = $this->array_find(strtolower($search_terms[$i]), $topics);
                            if ($key) {
                                $find = true;
                                $result = $key;
                            }
                        }
                        $i++;
                    }
                }
            } else {
                $result = $key;
            }
        }
        //$this->log($key . ' ----- ' . $topics[$key]);
        return $result;
    }

    function array_find($needle, $haystack) {
        foreach ($haystack as $k => $v) {
            if (strpos($v, $needle) !== FALSE) {
               return $k;
               break;
            }
        }
        return false;
    }



    public function publishCourse($attributes) {

        $result = false;
        $this->log('***********************');
        //$this->log(print_r($attributes, true));
        $keyword = $this->getKeyword($attributes['area_tematica']);
        $marketingTopic = $this->getMarketingTopic($attributes['area_tematica']);


        /*
         * Imposto la tipologia
           Valori possibili (https://demo-wave.ws.siag.it/wsdl/KindOfCourseEntity.wsdl)
           [1] => Conferenza
           [2] => Congresso
           [3] => Seminario
           [4] => Corso
           [5] => Programma estivo per bambini e adolescenti
           [6] => E-Learning
           [7] => Altro
         */
        $kindOfCourse = 4;

        // Id dell'organizzatore, la funzione restituisce il valore 226 (UPAD) o 301 (PALLADIO)
        //$organizationId = $this->getOrganization($attributes['ente']);
        $wsINI          = eZINI::instance( 'ocwscourse.ini' );
        $upadID         = $wsINI->variable( 'EnteSetting', 'UpadID' );
        $organizationId = $attributes['ente'] == $upadID ? 226 : 301;



        /*
         * Imposto il tipo di corso
           Valori possibili (https://demo-wave.ws.siag.it/wsdl/TypeOfCourseEntity.wsdl)
           [1] => Manifestazione propria
           [2] => Manifestazione su commissione
           [3] => Manifestazioni ospitate
           [4] => Manifestazione culturale
           [5] => Progetto
         */
        $typeOfCourse = 1;

        /*
         * Imposto il tipo di insegnamento
           Valori possibili (https://demo-wave.ws.siag.it/wsdl/TypeOfTrainingEntity.wsdl)
           [1] => Formazione professionale
           [2] => Formazione personale
         */
        $typeOfTraining = 2;

        // Docente
        $docente = explode(' ', $attributes['docente']);
        $nome = array_shift($docente);
        if (empty($nome)) {
            $nome = ' ';
        }
        $cognome = implode($docente);
        if (empty($cognome)) {
            $cognome = ' ';
        }


        $xml = new SimpleXMLElement('<courses/>');
        $xml->addChild('audiance', 1);
        $xml->addChild('brochureApprovals', 1);
        $xml->addChild('keywordIds', $keyword);
        $xml->addChild('kindOfCourseId', $kindOfCourse);

        // Location
        $location = $xml->addChild('location');
        $city = $location->addChild('city');
        $city->addChild('languageCode', 'it');
        $city->addChild('value', $attributes['luogo']['citta']);

        $location->addChild('municipalityId', strtoupper($attributes['luogo']['codice_catasto']));

        $street = $location->addChild('street');
        $street->addChild('languageCode', 'it');
        $street->addChild('value', $attributes['luogo']['indirizzo']);

        $location->addChild('streetNumber', $attributes['luogo']['numero_civico']);
        $location->addChild('utmPosition', '');
        $location->addChild('zipCode', $attributes['luogo']['cap']);

        $xml->addChild('marketingTopicId', $marketingTopic);
        $xml->addChild('moduleNr', 1);
        $xml->addChild('organizerId', $organizationId);
        $xml->addChild('publishingBrochures', 2);
        $xml->addChild('status', 1);

        // Description
        $description = $xml->addChild('description');
        $description->addChild('languageCode', 'it');
        $description->addChild('value', $attributes['descrizione']);

        // Teaching
        $teaching = $xml->addChild('teaching');
        $teaching->addChild('id', '');
        $teacher = $teaching->addChild('teacher');
        $teacher->addChild('firstName', $nome );
        $teacher->addChild('lastName', $cognome);
        $teacher->addChild('taxNumber', '');

        // Timetable
        $timetable = $xml->addChild('timetable');
        $timetable->addChild('begin', $attributes['data_inizio']);
        $timetable->addChild('end', $attributes['data_fine']);
        if ( isset($attributes['numero_lezioni']) && !empty($attributes['numero_lezioni']) )
        {
            $scheduling = $timetable->addChild('plannedScheduling');
            $scheduling->addChild('days', $attributes['numero_lezioni'] );
            $scheduling->addChild('minutes', 0 );
        }

        // Title
        $title = $xml->addChild('title');
        $title->addChild('languageCode', 'it');
        $title->addChild('value', $attributes['titolo']);

        $xml->addChild('typeOfCourseId', $typeOfCourse);
        $xml->addChild('typeOfTrainingId', $typeOfTraining);

        if (isset($attributes['id']) && !empty($attributes['id'])) {
            $xml->addChild('id', $attributes['id']);
        }


        // Target groups
        // Commento la chiamata al ws dei target group come detto da Christoph in email del 9 dicembre 2014

        //$targetGroup = $this->getTargetGroup($attributes['destinatari']);
        //foreach ($targetGroup as $t) {
        //    $target = $xml->addChild('targetGroups');
        //    $target->addChild('id', $t['id']);
        //    $value = $target->addChild('value');
        //    $value->addChild('languageCode', 'it');
        //    $value->addChild('value', $t['value']);
        //}

        foreach ($attributes['destinatari'] as $d) {
            $target = $xml->addChild('targetGroups');
            $target->addChild('id', '');
            $value = $target->addChild('value');
            $value->addChild('languageCode', 'it');
            $value->addChild('value', $d);
        }

        $request = trim(str_replace('<?xml version="1.0"?>', '', $xml->asXML()));
        $parameters = new SoapVar($request , XSD_ANYXML);

        $path = 'wsdl/CourseManagementTasks.wsdl';
        $client = $this->getClient( $path, true );

        try {
            $res = $client->publishMyCourses(array($parameters));
            $this->log('Invio dati al ws');
            $this->log(print_r($res, true));

            $result = $res->publishedCourses->id;
        } catch (Exception $e) {
            $this->log($e->getMessage());
        }

        $this->log($client->__getLastRequest() . "\n" . $client->__getLastResponse());

        return $result;
    }

}
