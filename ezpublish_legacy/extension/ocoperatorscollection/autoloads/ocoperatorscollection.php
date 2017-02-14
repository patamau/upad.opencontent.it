<?php

class OCOperatorsCollection
{
    
    private $area_tematica_node = array();
    
    static $Operators = array(
        'subsite',
        'section_color',
        'has_abstract', 'abstract',
        'oc_shorten',
        'cookieset', 'cookieget', 'check_and_set_cookies',
        'checkbrowser', 'is_deprecated_browser',
        'slugize',
        'to_query_string',
        'sort_nodes',
        'is_in_subsite',
        'appini',
        'include_cache', // @dev @todo non utilizzare
        'set_defaults',
        'has_attribute', 'attribute',
        'editor_warning',
        'developer_warning'     
    );
    
    function OCOperatorsCollection()
    {
    }
    
    function operatorList()
    {
        return self::$Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(
            'has_abstract' => array
            (
                'node' => array( "type" => "integer", "required" => false, "default" => false )                
            ),
            'abstract' => array
            (
                'node' => array( "type" => "integer", "required" => false, "default" => false )
            ),
            'oc_shorten' => array
            (
                'chars_to_keep' => array( "type" => "integer", "required" => false, "default" => 80 ),
                'str_to_append' => array( "type" => "string", "required" => false, "default" => "..." ),
                'trim_type'     => array( "type" => "string", "required" => false, "default" => "right" ),
                'allowable_tags'=> array( "type" => "string", "required" => false, "default" => "" )
            ),
            'cookieset' => array( 
                'cookie_name' 	=> array( 'type' => 'string', 'required' => true ),
                'cookie_val' 	=> array( 'type' => 'string', 'required' => true ),
                'expiry_time' 	=> array( 'type' => 'string', 'required' => false, 'default' => '0' )
            ),                
            'cookieget' => array(
				'cookie_name' 	=> array( 'type' => 'string', 'required' => true )
			),
            'is_deprecated_browser' => array(
                'browser_array' => array( 'type' => 'array', 'required' => true )
            ),
            'slugize' => array(
                'first_param' => array( 'type' => 'string', 'required' => false, 'default' => 'string to operator slugize not found' )
            ),
            'to_query_string' => array(
                'param' => array( 'type' => 'array', 'required' => false, 'default' => array() )
            ),
            'sort_nodes' => array(
                'by' => array( 'type' => 'string', 'required' => false, 'default' => 'published' ),
                'order' => array( 'type' => 'string', 'required' => false, 'default' => 'desc' )
            ),
            'appini' => array(
                'block' 	    => array( 'type' 	=> 'string',	'required' => true ),
                'setting' 	    => array( 'type'	=> 'string', 	'required' => true ),
                'default' 	    => array( 'type'    => 'mixed', 	'required' => false,    'default' => false )
            ),
            'include_cache' => array(
                'template' 	    => array( 'type' 	=> 'string',	'required' => true ),
                'variables'	    => array( 'type'	=> 'array', 	'required' => false,    'default' => array() ),
                'cache_keys'    => array( 'type'    => 'array', 	'required' => false,    'default' => false )
            ),
            'set_defaults' => array(
                'variables'	    => array( 'type'	=> 'array', 	'required' => true )
            ),
            'has_attribute' => array(
                'show_values'    => array( 'type'	=> 'string', 	'required' => true )
            ),
            'attribute' => array(
                "show_values" => array( "type" => "string", "required" => false, "default" => "" ),
                "max_val" => array( "type" => "numerical", "required" => false, "default" => 2 ),
                "format" => array( "type" => "string", "required" => false, "default" => eZINI::instance( 'template.ini' )->variable( 'AttributeOperator', 'DefaultFormatter' ) )
            ),
            'editor_warning' => array(
                'text'    => array( 'type'	=> 'string', 	'required' => true )
            ),
            'developer_warning' => array(
                'text'    => array( 'type'	=> 'string', 	'required' => true )
            )            
        );
    }
    
    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {		
        $ini = eZINI::instance( 'ocoperatorscollection.ini' );
        $appini = eZINI::instance( 'app.ini' );

        switch ( $operatorName )
        {
            case 'developer_warning':
            {
                $res = false;
                $user = eZUser::currentUser();
                if ( $user->attribute( 'login' ) == 'admin' )
                {
                    $templates = $tpl->templateFetchList();
                    $data = array_pop( $templates );                    
                    $res = '<div class="developer-warning alert alert-danger"><strong>Avviso per lo sviluppatore</strong>:<br /><code>' . $data . '</code><br />' . $namedParameters['text'] . '</div>';
                }
                $operatorValue = $res;
            } break; 
            
            case 'editor_warning':
            {
                $res = false;
                $user = eZUser::currentUser();
                if ( $user->hasAccessTo( 'content', 'dashboard' ) )
                {
                    $res = '<div class="editor-warning alert alert-warning"><strong>Avviso per l\'editor</strong>: ' . $namedParameters['text'] . '</div>';
                }
                $operatorValue = $res;
            } break;
            
            case 'appini':
            {
                if ( $appini->hasVariable( $namedParameters['block'], $namedParameters['setting'] ) )
                {
                    $rs = $appini->variable( $namedParameters['block'], $namedParameters['setting'] );
                }
                else
                {
                    $rs = $namedParameters['default'];
                }
                $operatorValue = $rs;
            } break;
            
            case 'has_attribute':
            case 'attribute':
            {                                
                if ( $operatorName == 'attribute' && $namedParameters['show_values'] == 'show' )
                {
                    $legacy = new eZTemplateAttributeOperator();
                    return $legacy->modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, $operatorValue, $namedParameters, null );
                }
                return $operatorValue = $this->hasContentObjectAttribute( $operatorValue, $namedParameters['show_values'] );                
            } break;
            
            case 'set_defaults':
            {                                                
                foreach( $namedParameters['variables'] as $key => $value )
                {
                    if ( !$tpl->hasVariable( $key, $rootNamespace ) )
                    {
                        $tpl->setVariable( $key, $value, $rootNamespace );
                    }
                }                
            } break;
            
            //@todo add cache!
            case 'include_cache':
            {
                $tpl = eZTemplate::factory();
                foreach( $namedParameters['variables'] as $key => $value )
                {
                    $tpl->setVariable( $key, $value );
                }
                $operatorValue = $tpl->fetch( 'design:' . $namedParameters['template'] );;
            } break;
            
            case 'sort_nodes':
            {                
                $sortNodes = array();
                if ( !empty( $operatorValue ) && is_array( $operatorValue ) )
                {
                    $nodes = $operatorValue;
                    foreach( $nodes as $node )
                    {
                        if ( !$node instanceof eZContentObjectTreeNode )
                        {
                            continue;
                        }
                        
                        $object = $node->object();
                        switch ( $namedParameters['by'] )
                        {
                            case 'published':
                            default :
                            {
                                $sortby = $object->attribute( 'published' );
                            } break;
                        }
                        $sortNodes[$sortby] = $node;
                    }
                    ksort( $sortNodes );
                    
                    if ( $namedParameters['order'] == 'desc' )
                    {
                        $sortNodes = array_reverse( $sortNodes );
                    }
                }
                
                return $operatorValue = $sortNodes;
            } break;
            
            case 'to_query_string':
            {                
                if ( !empty( $namedParameters['param'] ) )
                    $value = $namedParameters['param'];
                else
                    $value = $operatorValue;
                $string = http_build_query( $value );
                return $operatorValue = $string;
            } break;
            
            case 'has_abstract':
            case 'abstract':
            {
                $has_content = false;
                $text = false;
                $node = $namedParameters['node'];
                $strlenFunc = function_exists( 'mb_strlen' ) ? 'mb_strlen' : 'strlen';
                
                if ( !$node )
                    $node = $operatorValue;

                if ( is_numeric( $node ) )
                {
                    $node = eZContentObjectTreeNode::fetch( $node );
                }

                if ( $node instanceof eZContentObjectTreeNode )
                {
                    if ( $node->hasAttribute( 'highlight' ) )
                    {                        
                        $text = $node->attribute( 'highlight' );
                        $text = str_replace( '&amp;nbsp;', ' ', $text );
                        $text = str_replace( '&nbsp;', ' ', $text );

                        if ( $strlenFunc( $text ) > 0 )
                        {
                            $has_content = true;
                        }
                    }
                    
                    if ( !$has_content )
                    {
                        $attributes = $ini->hasVariable( 'Abstract', 'Attributes' ) ? $ini->variable( 'Abstract', 'Attributes' ) : array();
                        if ( !empty( $attributes ) )
                        {
                            $dataMap = $node->dataMap();
                            foreach ( $attributes as $attr )
                            {
                                if ( isset( $dataMap[$attr] ) )
                                {
                                    if ( $dataMap[$attr]->hasContent() )
                                    {                                        
                                        
                                        $tpl = eZTemplate::factory();
                                        $tpl->setVariable( 'attribute', $dataMap[$attr] );
                                        $designPath = "design:content/datatype/view/" . $dataMap[$attr]->attribute( 'data_type_string' ) . ".tpl";
                                        $text = $tpl->fetch( $designPath );
                                        $text = str_replace( '&nbsp;', ' ', $text );
                                        
                                        if ( $strlenFunc( strip_tags( $text ) ) > 0 )
                                        {
                                            $has_content = true;
                                        }
                                        
                                        break;
                                    }
                                }
                                
                            }
                        }
                    }
                }
                 
                if ( $operatorName == 'has_abstract' )
                    return $operatorValue = $has_content;
                else
                    return $operatorValue = $text;
                
            } break;
            
            case 'subsite':
            {
                $path = $this->getPath( $tpl );
                $result = false;
                $identifiers = $ini->hasVariable( 'Subsite', 'Classes' ) ? $ini->variable( 'Subsite', 'Classes' ) : array();
                
                $root = eZContentObjectTreeNode::fetch( eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' ) );
                if ( in_array( $root->attribute( 'class_identifier' ), $identifiers ) )
                {
                    $result = $root;
                }
                
                foreach ( $path as $key => $item )
                {
                    if ( isset( $item['node_id'] ) )
                    {
                        
                        $node = eZContentObjectTreeNode::fetch( $item['node_id'] );
                        if ( in_array( $node->attribute( 'class_identifier' ), $identifiers ) )
                        {
                            $result = $node;
                        }
                    }
                }
                
                return $operatorValue = $result;
                
            } break;
            
            case 'section_color':
            {
                $path = $this->getPath( $tpl );
                $color = false;
                $attributesIdentifiers = $ini->hasVariable( 'Color', 'Attributes' ) ? $ini->variable( 'Color', 'Attributes' ) : array();
                foreach ( $path as $key => $item )
                {
                    if ( isset( $item['node_id'] ) )
                    {
                        
                        $node = eZContentObjectTreeNode::fetch( $item['node_id'] );
                        $attributes = $node->attribute( 'object' )->fetchAttributesByIdentifier( $attributesIdentifiers );
                        if ( is_array( $attributes ) )
                        {
                            foreach( $attributes as $attribute )
                            {
                                if ( $attribute->hasContent() )
                                {
                                    $color = $attribute->content();                                    
                                }
                            }
                        }
                    }
                }
                
                return $operatorValue = $color;
                
            } break;
            
            case 'oc_shorten':
            {
                $search = array(
                                '@<script[^>]*?>.*?</script>@si',  // Strip out javascript
                                '@<style[^>]*?>.*?</style>@siU'   // Strip style tags properly
                                );
                $operatorValue = preg_replace( $search, '', $operatorValue );
                
                $operatorValue = strip_tags( $operatorValue, $namedParameters['allowable_tags'] );
                $operatorValue = preg_replace( '!\s+!', ' ', $operatorValue );
                $operatorValue = str_replace( '&nbsp;', ' ', $operatorValue );

                $strlenFunc = function_exists( 'mb_strlen' ) ? 'mb_strlen' : 'strlen';
                $operatorLength = $strlenFunc( $operatorValue );
                
                if ( $operatorLength > $namedParameters['chars_to_keep'] )
                {
                    if ( $namedParameters['trim_type'] === 'middle' )
                    {
                        $appendedStrLen = $strlenFunc( $namedParameters['str_to_append'] );
                
                        if ( $namedParameters['chars_to_keep'] > $appendedStrLen )
                        {
                            $chop = $namedParameters['chars_to_keep'] - $appendedStrLen;
                
                            $middlePos = (int)($chop / 2);
                            $leftPartLength = $middlePos;
                            $rightPartLength = $chop - $middlePos;
                
                            $operatorValue = trim( $this->custom_substr( $operatorValue, 0, $leftPartLength ) . $namedParameters['str_to_append'] . $this->custom_substr( $operatorValue, $operatorLength - $rightPartLength, $rightPartLength ) );
                        }
                        else
                        {
                            $operatorValue = $namedParameters['str_to_append'];
                        }
                    }
                    else // default: trim_type === 'right'
                    {
                        $chop = $namedParameters['chars_to_keep'] - $strlenFunc( $namedParameters['str_to_append'] );                        
                        $operatorValue = $this->custom_substr( $operatorValue, 0, $chop );
                        $operatorValue = trim( $operatorValue );
                        if ( $operatorLength > $chop )
                            $operatorValue = $operatorValue.$namedParameters['str_to_append'];
                    }
                }
                
                if ( $namedParameters['allowable_tags'] !== '' )
                {
                    $operatorValue = $this->force_balance_tags( $operatorValue );                    
                }


            } break;
            
            case 'cookieset':
            {
				$key = isset( $namedParameters['cookie_name'] ) ? $namedParameters['cookie_name'] : false;
                $prefix = $ini->variable( 'CookiesSettings', 'CookieKeyPrefix' );
                $key = "{$prefix}{$key}";
        
                // Get our parameters:
				$value = $namedParameters['cookie_val'];
				$expire = $namedParameters['expiry_time'];
				
				// Check and calculate the expiry time:
				if ( $expire > 0 )
				{
					// It is a number of days:
					$expire = time()+60*60*24*$expire; 
				}
				setcookie( $key, $value, $expire, '/' );
				eZDebug::writeDebug( 'setcookie('. $key .', '. $value .', '. $expire .', "/")', __METHOD__ );
				$operatorValue = false;
				return;
                
            } break;
			
            case 'cookieget':
            {
				$key = isset( $namedParameters['cookie_name'] ) ? $namedParameters['cookie_name'] : false;
                $prefix = $ini->variable( 'CookiesSettings', 'CookieKeyPrefix' );
                $key = "{$prefix}{$key}";
                
                $operatorValue = false;

				if( isset( $_COOKIE[$key] ) )	
					$operatorValue = $_COOKIE[$key];
				
                return;
            } break;
            
            case 'check_and_set_cookies':
            {                
                $prefix = $ini->variable( 'CookiesSettings', 'CookieKeyPrefix' );
                $key = "{$prefix}{$key}";
                
                $http = eZHTTPTool::instance();
                $return = array();
                if ( $ini->hasVariable( 'Cookies', 'Cookies' ) )
                {
                    $cookies = $ini->variable( 'Cookies', 'Cookies' );
                    foreach( $cookies as $key )
                    {
                        $_key = "{$prefix}{$key}";
                        $default = isset( $_COOKIE[ $_key ] ) ? $_COOKIE[ $_key ] : $ini->variable( $key, 'Default' );
                        $value = $http->variable( $key, $default ); 
                        setcookie( $_key, $value, time()+60*60*24*365, '/' );
                        $return[$key] = $value;
                    }
                    
                }
                $operatorValue = $return;
            } break;
            
            case 'checkbrowser':
            {
				@require( 'extension/ocoperatorscollection/lib/browser_detection.php' );
                if ( function_exists( 'browser_detection' ) )
                {
                    $full = browser_detection( 'full_assoc', 2 );
                    $operatorValue = $full;
                }
                else
                {
                    eZDebug::writeError( "function browser_detection not found", __METHOD__ );
                }
            } break;
            
            case 'is_deprecated_browser':
            {
                $browser = $namedParameters['browser_array'];
				if ( $browser['browser_working'] == 'ie'
                    && $browser['browser_number'] > '7.0' )
                {
                    $operatorValue = true;
                }
                $operatorValue = false;
            } break;
            
            case 'slugize':
            {
                $operatorValue = $this->sanitize_title_with_dashes( $operatorValue );
            } break;
            
            case 'is_in_subsite':
            {
                if ( $operatorValue instanceof eZContentObject )
                {
                    $nodes = $operatorValue->attribute( 'assigned_nodes' );
                    foreach( $nodes as $node )
                    {
                        if ( $this->isNodeInCurrentSiteaccess( $node ) )
                        {
                            return $operatorValue;
                        }
                    }
                }
                elseif( $operatorValue instanceof eZContentObjectTreeNode )
                {
                    if ( $this->isNodeInCurrentSiteaccess( $operatorValue ) )
                    {
                        return $operatorValue;
                    }
                }
                return $operatorValue = false;
            }
            
        }
    }
    
