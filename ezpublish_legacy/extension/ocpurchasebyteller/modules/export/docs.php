<?php

$module    = $Params['Module'];
$tpl       = eZTemplate::factory();
$http      = eZHTTPTool::instance();

$type      =  $Params['Type'] ;
$currentId = intval( $Params['ID'] );

$current = $currentId > 0 ? eZContentObject::fetch( $currentId ) : false;

$Result = array();
if ( $current instanceof eZContentObject && $current->attribute( 'class_identifier' ) == 'corso' )
{
    switch ($type) {
        case 'teachers_lessons':

            $tpl->setVariable( "course", $current );
            $Result['path'] = array(
                array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
                array( 'text' => $current->attribute( 'name' ). '-docs-teachers-lessons', 'url' => false ),
            );
            $Result['content'] = $tpl->fetch( 'design:export/teachers_lessons.tpl' );

            break;

        case 'teachers_attendance':

            $tpl->setVariable( "course", $current );
            $Result['path'] = array(
                array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
                array( 'text' => $current->attribute( 'name' ). '-docs-teachers-attendance', 'url' => false ),
            );
            $Result['content'] = $tpl->fetch( 'design:export/teachers_attendance.tpl' );

            break;

        case 'attendance':

            $tpl->setVariable( "course", $current );
            $Result['path'] = array(
                array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
                array( 'text' => $current->attribute( 'name' ). '-docs-attendance', 'url' => false ),
            );
            $Result['content'] = $tpl->fetch( 'design:export/attendance.tpl' );

            break;

        case 'subscriptions':

            $tpl->setVariable( "course", $current );
            $Result['path'] = array(
                array( 'text' => "Gestione Corsi", 'url' => 'courses/list' ),
                array( 'text' => $current->attribute( 'name' ). '-docs-subscriptions', 'url' => false ),
            );
            $Result['content'] = $tpl->fetch( 'design:export/subscriptions.tpl' );

            break;

        default:
            break;
    }

}
