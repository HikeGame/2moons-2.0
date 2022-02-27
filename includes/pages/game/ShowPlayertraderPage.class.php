<?php

/**
 *  Space-Tactics
 *  by Silvio Habel 2021
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package Space-Tactics
 * @author Silvio Habel <Silvio.Habel@gamil.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2021 Silvio Habel <Silvio.Habel@gmail.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/ShaoKhan/2moons-2.0
 */




class ShowPlayertraderPage extends AbstractGamePage
{
    
    function __construct()
    {
        parent::__construct();
    }
    
    public function show()
    {
        global $USER, $PLANET, $resource, $LNG, $reslist;
        $db = Database::get();
        
        //select today change course
        $select = "SELECT *, DATE(setDate) FROM %%PLAYERTRADER_COURSE%% WHERE DATE(setDate) = CURDATE() ORDER by setDate DESC LIMIT 1; ";
        $course = $db->select($select, []);
        
        if(!isset($course) || empty($course)){
            $select = "SELECT *, DATE(setDate) FROM %%PLAYERTRADER_COURSE%% WHERE setDate < DATE_ADD(NOW(), INTERVAL -1 HOUR) ORDER by setDate DESC LIMIT 1; ";
            $course = $db->select($select, []);
        }
        
        //get Player trades
        $trades           = "SELECT pt.*, u.username FROM %%PLAYERTRADER%% pt, %%USERS%% u WHERE pt.playerId = u.id  ORDER BY pt.startDate DESC";
        $tradesCollection = Database::get()->select($trades);
        
        $this->tplObj->loadscript('playertrader.js');
        $this->assign(["Trades"   => $tradesCollection,
                       "CourseCD" => $course[0]["CD"],
                       "CourseCM" => $course[0]["CM"],
                       "CourseMD" => $course[0]["MD"],
                       "CourseMC" => $course[0]["MC"],
                       "CourseDC" => $course[0]["DC"],
                       "CourseDM" => $course[0]["DM"],
                      ]);
        
        $this->display('page.playertrader.default.tpl');
    }
    
    /**
     * sends Resources to the Trader and removes them from the actual Player-Planet
     *
     * @throws Exception
     */
    public function sendResources()
    {
        global $USER, $PLANET, $LNG;
        
        $param        = [':planetId' => $PLANET['id']];
        $rescount     = htmlspecialchars($_POST["rescount"], ENT_QUOTES, "UTF-8");
        $resname      = htmlspecialchars($_POST["res"], ENT_QUOTES, "UTF-8");
        $changeName   = htmlspecialchars($_POST["sendres"], ENT_QUOTES, "UTF-8");
        $changeAmount = htmlspecialchars($_POST["getrescount"], ENT_QUOTES, "UTF-8");
        
        //get current resources from player
        $planeteResource = $this::getResources($resname);
        
        if($rescount <= $planeteResource){
            
            $newOnPlanetResource = $planeteResource - (int)$rescount;
            $newOnPlanetResource = (double)$newOnPlanetResource;
            
            //remove resources from player
            $vals = [$resname.' = '.$newOnPlanetResource, 'last_update = '.time()];
            $rem  = "UPDATE %%PLANETS%% SET ".implode(',', $vals)." WHERE id = :planetId;";
            Database::get()->update($rem, $param);
            $PLANET[$resname] = $newOnPlanetResource;
            $this->ecoObj->setData($USER, $PLANET);
            $this->ecoObj->ReBuildCache();
            [$USER, $PLANET] = $this->ecoObj->getData();
            $PLANET['eco_hash'] = $this->ecoObj->CreateHash();
            
            //insert into trader
            $this::setToTrader($USER["id"], $resname, $rescount, $changeAmount, $changeName, $USER["galaxy"], $USER["system"], $USER["planet"]);
            
            $this->printMessage($rescount." ".ucfirst($LNG[$resname])."  wurden verschickt.", [['label' => "weiter", 'url' => 'game.php?page=playertrader']]);
        }
        else{
            $this->printMessage("Nicht genügend Resourcen vorhanden", [['label' => "weiter", 'url' => 'game.php?page=playertrader']]);
        }
    }
    
    /**
     * selects given resource from player and players planet
     *
     * @param $resname
     * @return int
     * @throws Exception
     */
    private function getResources($resname): int
    {
        global $USER;
        $db = Database::get();
        
        $select           = "SELECT ".$resname." FROM %%PLANETS%% WHERE id_owner = :playerId and universe = :universe and galaxy = :galaxy and system = :sys and planet = :planet;";
        $planeteResources = $db->select($select, [
            ':playerId' => $USER["id"],
            ':universe' => $USER["universe"],
            ':galaxy'   => $USER["galaxy"],
            ':sys'      => $USER["system"],
            ':planet'   => $USER["planet"],
        ]);
        
        return (int)$planeteResources[0][$resname];
    }
    
