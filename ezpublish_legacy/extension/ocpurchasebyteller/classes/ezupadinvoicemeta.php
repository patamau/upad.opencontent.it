<?php

/*

CREATE TABLE IF NOT EXISTS `upad_invoice_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `amount` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


ALTER TABLE `upad_invoice_meta`
  ADD KEY `index_course_id` (`course_id`),
  ADD KEY `index_invoice_id` (`invoice_id`) USING BTREE,
  ADD KEY `index_area_id` (`area_id`);

*/
class eZUpadInvoiceMeta extends eZPersistentObject
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
                'subscription_id' => array(
                    'name' => 'SubscriptionID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'course_id' => array(
                    'name' => 'CourseID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'area_id' => array(
                    'name' => 'AreaID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'amount' => array(
                    'name' => 'Amount',
                    'datatype' => 'text',
                    'default' => '0',
                    'required' => false
                )
            ),
            "increment_key" => "id",
            'keys' => array( 'invoice_id', 'course_id' ),
            'class_name' => 'eZUpadInvoiceMeta',
            'name' => 'upad_invoice_meta',
            'function_attributes' => array(
                "subscription" => "subscription",
                "course" => "course",
                "area" => "area"
            )
        );
    }

    public static function fetch( $id )
    {
        $result = parent::fetchObject( self::definition(), null, array( 'id' => $id ) );
        return $result;
    }

    function eZUpadInvoiceMeta( $row )
    {
        $this->eZPersistentObject( $row );
    }

    public static function create( $invoiceId, $subscriptionId, $courseId, $areaId, $amount )
    {
        $row = array(
            'invoice_id' => $invoiceId,
            'subscription_id' => $subscriptionId,
            'course_id' => $courseId,
            'area_id' => $areaId,
            'amount' => $amount
        );
        $invoiceMeta = new eZUpadInvoiceMeta( $row );
        $invoiceMeta->store();
        return $invoiceMeta;
    }

    /**
     * @return eZContentObject
     */
    public function subscription()
    {
        return eZContentObject::fetch( $this->attribute( 'ente_id' ) );
    }

    /**
     * @return eZContentObject
     */
    public function course()
    {
        return eZContentObject::fetch( $this->attribute( 'course_id' ) );
    }

    /**
     * @return eZContentObject
     */
    public function area()
    {
        return eZContentObject::fetch( $this->attribute( 'area_id' ) );
    }

    public static function fetchByInvoice( $invoiceId )
    {
        $result = parent::fetchObjectList( self::definition(), null, array( 'invoice_id' => $invoiceId ) );
        return $result;
    }

    public static function fetchList($cond)
    {
        $result = parent::fetchObjectList( self::definition(), null, $cond );
        return $result;
    }
}
