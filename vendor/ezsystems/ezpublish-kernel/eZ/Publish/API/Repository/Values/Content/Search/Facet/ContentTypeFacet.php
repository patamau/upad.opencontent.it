<?php
/**
 * File containing the eZ\Publish\API\Repository\Values\Content\Search\Facet\ContentTypeFacet class.
 *
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 * @version 2014.07.0
 *
 * @package eZ\Publish\API\Repository\Values\Content\Search\Facet
 */
namespace eZ\Publish\API\Repository\Values\Content\Search\Facet;

use eZ\Publish\API\Repository\Values\Content\Search\Facet;

/**
 * This class holds counts of content with content type
 *
 */
class ContentTypeFacet extends Facet
{
    /**
     * An array with contentTypeIdentifier as key and count of matching content objects as value
     *
     * @var array
     */
    public $entries;
}