    /**
     * inserts resources to the trader table
     *
     * @param $uid
     * @param $resName
     * @param $resCount
     * @param $changeAmount
     * @param $changeName
     * @param $gala
     * @param $system
     * @param $planet
     * @throws Exception
     */
    private function setToTrader($uid, $resName, $resCount, $changeAmount, $changeName, $gala, $system, $planet)
    {
        
        $trader = 'INSERT INTO %%PLAYERTRADER%% (playerId,startDate,resType,resCount, changeAmount, changeRes, fromGalaxy,fromSystem,fromPlanet) VALUES (:userId,:datum,:resType,:rescount,:changeAmount, :changeRes, :galaxy,:sys,:planet);';
        
        Database::get()->insert($trader, [
            ':userId'       => $uid,
            ':datum'        => date('Y-m-d H:i:s'),
            ':resType'      => "$resName",
            ':rescount'     => "$resCount",
            ':changeAmount' => $changeAmount,
            ':changeRes'    => "$changeName",
            ':galaxy'       => $gala,
            ':sys'          => $system,
            ':planet'       => $planet,
        ]);
    }
    
    public function tradeResources()
    {
        global $USER, $PLANET, $LNG;
        
        
        $trade        = TRUE;
        $tradeMessage = "";
        $acceptedRes  = ["D", "M", "C"];
        $buyAmount    = htmlspecialchars($_POST["buyAmount"], ENT_QUOTES, "UTF-8");
        $split        = htmlspecialchars($_POST["honeypot"], ENT_QUOTES, "UTF-8");
        $splitdata    = base64_decode($split);
        $splitvalues  = explode("-", $splitdata);
        $id           = $splitvalues[1];
        
        if($buyAmount <= 0){
            $trade        = FALSE;
            $tradeMessage = "Du möchtest also wirklich weniger als nichts versenden ? Was erwartest du ?";
        }
        
        if($trade == TRUE){
            
            $sql       = "SELECT * FROM %%PLAYERTRADER%% WHERE id = :id";
            $query     = Database::get()->select($sql, ["id" => $id]);
            $tradeData = $query[0];
            
            
            $sellerResource      = ucfirst($tradeData["resType"][0]);
            $sellerWantsResource = ucfirst($tradeData["changeRes"][0]);
            $select              = "SELECT `".$sellerResource.$sellerWantsResource."` course, DATE(setDate) FROM %%PLAYERTRADER_COURSE%% WHERE DATE(setDate) = CURDATE() ORDER by setDate DESC LIMIT 1; ";
            $course              = Database::get()->select($select, []);
            
            if(!isset($course) || empty($course)){
                $select = "SELECT `".$sellerResource.$sellerWantsResource."` course, DATE(setDate) FROM %%PLAYERTRADER_COURSE%% WHERE setDate < DATE_ADD(NOW(), INTERVAL -1 HOUR) ORDER by setDate DESC LIMIT 1; ";
                $course = Database::get()->select($select, []);
            }
            
            $aktCourse     = $course[0];
            $sendResources = $buyAmount * $aktCourse["course"];
            $galaxy        = $PLANET["galaxy"];
            $system        = $PLANET["system"];
            $planet        = $PLANET["planet"];
            $planetOwner   = $PLANET["id_owner"];
            
            echo "Verkäufer Tauscht: " . $tradeData["resType"]." ".$tradeData["resCount"]." gegen ".$tradeData["changeAmount"]." ".$tradeData["changeRes"]."<br />";
            echo "Verkäufer bekommt: " . $sendResources . " " . $tradeData["changeRes"]."<br />";
            echo "Händler werden " . $sendResources . " " . $tradeData["changeRes"]." abgezogen.<br />"; //Prüfen ob genug vorhanden !!!
            echo "Käufer bekommt ".$buyAmount." ".$tradeData["resType"];
            
            //ziehe Res vom Käufer ab
            // ToDo: fehlt evtl. die User ID des Verkäufers
            #$param        = [':planetId' => $PLANET['id']];
            #$vals = [$tradeData["changeRes"].' = '.$sendResources, 'last_update = '.time()];
            #$rem  = "UPDATE %%PLANETS%% SET ".implode(',', $vals)." WHERE id = :planetId;";
            #Database::get()->update($rem, $param);
            #$PLANET[$resname] = $newOnPlanetResource;
            #$this->ecoObj->setData($USER, $PLANET);
            #$this->ecoObj->ReBuildCache();
            //[$USER, $PLANET] = $this->ecoObj->getData();
            #$PLANET['eco_hash'] = $this->ecoObj->CreateHash();
            
            //belade und versende Flotte des Käufers
            
            //ziehe Resourcen vom Händler ab
            
        }
        
        if($trade == FALSE){
            
            $this->printMessage($tradeMessage, [['label' => "weiter", 'url' => 'game.php?page=playertrader']]);
        }
    }
}