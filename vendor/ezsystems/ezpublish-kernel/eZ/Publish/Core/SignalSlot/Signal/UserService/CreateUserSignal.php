<?php
/**
 * CreateUserSignal class
 *
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 * @version 2014.07.0
 */

namespace eZ\Publish\Core\SignalSlot\Signal\UserService;

use eZ\Publish\Core\SignalSlot\Signal;

/**
 * CreateUserSignal class
 * @package eZ\Publish\Core\SignalSlot\Signal\UserService
 */
class CreateUserSignal extends Signal
{
    /**
     * User ID
     *
     * @var mixed
     */
    public $userId;
}
