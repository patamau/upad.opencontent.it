<?php

$module = $Params['Module'];
$tpl = eZTemplate::factory();
$http = eZHTTPTool::instance();
//$userParameters = $Params['UserParameters'];

$currentId = intval( $Params['ID'] );
$type      =  $Params['Type'] ;

$current = $currentId > 0 ? eZContentObject::fetch( $currentId ) : false;

$Result = array();
if ( $current instanceof eZContentObject && $current->attribute( 'class_identifier' ) == 'corso' )
{
    if ($type && $type == 'full')
    {
        try
        {
            $exporter = new CSVSubscriptionsExporterFull( 1, 'subscription' );
        }
        catch ( InvalidArgumentException $e )
        {
            eZDebug::writeError( $e->getMessage(), __FILE__ );
            return $Module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
        }
        catch ( Exception $e )
        {
            eZDebug::writeError( $e->getMessage(), __FILE__ );
            return $Module->handleError( eZError::KERNEL_ACCESS_DENIED, 'kernel' );
        }

        ob_get_clean(); //chiudo l'ob_start dell'index.php
        //$length = 50;
        //$attributefilter = array();
        $attributefilter[]= array( 'subscription/course','=', $currentId);
        $params = array(
            'AttributeFilter'  => $attributefilter
        );
        $exporter->setFetchParameters( $params );
        $exporter->handleDownload();
    }
    else
    {
        try
        {
            $exporter = new CSVSubscriptionsExporter( 1, 'subscription' );
        }
        catch ( InvalidArgumentException $e )
        {
            eZDebug::writeError( $e->getMessage(), __FILE__ );
            return $Module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
        }
        catch ( Exception $e )
        {
            eZDebug::writeError( $e->getMessage(), __FILE__ );
            return $Module->handleError( eZError::KERNEL_ACCESS_DENIED, 'kernel' );
        }

        ob_get_clean(); //chiudo l'ob_start dell'index.php
        //$length = 50;
        //$attributefilter = array();
        $attributefilter[]= array( 'subscription/course','=', $currentId);
        $params = array(
            'AttributeFilter'  => $attributefilter
        );
        $exporter->setFetchParameters( $params );
        $exporter->handleDownload();
    }



    eZExecution::cleanExit();
    //$Result['content'] = $tpl->fetch( 'design:courses/single.tpl' );

}
else
{
    $Result['path'] = array( array( 'text' => "Gestione Corsi", 'url' => false ) );
    $Result['content'] = $tpl->fetch( 'design:courses/list.tpl' );
}