    public function hasContentObjectAttribute( $object, $identifier )
    {
        if ( $object instanceof eZContentObjectTreeNode || $object instanceof eZContentObject )
        {
            $dataMap = $object->attribute( 'data_map' );
            if ( isset( $dataMap[$identifier] ) )
            {
                if ( $dataMap[$identifier] instanceof eZContentObjectAttribute )
                {
                    
                    //eZDebug::writeError( $object->attribute( 'class_identifier' ) . ' ' . $dataMap[$identifier]->attribute( 'data_type_string' ) . ' ' . $identifier, __METHOD__ );
                    
                    if ( $identifier == 'image' &&
                         $dataMap[$identifier]->attribute( 'data_type_string' ) == 'ezobjectrelationlist' &&
                         $dataMap[$identifier]->attribute( 'has_content' ) )
                    {
                        $content = explode( '-', $dataMap[$identifier]->toString() );                        
                        $firstImage = array_shift( $content );
                        $imageObject = eZContentObject::fetch( $firstImage );
                        return $this->hasContentObjectAttribute( $imageObject, 'image' );
                    }
                    
                    if ( $identifier == 'image' &&
                         $dataMap[$identifier]->attribute( 'data_type_string' ) == 'ezobjectrelation' &&
                         $dataMap[$identifier]->attribute( 'has_content' ) )
                    {                        
                        $imageObject = $dataMap[$identifier]->content();                        
                        return $this->hasContentObjectAttribute( $imageObject, 'image' );
                    }
                    
                    switch( $dataMap[$identifier]->attribute( 'data_type_string' ) )
                    {
                        case 'ezcomcomments':
                            return $dataMap[$identifier];
                        break;
                    default:
                        if ( $dataMap[$identifier]->attribute( 'has_content' ) )
                        {
                            return $dataMap[$identifier];
                        }
                    }
                }                        
            }
        }
        return false;
    }
    
