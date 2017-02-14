<?php

class ocurtAjaxFunction extends ezjscServerFunctions
{
    public static function searchCities($args)
    {
        if ( isset( $args[0] ) )
        {
            return 'Hello World, you sent me
                    parameter : ' . $args[0];
        }
        else
        {
            $http = eZHTTPTool::instance();
            if ( $http->hasPostVariable( 'arg1' ) )           {

                $db =& eZDB::instance();
                $http = eZHTTPTool::instance();
                $query="SELECT id, comune FROM occomuni WHERE provincia like '".trim($http->postVariable( 'arg1' ))."' ORDER BY comune ASC";

                $result = $db->arrayQuery($query);

                $return = '';
                foreach ($result as $r) {
                    $return .=  '<option value="'.$r['id'].'">' .$r['comune'] .'</option>';
                }
                return $return;
            }
        }

        return "Request to server completed,
                but you did not send any
                post / function parameters!";

    }

    public static function searchCap($args)
    {
        if ( isset( $args[0] ) )
        {
            return 'Hello World, you sent me
                    parameter : ' . $args[0];
        }
        else
        {
            $http = eZHTTPTool::instance();
            if ( $http->hasPostVariable( 'arg1' ) )
            {


                $query = '';
                $db =& eZDB::instance();
                $http = eZHTTPTool::instance();
                $query="SELECT cap FROM occomuni WHERE id like '".trim($http->postVariable( 'arg1' ))."' LIMIT 1";

                $result = $db->arrayQuery($query);

                return $result[0]['cap'];
            }
        }

        return "Request to server completed,
                but you did not send any
                post / function parameters!";

    }


    public static function calcolaCodiceFiscale($args)
    {
        if ( isset( $args[0] ) )
        {
            return 'Hello World, you sent me
                    parameter : ' . $args[0];
        }
        else
        {
            $http = eZHTTPTool::instance();
            if ( $http->hasPostVariable( 'name' ) )
            {

                $cf = new codicefiscale();
                $codice = $cf->calcola($http->postVariable( 'name' ), $http->postVariable( 'lastname' ), $http->postVariable( 'date' ), $http->postVariable( 'gender' ), $http->postVariable( 'city' ), '');

                return $codice;
            }
        }

        return "Request to server completed,
                but you did not send any
                post / function parameters!";

    }
}
?>
