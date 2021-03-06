<?php
/**
 * File containing the VersionInfo parser class
 *
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 * @version 2014.07.0
 */

namespace eZ\Publish\Core\REST\Client\Input\Parser;

use eZ\Publish\Core\REST\Common\Input\BaseParser;
use eZ\Publish\Core\REST\Common\Input\ParsingDispatcher;
use eZ\Publish\Core\REST\Common\Input\ParserTools;
use eZ\Publish\Core\REST\Client\Values;
use eZ\Publish\API\Repository\ContentService;

/**
 * Parser for VersionInfo
 */
class VersionInfo extends BaseParser
{
    /**
     * @var \eZ\Publish\Core\REST\Common\Input\ParserTools
     */
    protected $parserTools;

    /**
     * Content Service
     *
     * @var \eZ\Publish\Core\REST\Client\ContentService
     */
    protected $contentService;

    /**
     * @param \eZ\Publish\Core\REST\Common\Input\ParserTools $parserTools
     * @param \eZ\Publish\API\Repository\ContentService $contentService
     */
    public function __construct( ParserTools $parserTools, ContentService $contentService )
    {
        $this->parserTools = $parserTools;
        $this->contentService = $contentService;
    }

    /**
     * Parse input structure
     *
     * @param array $data
     * @param \eZ\Publish\Core\REST\Common\Input\ParsingDispatcher $parsingDispatcher
     *
     * @todo Error handling
     *
     * @return \eZ\Publish\API\Repository\Values\Content\VersionInfo
     */
    public function parse( array $data, ParsingDispatcher $parsingDispatcher )
    {
        $contentInfoId = $this->parserTools->parseObjectElement( $data['Content'], $parsingDispatcher );

        return new Values\Content\VersionInfo(
            $this->contentService,
            array(
                'id' => $data['id'],
                'versionNo' => $data['versionNo'],
                'status' => $this->convertVersionStatus( $data['status'] ),
                'modificationDate' => new \DateTime( $data['modificationDate'] ),
                'creatorId' => $data['Creator']['_href'],
                'creationDate' => new \DateTime( $data['creationDate'] ),
                'initialLanguageCode' => $data['initialLanguageCode'],
                'languageCodes' => explode( ',', $data['languageCodes'] ),
                'names' => $this->parserTools->parseTranslatableList( $data['names'] ),
                'contentInfoId' => $contentInfoId,
            )
        );
    }

    /**
     * Converts the given $statusString to its constant representation
     *
     * @param string $statusString
     *
     * @return int
     */
    protected function convertVersionStatus( $statusString )
    {
        switch ( strtoupper( $statusString ) )
        {
            case 'PUBLISHED':
                return Values\Content\VersionInfo::STATUS_PUBLISHED;
            case 'DRAFT':
                return Values\Content\VersionInfo::STATUS_DRAFT;
            case 'ARCHIVED':
                return Values\Content\VersionInfo::STATUS_ARCHIVED;
        }
        throw new \RuntimeException(
            sprintf( 'Unknown version status: "%s"', $statusString )
        );
    }
}