    private function getPath( $tpl )
    {
        if ( $tpl->hasVariable('module_result') )
        {
           $moduleResult = $tpl->variable('module_result');
        }
        else
        {
            $moduleResult = array();
        }
        
        $viewmode = false;
        if ( isset( $moduleResult['content_info'] ) )
        {
            if ( isset( $moduleResult['content_info']['viewmode'] ) )
            {
                $viewmode = $moduleResult['content_info']['viewmode'];
            }
        }
                
        return ( isset( $moduleResult['path'] ) && is_array( $moduleResult['path'] ) ) ? $moduleResult['path'] : array();
    }
    
    private function isNodeInCurrentSiteaccess( $node )
    {
        if ( !$node instanceof eZContentObjectTreeNode )
        {
            return true;
        }
        $currentSiteaccess = eZSiteAccess::current();
        $pathPrefixExclude = eZINI::instance()->variable( 'SiteAccessSettings', 'PathPrefixExclude' );
        $aliasArray = explode( '/', $node->attribute( 'url_alias' ) );
        
        //eZDebug::writeError( var_export($aliasArray,1), __METHOD__ );
        //eZDebug::writeError( $pathPrefixExclude, __METHOD__ );
        
        foreach( $pathPrefixExclude as $ppe )
        {
            if ( strtolower( $aliasArray[0] ) == $ppe )
            {
                return true;
            }
        }
        
        $pathArray = $node->attribute( 'path_array' );
        $contentIni = eZINI::instance( 'content.ini' );
        $rootNodeArray = array(
            'RootNode',
            'UserRootNode',
            'MediaRootNode'                
        );
        
        foreach ( $rootNodeArray as $rootNodeID )
        {
            $rootNode = $contentIni->variable( 'NodeSettings', $rootNodeID );
            if ( in_array( $rootNode, $pathArray ) ) {
                return true;
            }
        }
        eZDebug::writeError( 'Il nodo ' . $node->attribute( 'name' ) . ' non si trova nel Siteaccess ' . $currentSiteaccess , __METHOD__ );
        return false;
    }
    
