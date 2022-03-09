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

        // delete zero trades
        
        $i=0;
        foreach($tradesCollection as $trade){
            
            $tradesCollection[$i]["buyRes"] = $LNG['rs_'.$trade["resType"]];
            $tradesCollection[$i]["sellRes"] = $LNG['rs_'.$trade["changeRes"]];
            
            if($trade["resCount"] <= MIN_RESOURCES_TO_TRADE){
                $del = "DELETE FROM %%PLAYERTRADER%% WHERE id = :id LIMIT 1";
                Database::get()->delete($del, ['id' => $trade["id"]]);
            }
            $i++;
        }
        
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
            $this::setToTrader($USER["id"], $resname, $rescount, $changeAmount, $changeName, $PLANET['id'], $USER["galaxy"], $USER["system"], $USER["planet"]);
           
            $this->printMessage(sprintf($LNG["trade_SendToTraderSuccess"],number_format($rescount, 0, ',', '\''), ucfirst($LNG['rs_'.$resname])), [['label' => "weiter", 'url' => 'game.php?page=playertrader']]);
        }
        else{
            $this->printMessage($LNG["trade_NotEnoughResources"], [['label' => "weiter", 'url' => 'game.php?page=playertrader']]);
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
     * @param $planetId
     * @param $gala
     * @param $system
     * @param $planet
     * @throws Exception
     */
    private function setToTrader($uid, $resName, $resCount, $changeAmount, $changeName, $planetId, $gala, $system, $planet)
    {
        
        $trader = 'INSERT INTO %%PLAYERTRADER%% (playerId,startDate,resType,resCount, changeAmount, changeRes, planetId, fromGalaxy,fromSystem,fromPlanet) VALUES (:userId,:datum,:resType,:rescount,:changeAmount, :changeRes, :planetId, :galaxy,:sys,:planet);';
        
        Database::get()->insert($trader, [
            ':userId'       => $uid,
            ':datum'        => date('Y-m-d H:i:s'),
            ':resType'      => "$resName",
            ':rescount'     => "$resCount",
            ':changeAmount' => $changeAmount,
            ':changeRes'    => "$changeName",
            ':planetId'     => "$planetId",
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
        $plid         = $PLANET["id"];
        
        $tmpTradeId    = self::extractTradeId(base64_decode(htmlspecialchars($_POST["honeypot"], ENT_QUOTES, "UTF-8")));
        $sql           = "SELECT * FROM %%PLAYERTRADER%% WHERE id = :id";
        $query         = Database::get()->select($sql, ["id" => $tmpTradeId]);
        $tradeData     = $query[0];
        $tradeId       = $tradeData["id"];
        $sellerId      = $tradeData["playerId"];
        $buyerId       = $USER["id"];
        $sellType      = $tradeData["resType"];
        $sellMaxAmount = $tradeData["resCount"];
        $buyType       = $tradeData["changeRes"];
        $buyMaxAmount  = $tradeData["changeAmount"];
        $buy           = htmlspecialchars($_POST["buyAmount"], ENT_QUOTES, "UTF-8");
        
        # check ob mehr als X Resourcen gekauft werden
        if($buy <= 0 || empty($buy) || $buy == ""){
            $tradeMessage = $LNG['trade_BuyLesserThanZero'];
            $trade        = FALSE;
        }
        
        if($buy < MIN_RESOURCES_TO_TRADE){
            $buy = ($buy <= 0) ? 0 : $buy;
            $tradeMessage = sprintf($LNG['trade_BuyEmptyOrZero'],$buy,ucfirst($tradeData["resType"]),MIN_RESOURCES_TO_TRADE, ucfirst($tradeData["resType"]));
            $trade = FALSE;
        }
        
        # Trade ist nicht mehr vorhanden
        if(!is_array($tradeData) || empty($tradeData)){
            $tradeMessage = $LNG['trade_TradersGone'];
            $trade        = FALSE;
        }
        
        # Weniger Res vorhanden als gekauft wird
        if(self::getResources($tradeData["resType"]) < $buy){
            $tradeMessage = $LNG['trade_PleaseWait'];
            $trade        = FALSE;
        }
        
        # zu wenig Res zum handeln auf dem Planeten vorhanden
        if($tradeData["resCount"] == "" && ($tradeData["resCount"] - $buy) <= 0){
            $tradeMessage = $LNG['trade_BuyTooMuch'];
            $trade        = FALSE;
        }
       
        # Kein passender Planet zum Spieler gefunden
        if(!key_exists($plid, $USER["PLANETS"])){
            $tradeMessage = $LNG['trade_PlanetManipulation'];
            $trade        = FALSE;
        }
        
        if($trade == TRUE){
            
            $sellerResource      = ucfirst($tradeData["resType"][0]);
            $sellerWantsResource = ucfirst($tradeData["changeRes"][0]);
            $select              = "SELECT `".$sellerResource.$sellerWantsResource."` course, DATE(setDate) datum FROM %%PLAYERTRADER_COURSE%% ORDER by setDate DESC LIMIT 1; ";
            $course              = Database::get()->select($select, []);
            $aktCourse           = $course[0]["course"];
            $sendResources       = ceil($buy * $aktCourse);
            
            $updateTrader = "UPDATE %%PLAYERTRADER%% SET resCount = ".($tradeData["resCount"] - $buy).", changeAmount = ".($tradeData["changeAmount"] - $sendResources)." WHERE id = :tradeId LIMIT 1";
            Database::get()->update($updateTrader, ['tradeId' => $tradeData["id"]]);
            #########################################################
            
            # #######################################################
            # ######## Verkäufer Res gutschreiben ###################
            $selectSellerRes  = "SELECT metal, crystal, deuterium FROM %%PLANETS%% WHERE id_owner = :playerId AND id = :planet LIMIT 1;";
            $planeteResources = Database::get()->select($selectSellerRes, [
                ':playerId' => $tradeData["playerId"],
                ':planet'   => $tradeData["planetId"],
            ]);
            
            $newOnPlanetResource = ceil($planeteResources[0][$tradeData["changeRes"]] + $sendResources);
            $vals                = [$tradeData["changeRes"].' = '.$newOnPlanetResource, 'last_update = '.time()];
            $rem1                = "UPDATE %%PLANETS%% SET ".implode(',', $vals)." WHERE id = :planetId;";
            Database::get()->update($rem1, ['planetId' => $tradeData["planetId"]]);
            $PLANET[$tradeData["changeRes"]] = $newOnPlanetResource;
            $this->ecoObj->setData($USER, $PLANET);
            $this->ecoObj->ReBuildCache();
            [$USER, $PLANET] = $this->ecoObj->getData();
            $PLANET['eco_hash'] = $this->ecoObj->CreateHash();
            
            # #####################################################################
            # ############### Käufer gekaufte Ress gutschreiben ###################
            $selectBuyerRes        = "SELECT metal, crystal, deuterium FROM %%PLANETS%% WHERE id_owner = :playerId AND id = :planet LIMIT 1;";
            $planeteBuyerResources = Database::get()->select($selectBuyerRes, [
                ':playerId' => $USER["id"],
                ':planet'   => $plid,
            ]);
            
            $newOnBuyerResource1 = ceil($planeteBuyerResources[0][$tradeData["changeRes"]] - $sendResources);
            $newOnBuyerResource2 = ceil($planeteBuyerResources[0][$tradeData["resType"]] + $buy);
            
            $vals = [$tradeData["changeRes"].' = '.$newOnBuyerResource1, $tradeData["resType"].' = '.$newOnBuyerResource2, 'last_update = '.time()];
            $rem2 = "UPDATE %%PLANETS%% SET ".implode(',', $vals)." WHERE id = :planetId;";
            Database::get()->update($rem2, ['planetId' => $plid]);
            $PLANET[$tradeData["changeRes"]] = $newOnBuyerResource1;
            $PLANET[$tradeData["resType"]]   = $newOnBuyerResource2;
            $this->ecoObj->setData($USER, $PLANET);
            $this->ecoObj->ReBuildCache();
            [$USER, $PLANET] = $this->ecoObj->getData();
            $PLANET['eco_hash'] = $this->ecoObj->CreateHash();
            
            $tradeMessage = sprintf($LNG['trade_Success'],number_format($buy, 0, ',', '.'),ucfirst($sellType), number_format($sendResources, 0, ',', '.'), ucfirst($buyType));
            #$tradeMessage = "Du konntest erfolgreich ".number_format($buy, 0, ',', '.')." ".ucfirst($sellType)." gegen ".number_format($sendResources, 0, ',', '.')." ".ucfirst($buyType)." eintauschen";
            
            
            // belade und versende Flotte des Käufers
            // Gebühr für Händler
            // Send ingame msg to buyer and seller
            $this->printMessage($tradeMessage, [['label' => "weiter", 'url' => 'game.php?page=playertrader']]);
        }
        else{
            $this->printMessage($tradeMessage, [['label' => "weiter", 'url' => 'game.php?page=playertrader']]);
        }
    }
    
    private function extractTradeId($tid): int
    {
        
        $t = explode('-', $tid);
        return $t[1];
    }
    
}