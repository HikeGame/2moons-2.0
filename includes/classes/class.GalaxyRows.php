<?php

/**
 *  2Moons
 *   by Jan-Otto Kröpke 2009-2016
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package 2Moons
 * @author Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/jkroepke/2Moons
 */

require_once 'includes/pages/game/ShowPhalanxPage.class.php';

class GalaxyRows
{
    private $Galaxy;
    private $System;
    private $galaxyData;
    private $galaxyRow;

    const PLANET_DESTROYED = false;

    function __construct()
    {
        // noothing to do at this time
    }

    public function setGalaxy($Galaxy)
    {
        $this->Galaxy = $Galaxy;
        return $this;
    }

    public function setSystem($System)
    {
        $this->System = $System;
        return $this;
    }

    public function getGalaxyData()
    {
        global $USER;

        $sql = 'SELECT SQL_BIG_RESULT DISTINCT
		p.galaxy, p.system, p.planet, p.id, p.id_owner, p.name, p.image, p.last_update, p.diameter, p.temp_min, p.destruyed, p.der_metal, p.der_crystal, p.id_luna, 
		u.id as userid, u.ally_id, u.username, u.onlinetime, u.urlaubs_modus, u.banaday, 
		m.id as m_id, m.diameter as m_diameter, m.name as m_name, m.temp_min as m_temp_min, m.last_update as m_last_update,
		s.total_points, s.total_rank, 
		a.id as allyid, a.ally_tag, a.ally_web, a.ally_members, a.ally_name, 
		allys.total_rank as ally_rank,
		COUNT(buddy.id) as buddy,
		d.level as diploLevel
		FROM %%PLANETS%% p
		LEFT JOIN %%USERS%% u ON p.id_owner = u.id
		LEFT JOIN %%PLANETS%% m ON m.id = p.id_luna
		LEFT JOIN %%STATPOINTS%% s ON s.id_owner = u.id AND s.stat_type = :statTypeUser
		LEFT JOIN %%ALLIANCE%% a ON a.id = u.ally_id
		LEFT JOIN %%DIPLO%% as d ON (d.owner_1 = :allianceId AND d.owner_2 = a.id) OR (d.owner_1 = a.id AND d.owner_2 = :allianceId) AND d.accept = :accept
		LEFT JOIN %%STATPOINTS%% allys ON allys.stat_type = :statTypeAlliance AND allys.id_owner = a.id
		LEFT JOIN %%BUDDY%% buddy ON (buddy.sender = :userId AND buddy.owner = u.id) OR (buddy.sender = u.id AND buddy.owner = :userId)
		WHERE p.universe = :universe AND p.galaxy = :galaxy AND p.system = :system AND p.planet_type = :planetTypePlanet
		GROUP BY p.id;';

        $galaxyResult = Database::get()->select($sql, array(
            ':statTypeUser'     => 1,
            ':statTypeAlliance' => 2,
            ':allianceId'       => $USER['ally_id'],
            ':userId'           => $USER['id'],
            ':universe'         => Universe::current(),
            ':galaxy'           => $this->Galaxy,
            ':system'           => $this->System,
            ':planetTypePlanet' => 1,
            ':accept'           => 1,
        ));

        foreach($galaxyResult as $galaxyRow){
            $this->galaxyRow = $galaxyRow;

            if($this->galaxyRow['destruyed'] != 0){
                $this->galaxyData[$this->galaxyRow['planet']] = self::PLANET_DESTROYED;
                continue;
            }

            $this->galaxyData[$this->galaxyRow['planet']] = array();

            $this->isOwnPlanet();
            $this->setLastActivity();

            $this->getAllowedMissions();

            $this->getPlayerData();
            $this->getPlanetData();
            $this->getAllianceData();
            $this->getDebrisData();
            $this->getMoonData();
            $this->getActionButtons();
        }

        return $this->galaxyData;
    }

    protected function setLastActivity()
    {
        global $LNG;

        $lastActivity = floor((TIMESTAMP - max($this->galaxyRow['last_update'], $this->galaxyRow['m_last_update'])) / 60);

        if($lastActivity < 15){
            $this->galaxyData[$this->galaxyRow['planet']]['lastActivity'] = $LNG['gl_activity'];
        }
        elseif($lastActivity < 60){
            $this->galaxyData[$this->galaxyRow['planet']]['lastActivity'] = sprintf($LNG['gl_activity_inactive'], $lastActivity);
        }
        else{
            $this->galaxyData[$this->galaxyRow['planet']]['lastActivity'] = '';
        }
    }