    private function custom_substr( $string, $start, $length )
    {
        $strlenFunc = function_exists( 'mb_strlen' ) ? 'mb_strlen' : 'strlen';
        if( $strlenFunc( $string ) > $length )
        {
			$substr = substr( $string, $start, $length );
            if ( $start == 0 )
            {
                $lastSpace = strrpos( $substr, " " );                
                $string = substr( $substr, 0, $lastSpace );
            }
            else
            {
                $firstSpace = strpos( $substr, " " );
                $string = substr( $substr, $firstSpace, $length );
            }
		}    
		return $string;
	}

	/**
	 * Sanitizes title, replacing whitespace with dashes.
	 *
	 * Limits the output to alphanumeric characters, underscore (_) and dash (-).
	 * Whitespace becomes a dash.
	 *
	 * @param string $title The title to be sanitized.
	 * @return string The sanitized title.
	 */
	function sanitize_title_with_dashes($title) {
		$title = strip_tags($title);
		// Preserve escaped octets.
		$title = preg_replace('|%([a-fA-F0-9][a-fA-F0-9])|', '---$1---', $title);
		// Remove percent signs that are not part of an octet.
		$title = str_replace('%', '', $title);
		// Restore octets.
		$title = preg_replace('|---([a-fA-F0-9][a-fA-F0-9])---|', '%$1', $title);

		$title = $this->remove_accents($title);
		if ($this->seems_utf8($title)) {
			if (function_exists('mb_strtolower')) {
				$title = mb_strtolower($title, 'UTF-8');
			}
			$title = $this->utf8_uri_encode($title, 200);
		}

		$title = strtolower($title);
		$title = preg_replace('/&.+?;/', '', $title); // kill entities
		$title = str_replace('.', '-', $title);
		$title = preg_replace('/[^%a-z0-9 _-]/', '', $title);
		$title = preg_replace('/\s+/', '-', $title);
		$title = preg_replace('|-+|', '-', $title);
		$title = trim($title, '-');
		
		$title = $this->sanitize_html_class($title);
		
		return $title;
	}
	
