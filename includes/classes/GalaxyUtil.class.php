<?php

/**
 *  Space-Tactics
 *   by ShaoKhan 2021-2021
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package Space-Tactics
 * @author ShaoKhan <support@space-tactics.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2021 ShaoKhan <support@space-tactics.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/ShaoKhan/2moons-2.0
 */

class GalaxyUtil
{

    public function __construct()
    {
        $this->db = Database::get();
    }

    public function getSystemInfo($x, $y)
    {

        $res = $this->db->select('SELECT p.name, p.id_owner, pl.username, pl.ally_id FROM ' . Universe::current().' WHERE x= :x  AND y= :y AND universe = :universe',
                                 array(
                                     ':galaxy'   => $x,
                                     ':system'   => $y,
                                     ':universe' => Universe::current(),
                                 ));
    }

}