    protected function isOwnPlanet()
    {
        global $USER;

        $this->galaxyData[$this->galaxyRow['planet']]['ownPlanet'] = $this->galaxyRow['id_owner'] == $USER['id'];
    }

    protected function getAllowedMissions()
    {
        global $PLANET, $resource;

        $this->galaxyData[$this->galaxyRow['planet']]['missions'] = array(
            1  => !$this->galaxyData[$this->galaxyRow['planet']]['ownPlanet'] && isModuleAvailable(MODULE_MISSION_ATTACK),
            3  => isModuleAvailable(MODULE_MISSION_TRANSPORT),
            4  => $this->galaxyData[$this->galaxyRow['planet']]['ownPlanet'] && isModuleAvailable(MODULE_MISSION_STATION),
            5  => !$this->galaxyData[$this->galaxyRow['planet']]['ownPlanet'] && isModuleAvailable(MODULE_MISSION_HOLD),
            6  => !$this->galaxyData[$this->galaxyRow['planet']]['ownPlanet'] && isModuleAvailable(MODULE_MISSION_SPY),
            8  => isModuleAvailable(MODULE_MISSION_RECYCLE),
            9  => !$this->galaxyData[$this->galaxyRow['planet']]['ownPlanet'] && $PLANET[$resource[214]] > 0 && isModuleAvailable(MODULE_MISSION_DESTROY),
            10 => !$this->galaxyData[$this->galaxyRow['planet']]['ownPlanet'] && $PLANET[$resource[503]] > 0 && isModuleAvailable(MODULE_MISSION_ATTACK) && isModuleAvailable(MODULE_MISSILEATTACK) && $this->inMissileRange(),
        );
    }

    protected function inMissileRange()
    {
        global $USER, $PLANET, $resource;

        if($this->galaxyRow['galaxy'] != $PLANET['galaxy']){
            return false;
        }

        $Range = FleetFunctions::GetMissileRange($USER[$resource[117]]);
        $systemMin = $PLANET['system'] - $Range;
        $systemMax = $PLANET['system'] + $Range;

        return $this->galaxyRow['system'] >= $systemMin && $this->galaxyRow['system'] <= $systemMax;
    }

    protected function getActionButtons()
    {
        global $USER;
        if($this->galaxyData[$this->galaxyRow['planet']]['ownPlanet']){
            $this->galaxyData[$this->galaxyRow['planet']]['action'] = false;
        }
        else{
            $this->galaxyData[$this->galaxyRow['planet']]['action'] = array(
                'esp'     => $USER['settings_esp'] == 1 && $this->galaxyData[$this->galaxyRow['planet']]['missions'][6],
                'message' => $USER['settings_wri'] == 1 && isModuleAvailable(MODULE_MESSAGES),
                'buddy'   => $USER['settings_bud'] == 1 && isModuleAvailable(MODULE_BUDDYLIST) && $this->galaxyRow['buddy'] == 0,
                'missle'  => $USER['settings_mis'] == 1 && $this->galaxyData[$this->galaxyRow['planet']]['missions'][10],
            );
        }
    }

    protected function getPlayerData()
    {
        global $USER, $LNG;

        
        $USER["total_points"] = $this->galaxyRow["total_points"];
        
        $IsNoobProtec = CheckNoobProtec($USER, $this->galaxyRow, $this->galaxyRow);
        $Class = array();
    

        if($this->galaxyRow['banaday'] > TIMESTAMP && $this->galaxyRow['urlaubs_modus'] == 1){
            $Class = array('vacation', 'banned');
        }
        elseif($this->galaxyRow['banaday'] > TIMESTAMP){
            $Class = array('banned');
        }
        elseif($this->galaxyRow['urlaubs_modus'] == 1){
            $Class = array('vacation');
        }
        elseif($this->galaxyRow['onlinetime'] < TIMESTAMP - INACTIVE_LONG){
            $Class = array('inactive', 'longinactive');
        }
        elseif($this->galaxyRow['onlinetime'] < TIMESTAMP - INACTIVE){
            $Class = array('inactive');
        }
        elseif($IsNoobProtec['NoobPlayer']){
            $Class = array('noob');
        }
        elseif($IsNoobProtec['StrongPlayer']){
            $Class = array('strong');
        }
        

        $this->galaxyData[$this->galaxyRow['planet']]['user'] = array(
            'id'         => $this->galaxyRow['userid'],
            'username'   => htmlspecialchars($this->galaxyRow['username'], ENT_QUOTES, "UTF-8"),
            'rank'       => $this->galaxyRow['total_rank'],
            'points'     => pretty_number($this->galaxyRow['total_points']),
            'playerrank' => isModuleAvailable(25) ? sprintf($LNG['gl_in_the_rank'], htmlspecialchars($this->galaxyRow['username'], ENT_QUOTES, "UTF-8"), $this->galaxyRow['total_rank']) : htmlspecialchars($this->galaxyRow['username'], ENT_QUOTES, "UTF-8"),
            'class'      => $Class,
            'isBuddy'    => $this->galaxyRow['buddy'] == 0,
        );
    }