	function sanitize_html_class($class, $fallback = 'noclass'){
		//Strip out any % encoded octets
		$sanitized = preg_replace('|%[a-fA-F0-9][a-fA-F0-9]|', '', $class);

		//Limit to A-Z,a-z,0-9,'-'
		$sanitized = preg_replace('/[^A-Za-z0-9-]/', '', $sanitized);

		if ('' == $sanitized)
			$sanitized = $fallback;

		return $sanitized;
	}	
	
	/**
	 * Converts all accent characters to ASCII characters.
	 *
	 * If there are no accent characters, then the string given is just returned.
	 *
	 * @since 1.2.1
	 *
	 * @param string $string Text that might have accent characters
	 * @return string Filtered string with replaced "nice" characters.
	 */
	function remove_accents($string) {
		if ( !preg_match('/[\x80-\xff]/', $string) )
			return $string;

		if ($this->seems_utf8($string)) {
			$chars = array(
			// Decompositions for Latin-1 Supplement
			chr(195).chr(128) => 'A', chr(195).chr(129) => 'A',
			chr(195).chr(130) => 'A', chr(195).chr(131) => 'A',
			chr(195).chr(132) => 'A', chr(195).chr(133) => 'A',
			chr(195).chr(135) => 'C', chr(195).chr(136) => 'E',
			chr(195).chr(137) => 'E', chr(195).chr(138) => 'E',
			chr(195).chr(139) => 'E', chr(195).chr(140) => 'I',
			chr(195).chr(141) => 'I', chr(195).chr(142) => 'I',
			chr(195).chr(143) => 'I', chr(195).chr(145) => 'N',
			chr(195).chr(146) => 'O', chr(195).chr(147) => 'O',
			chr(195).chr(148) => 'O', chr(195).chr(149) => 'O',
			chr(195).chr(150) => 'O', chr(195).chr(153) => 'U',
			chr(195).chr(154) => 'U', chr(195).chr(155) => 'U',
			chr(195).chr(156) => 'U', chr(195).chr(157) => 'Y',
			chr(195).chr(159) => 's', chr(195).chr(160) => 'a',
			chr(195).chr(161) => 'a', chr(195).chr(162) => 'a',
			chr(195).chr(163) => 'a', chr(195).chr(164) => 'a',
			chr(195).chr(165) => 'a', chr(195).chr(167) => 'c',
			chr(195).chr(168) => 'e', chr(195).chr(169) => 'e',
			chr(195).chr(170) => 'e', chr(195).chr(171) => 'e',
			chr(195).chr(172) => 'i', chr(195).chr(173) => 'i',
			chr(195).chr(174) => 'i', chr(195).chr(175) => 'i',
			chr(195).chr(177) => 'n', chr(195).chr(178) => 'o',
			chr(195).chr(179) => 'o', chr(195).chr(180) => 'o',
			chr(195).chr(181) => 'o', chr(195).chr(182) => 'o',
			chr(195).chr(182) => 'o', chr(195).chr(185) => 'u',
			chr(195).chr(186) => 'u', chr(195).chr(187) => 'u',
			chr(195).chr(188) => 'u', chr(195).chr(189) => 'y',
			chr(195).chr(191) => 'y',
			// Decompositions for Latin Extended-A
			chr(196).chr(128) => 'A', chr(196).chr(129) => 'a',
			chr(196).chr(130) => 'A', chr(196).chr(131) => 'a',
			chr(196).chr(132) => 'A', chr(196).chr(133) => 'a',
			chr(196).chr(134) => 'C', chr(196).chr(135) => 'c',
			chr(196).chr(136) => 'C', chr(196).chr(137) => 'c',
			chr(196).chr(138) => 'C', chr(196).chr(139) => 'c',
			chr(196).chr(140) => 'C', chr(196).chr(141) => 'c',
			chr(196).chr(142) => 'D', chr(196).chr(143) => 'd',
			chr(196).chr(144) => 'D', chr(196).chr(145) => 'd',
			chr(196).chr(146) => 'E', chr(196).chr(147) => 'e',
			chr(196).chr(148) => 'E', chr(196).chr(149) => 'e',
			chr(196).chr(150) => 'E', chr(196).chr(151) => 'e',
			chr(196).chr(152) => 'E', chr(196).chr(153) => 'e',
			chr(196).chr(154) => 'E', chr(196).chr(155) => 'e',
			chr(196).chr(156) => 'G', chr(196).chr(157) => 'g',
			chr(196).chr(158) => 'G', chr(196).chr(159) => 'g',
			chr(196).chr(160) => 'G', chr(196).chr(161) => 'g',
			chr(196).chr(162) => 'G', chr(196).chr(163) => 'g',
			chr(196).chr(164) => 'H', chr(196).chr(165) => 'h',
			chr(196).chr(166) => 'H', chr(196).chr(167) => 'h',
			chr(196).chr(168) => 'I', chr(196).chr(169) => 'i',
			chr(196).chr(170) => 'I', chr(196).chr(171) => 'i',
			chr(196).chr(172) => 'I', chr(196).chr(173) => 'i',
			chr(196).chr(174) => 'I', chr(196).chr(175) => 'i',
			chr(196).chr(176) => 'I', chr(196).chr(177) => 'i',
			chr(196).chr(178) => 'IJ',chr(196).chr(179) => 'ij',
			chr(196).chr(180) => 'J', chr(196).chr(181) => 'j',
			chr(196).chr(182) => 'K', chr(196).chr(183) => 'k',
			chr(196).chr(184) => 'k', chr(196).chr(185) => 'L',
			chr(196).chr(186) => 'l', chr(196).chr(187) => 'L',
			chr(196).chr(188) => 'l', chr(196).chr(189) => 'L',
			chr(196).chr(190) => 'l', chr(196).chr(191) => 'L',
			chr(197).chr(128) => 'l', chr(197).chr(129) => 'L',
			chr(197).chr(130) => 'l', chr(197).chr(131) => 'N',
			chr(197).chr(132) => 'n', chr(197).chr(133) => 'N',
			chr(197).chr(134) => 'n', chr(197).chr(135) => 'N',
			chr(197).chr(136) => 'n', chr(197).chr(137) => 'N',
			chr(197).chr(138) => 'n', chr(197).chr(139) => 'N',
			chr(197).chr(140) => 'O', chr(197).chr(141) => 'o',
			chr(197).chr(142) => 'O', chr(197).chr(143) => 'o',
			chr(197).chr(144) => 'O', chr(197).chr(145) => 'o',
			chr(197).chr(146) => 'OE',chr(197).chr(147) => 'oe',
			chr(197).chr(148) => 'R',chr(197).chr(149) => 'r',
			chr(197).chr(150) => 'R',chr(197).chr(151) => 'r',
			chr(197).chr(152) => 'R',chr(197).chr(153) => 'r',
			chr(197).chr(154) => 'S',chr(197).chr(155) => 's',
			chr(197).chr(156) => 'S',chr(197).chr(157) => 's',
			chr(197).chr(158) => 'S',chr(197).chr(159) => 's',
			chr(197).chr(160) => 'S', chr(197).chr(161) => 's',
			chr(197).chr(162) => 'T', chr(197).chr(163) => 't',
			chr(197).chr(164) => 'T', chr(197).chr(165) => 't',
			chr(197).chr(166) => 'T', chr(197).chr(167) => 't',
			chr(197).chr(168) => 'U', chr(197).chr(169) => 'u',
			chr(197).chr(170) => 'U', chr(197).chr(171) => 'u',
			chr(197).chr(172) => 'U', chr(197).chr(173) => 'u',
			chr(197).chr(174) => 'U', chr(197).chr(175) => 'u',
			chr(197).chr(176) => 'U', chr(197).chr(177) => 'u',
			chr(197).chr(178) => 'U', chr(197).chr(179) => 'u',
			chr(197).chr(180) => 'W', chr(197).chr(181) => 'w',
			chr(197).chr(182) => 'Y', chr(197).chr(183) => 'y',
			chr(197).chr(184) => 'Y', chr(197).chr(185) => 'Z',
			chr(197).chr(186) => 'z', chr(197).chr(187) => 'Z',
			chr(197).chr(188) => 'z', chr(197).chr(189) => 'Z',
			chr(197).chr(190) => 'z', chr(197).chr(191) => 's',
			// Euro Sign
			chr(226).chr(130).chr(172) => 'E',
			// GBP (Pound) Sign
			chr(194).chr(163) => '');

			$string = strtr($string, $chars);
		} else {
			// Assume ISO-8859-1 if not UTF-8
			$chars['in'] = chr(128).chr(131).chr(138).chr(142).chr(154).chr(158)
				.chr(159).chr(162).chr(165).chr(181).chr(192).chr(193).chr(194)
				.chr(195).chr(196).chr(197).chr(199).chr(200).chr(201).chr(202)
				.chr(203).chr(204).chr(205).chr(206).chr(207).chr(209).chr(210)
				.chr(211).chr(212).chr(213).chr(214).chr(216).chr(217).chr(218)
				.chr(219).chr(220).chr(221).chr(224).chr(225).chr(226).chr(227)
				.chr(228).chr(229).chr(231).chr(232).chr(233).chr(234).chr(235)
				.chr(236).chr(237).chr(238).chr(239).chr(241).chr(242).chr(243)
				.chr(244).chr(245).chr(246).chr(248).chr(249).chr(250).chr(251)
				.chr(252).chr(253).chr(255);

			$chars['out'] = "EfSZszYcYuAAAAAACEEEEIIIINOOOOOOUUUUYaaaaaaceeeeiiiinoooooouuuuyy";

			$string = strtr($string, $chars['in'], $chars['out']);
			$double_chars['in'] = array(chr(140), chr(156), chr(198), chr(208), chr(222), chr(223), chr(230), chr(240), chr(254));
			$double_chars['out'] = array('OE', 'oe', 'AE', 'DH', 'TH', 'ss', 'ae', 'dh', 'th');
			$string = str_replace($double_chars['in'], $double_chars['out'], $string);
		}

		return $string;
	}

