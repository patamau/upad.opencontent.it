<?php

class UpadInvoiceMeta
{
    protected $invoice;
    protected $subscription;
    protected $course;
    protected $area;
    protected $amount;



    public static function createFromItems( eZUpadInvoice $invoice, array $items )
    {
        echo '<pre>';
        foreach ($items as $k => $v)
        {
            $course = eZContentObject::fetch($k);
            if ($course instanceof eZContentObject)
            {
                $courseDataMap = $course->dataMap();
                $relArea = $courseDataMap['codice_area']->content();
                $invoiceMeta = eZUpadInvoiceMeta::create( $invoice->attribute('id'), 0, $k, $relArea['relation_list'][0]['contentobject_id'], round( $v['total'], 2 ) );
            }
        }
    }

    public static function getReport($ente = false, $fromTime = false, $toTime = false)
    {
        $rows = array();
        $filter = '';
        if ($ente)
        {
            $filter .= (!empty($filter) ? " AND" : " WHERE" );
            $filter .= " i.ente_id = $ente";
        }

        if ($fromTime)
        {
            $filter .= (!empty($filter) ? " AND" : " WHERE" );
            $filter .= " i.date >= $fromTime";
        }

        if ($toTime)
        {
            $filter .= (!empty($filter) ? " AND" : " WHERE" );
            $filter .= " i.date <= $toTime";
        }

        $query = "SELECT m.area_id, SUM(m.amount) AS total 
             FROM upad_invoice AS i LEFT JOIN upad_invoice_meta as m on i.id = m.invoice_id
             $filter
             GROUP BY area_id
             ORDER BY m.area_id ASC";
        $db = eZDB::instance();
        $result = $db->arrayQuery($query);
        foreach ($result as $r)
        {
            if ($r['area_id'])
            {
                $rows[$r['area_id']] = $r['total'];
            }
        }
        return $rows;
    }

    public static function getReportByCourseAndArea($ente = false, $fromTime = false, $toTime = false)
    {
        $rows = array();
        $filter = '';
        if ($ente)
        {
            $filter .= (!empty($filter) ? " AND" : " WHERE" );
            $filter .= " i.ente_id = $ente";
        }

        if ($fromTime)
        {
            $filter .= (!empty($filter) ? " AND" : " WHERE" );
            $filter .= " i.date >= $fromTime";
        }

        if ($toTime)
        {
            $filter .= (!empty($filter) ? " AND" : " WHERE" );
            $filter .= " i.date <= $toTime";
        }



        $query = "SELECT m.course_id, m.area_id, SUM(m.amount) AS total 
             FROM upad_invoice AS i LEFT JOIN upad_invoice_meta as m on i.id = m.invoice_id
             $filter
             GROUP BY course_id, area_id
             ORDER BY m.area_id ASC";

        $db = eZDB::instance();
        $result = $db->arrayQuery($query);
        foreach ($result as $r)
        {
            if ($r['area_id'])
            {
                $rows[$r['area_id']][$r['course_id']] = $r['total'];
            }
        }
        return $rows;
    }


    protected function __construct()
    {
    }

    public function setProductList( array $productList, eZOrder $order )
    {

    }


    public function attributes()
    {
        return array(
            'invoice',
            'subscription',
            'course',
            'area',
            'amount'
        );
    }

    public function hasAttribute( $key )
    {
        return in_array( $key, $this->attributes() );
    }

    public function attribute( $key )
    {
        if ( isset( $this->{$key} ) )
        {
            return $this->{$key};
        }
        eZDebug::writeError( "Attribute $key not found", __METHOD__ );
        return false;
    }
}