    protected function getAllianceData()
    {
        global $USER, $LNG;
        if(empty($this->galaxyRow['allyid'])){
            $this->galaxyData[$this->galaxyRow['planet']]['alliance'] = false;
        }
        else{
            $Class = array();
            switch($this->galaxyRow['diploLevel']){
                case 1:
                case 2:
                    $Class = array('member');
                    break;
                case 4:
                    $Class = array('friend');
                    break;
                case 5:
                default:
                    $Class = array('enemy');
                    break;
            }

            if($USER['ally_id'] == $this->galaxyRow['ally_id']){
                $Class = array('member');
            }

            $this->galaxyData[$this->galaxyRow['planet']]['alliance'] = array(
                'id'     => $this->galaxyRow['allyid'],
                'name'   => htmlspecialchars($this->galaxyRow['ally_name'], ENT_QUOTES, "UTF-8"),
                'member' => sprintf(($this->galaxyRow['ally_members'] == 1) ? $LNG['gl_member_add'] : $LNG['gl_member'], $this->galaxyRow['ally_members']),
                'web'    => $this->galaxyRow['ally_web'],
                'tag'    => $this->galaxyRow['ally_tag'],
                'rank'   => $this->galaxyRow['ally_rank'],
                'class'  => $Class,
            );
        }
    }

    protected function getDebrisData()
    {
        $total = $this->galaxyRow['der_metal'] + $this->galaxyRow['der_crystal'];
        if($total == 0){
            $this->galaxyData[$this->galaxyRow['planet']]['debris'] = false;
        }
        else{
            $this->galaxyData[$this->galaxyRow['planet']]['debris'] = array(
                'metal'   => $this->galaxyRow['der_metal'],
                'crystal' => $this->galaxyRow['der_crystal'],
            );
        }
    }

    protected function getMoonData()
    {
        if(!isset($this->galaxyRow['m_id'])){
            $this->galaxyData[$this->galaxyRow['planet']]['moon'] = false;
        }
        else{
            $this->galaxyData[$this->galaxyRow['planet']]['moon'] = array(
                'id'       => $this->galaxyRow['m_id'],
                'name'     => htmlspecialchars($this->galaxyRow['m_name'], ENT_QUOTES, "UTF-8"),
                'temp_min' => $this->galaxyRow['m_temp_min'],
                'diameter' => $this->galaxyRow['m_diameter'],
            );
        }
    }

    protected function getPlanetData()
    {
        $this->galaxyData[$this->galaxyRow['planet']]['planet'] = array(
            'id'      => $this->galaxyRow['id'],
            'name'    => htmlspecialchars($this->galaxyRow['name'], ENT_QUOTES, "UTF-8"),
            'image'   => $this->galaxyRow['image'],
            'phalanx' => isModuleAvailable(MODULE_PHALANX) && ShowPhalanxPage::allowPhalanx($this->galaxyRow['galaxy'], $this->galaxyRow['system']),
        );
    }

    public function getSectorData($system, $galaxy): array
    {

        
        $SectorResult = [];

        for($x = 1; $x <= $galaxy; $x++){
            for($y = 1; $y <= $system; $y++){

                $sql = "SELECT  COUNT(p.id) anz FROM %%PLANETS%% p WHERE p.galaxy = :galaxy AND p.system = :system AND p.universe = :universe";

                $SectorResult[$x][$y] = Database::get()->select($sql, array(
                    ':galaxy'   => $x,
                    ':system'   => $y,
                    ':universe' => Universe::current(),
                ));

            }
        }

        return $SectorResult;
    }

}