	/**
	 * Checks to see if a string is utf8 encoded.
	 *
	 * NOTE: This function checks for 5-Byte sequences, UTF8
	 *       has Bytes Sequences with a maximum length of 4.
	 *
	 * @author bmorel at ssi dot fr (modified)
	 * @since 1.2.1
	 *
	 * @param string $str The string to be checked
	 * @return bool True if $str fits a UTF-8 model, false otherwise.
	 */
	function seems_utf8($str) {
		$length = strlen($str);
		for ($i=0; $i < $length; $i++) {
			$c = ord($str[$i]);
			if ($c < 0x80) $n = 0; # 0bbbbbbb
			elseif (($c & 0xE0) == 0xC0) $n=1; # 110bbbbb
			elseif (($c & 0xF0) == 0xE0) $n=2; # 1110bbbb
			elseif (($c & 0xF8) == 0xF0) $n=3; # 11110bbb
			elseif (($c & 0xFC) == 0xF8) $n=4; # 111110bb
			elseif (($c & 0xFE) == 0xFC) $n=5; # 1111110b
			else return false; # Does not match any model
			for ($j=0; $j<$n; $j++) { # n bytes matching 10bbbbbb follow ?
				if ((++$i == $length) || ((ord($str[$i]) & 0xC0) != 0x80))
					return false;
			}
		}
		return true;
	}

	/**
	 * Encode the Unicode values to be used in the URI.
	 *
	 * @since 1.5.0
	 *
	 * @param string $utf8_string
	 * @param int $length Max length of the string
	 * @return string String with Unicode encoded for URI.
	 */
	function utf8_uri_encode( $utf8_string, $length = 0 ) {
		$unicode = '';
		$values = array();
		$num_octets = 1;
		$unicode_length = 0;

		$string_length = strlen( $utf8_string );
		for ($i = 0; $i < $string_length; $i++ ) {

			$value = ord( $utf8_string[ $i ] );

			if ( $value < 128 ) {
				if ( $length && ( $unicode_length >= $length ) )
					break;
				$unicode .= chr($value);
				$unicode_length++;
			} else {
				if ( count( $values ) == 0 ) $num_octets = ( $value < 224 ) ? 2 : 3;

				$values[] = $value;

				if ( $length && ( $unicode_length + ($num_octets * 3) ) > $length )
					break;
				if ( count( $values ) == $num_octets ) {
					if ($num_octets == 3) {
						$unicode .= '%' . dechex($values[0]) . '%' . dechex($values[1]) . '%' . dechex($values[2]);
						$unicode_length += 9;
					} else {
						$unicode .= '%' . dechex($values[0]) . '%' . dechex($values[1]);
						$unicode_length += 6;
					}

					$values = array();
					$num_octets = 1;
				}
			}
		}

		return $unicode;
	}

    /**
     * Balances tags of string using a modified stack.
     *
     * @since 2.0.4
     *
     * @author Leonard Lin <leonard@acm.org>
     * @license GPL
     * @copyright November 4, 2001
     * @version 1.1
     * @todo Make better - change loop condition to $text in 1.2
     * @internal Modified by Scott Reilly (coffee2code) 02 Aug 2004
     *		1.1  Fixed handling of append/stack pop order of end text
     *			 Added Cleaning Hooks
     *		1.0  First Version
     *
     * @param string $text Text to be balanced.
     * @return string Balanced text.
     */
    function force_balance_tags( $text ) {
        $tagstack = array();
        $stacksize = 0;
        $tagqueue = '';
        $newtext = '';
        $single_tags = array('br', 'hr', 'img', 'input'); // Known single-entity/self-closing tags
        $nestable_tags = array('blockquote', 'div', 'span'); // Tags that can be immediately nested within themselves
    
        // WP bug fix for comments - in case you REALLY meant to type '< !--'
        $text = str_replace('< !--', '<    !--', $text);
        // WP bug fix for LOVE <3 (and other situations with '<' before a number)
        $text = preg_replace('#<([0-9]{1})#', '&lt;$1', $text);

        while ( preg_match("/<(\/?[\w:]*)\s*([^>]*)>/", $text, $regex) ) {
            $newtext .= $tagqueue;
    
            $i = strpos($text, $regex[0]);
            $l = strlen($regex[0]);
    
            // clear the shifter
            $tagqueue = '';
            // Pop or Push
            if ( isset($regex[1][0]) && '/' == $regex[1][0] ) { // End Tag
                $tag = strtolower(substr($regex[1],1));
                // if too many closing tags
                if( $stacksize <= 0 ) {
                    $tag = '';
                    // or close to be safe $tag = '/' . $tag;
                }
                // if stacktop value = tag close value then pop
                else if ( $tagstack[$stacksize - 1] == $tag ) { // found closing tag
                    $tag = '</' . $tag . '>'; // Close Tag
                    // Pop
                    array_pop( $tagstack );
                    $stacksize--;
                } else { // closing tag not at top, search for it
                    for ( $j = $stacksize-1; $j >= 0; $j-- ) {
                        if ( $tagstack[$j] == $tag ) {
                        // add tag to tagqueue
                            for ( $k = $stacksize-1; $k >= $j; $k--) {
                                $tagqueue .= '</' . array_pop( $tagstack ) . '>';
                                $stacksize--;
                            }
                            break;
                        }
                    }
                    $tag = '';
                }
            } else { // Begin Tag
                $tag = strtolower($regex[1]);
    
                // Tag Cleaning
    
                // If self-closing or '', don't do anything.
                if ( substr($regex[2],-1) == '/' || $tag == '' ) {
                    // do nothing
                }
                // ElseIf it's a known single-entity tag but it doesn't close itself, do so
                elseif ( in_array($tag, $single_tags) ) {
                    $regex[2] .= '/';
                } else {	// Push the tag onto the stack
                    // If the top of the stack is the same as the tag we want to push, close previous tag
                    if ( $stacksize > 0 && !in_array($tag, $nestable_tags) && $tagstack[$stacksize - 1] == $tag ) {
                        $tagqueue = '</' . array_pop ($tagstack) . '>';
                        $stacksize--;
                    }
                    $stacksize = array_push ($tagstack, $tag);
                }
    
                // Attributes
                $attributes = $regex[2];
                if( !empty($attributes) )
                    $attributes = ' '.$attributes;
    
                $tag = '<' . $tag . $attributes . '>';
                //If already queuing a close tag, then put this tag on, too
                if ( !empty($tagqueue) ) {
                    $tagqueue .= $tag;
                    $tag = '';
                }
            }
            $newtext .= substr($text, 0, $i) . $tag;
            $text = substr($text, $i + $l);
        }
    
        // Clear Tag Queue
        $newtext .= $tagqueue;
    
        // Add Remaining text
        $newtext .= $text;
    
        // Empty Stack
        while( $x = array_pop($tagstack) )
            $newtext .= '</' . $x . '>'; // Add remaining tags to close
    
        // WP fix for the bug with HTML comments
        $newtext = str_replace("< !--","<!--",$newtext);
        $newtext = str_replace("<    !--","< !--",$newtext);
    
        return $newtext;
    }

}

?>