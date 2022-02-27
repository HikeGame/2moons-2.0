<?php

$servername = "localhost";
$username = "t4ct1c3r";
$password = "Hqv50c9_";


try{
    $dbh = new PDO('mysql:host='.$servername.';dbname=sp4cet', $username, $password);
    
    $minmax = rand(-25, 25);
    
    // Kristall
    $getCourseCrystalDeuterium = "SELECT SUM(resCount) resCount, SUM(changeAmount) changeAmount FROM %%PLAYERTRADER%% WHERE resType = 'crystal' AND changeRes = 'deuterium' LIMIT 0,30";
    $getCourseCrystalMetal     = "SELECT SUM(resCount) resCount, SUM(changeAmount) changeAmount FROM %%PLAYERTRADER%% WHERE resType = 'crystal' AND changeRes = 'metal' LIMIT 0,30";
    
    //Metall
    $getCourseMetalCrystal   = "SELECT SUM(resCount) resCount, SUM(changeAmount) changeAmount FROM %%PLAYERTRADER%% WHERE resType = 'metal' AND changeRes = 'crystal' LIMIT 0,30";
    $getCourseMetalDeuterium = "SELECT SUM(resCount) resCount, SUM(changeAmount) changeAmount FROM %%PLAYERTRADER%% WHERE resType = 'metal' AND changeRes = 'deuterium' LIMIT 0,30";
    
    //Deuterium
    $getCourseDeuteriumCrystal = "SELECT SUM(resCount) resCount, SUM(changeAmount) changeAmount FROM %%PLAYERTRADER%% WHERE resType = 'deuterium' AND changeRes = 'crystal' LIMIT 0,30";
    $getCourseDeuteriumMetal   = "SELECT SUM(resCount) resCount, SUM(changeAmount) changeAmount FROM %%PLAYERTRADER%% WHERE resType = 'deuterium' AND changeRes = 'metal' LIMIT 0,30";
    
    
    $courseDataCrystalDeuterium = $dbh->query($getCourseCrystalDeuterium);
    $courseDataCrystalMetal     = $dbh->query($getCourseCrystalMetal);
    $courseDataMetalDeuterium   = $dbh->query($getCourseMetalDeuterium);
    $courseDataMetalCrystal     = $dbh->query($getCourseMetalCrystal);
    $courseDataDeuteriumCrystal = $dbh->query($getCourseDeuteriumCrystal);
    $courseDataDeuteriumMetal   = $dbh->query($getCourseDeuteriumMetal);
    
    $courseDataCrystalDeuteriumAmount   = $courseDataCrystalDeuterium[0]['changeAmount'] ?? 2;
    $courseDataCrystalMetalAmount       = $courseDataCrystalMetal[0]['changeAmount'] ?? 2;
    $courseDataMetalDeuteriumAmount     = $courseDataMetalDeuterium[0]['changeAmount'] ?? 0;
    $courseDataMetalCrystalAmount       = $courseDataMetalCrystal[0]['changeAmount'] ?? 0;
    $courseDataDeuteriumCrystalAmount   = $courseDataDeuteriumCrystal[0]['changeAmount'] ?? 2;
    $courseDataDeuteriumMetalAmount     = $courseDataDeuteriumMetal[0]['changeAmount'] ?? 3;
    $courseDataCrystalDeuteriumResCount = $courseDataCrystalDeuterium[0]['resCount'] ?? 1;
    $courseDataCrystalMetalResCount     = $courseDataCrystalMetal[0]['resCount'] ?? 1;
    $courseDataMetalDeuteriumResCount   = $courseDataMetalDeuterium[0]['resCount'] ?? 1;
    $courseDataMetalCrystalResCount     = $courseDataMetalCrystal[0]['resCount'] ?? 1;
    $courseDataDeuteriumCrystalResCount = $courseDataDeuteriumCrystal[0]['resCount'] ?? 1;
    $courseDataDeuteriumMetalResCount   = $courseDataDeuteriumMetal[0]['resCount'] ?? 1;
    
    $course['CD'] = ($courseDataCrystalDeuteriumAmount / $courseDataCrystalDeuteriumResCount) + ($minmax / 100);
    $course['CM'] = ($courseDataCrystalMetalAmount / $courseDataCrystalMetalResCount) + ($minmax / 100);
    $course['MD'] = ($courseDataMetalDeuteriumAmount / $courseDataMetalDeuteriumResCount) + ($minmax / 100);
    $course['MC'] = ($courseDataMetalCrystalAmount / $courseDataMetalCrystalResCount) + ($minmax / 100);
    $course['DC'] = ($courseDataDeuteriumCrystalAmount / $courseDataDeuteriumCrystalResCount) + ($minmax / 100);
    $course['DM'] = ($courseDataDeuteriumMetalAmount / $courseDataDeuteriumMetalResCount) + ($minmax / 100);
    
    
    $trades           = "SELECT pt.*, u.username FROM uni1_playertrader pt, uni1_users u WHERE pt.playerId = u.id  ORDER BY pt.startDate DESC";
    $tradesCollection = $dbh->query($trades);
    
    
    foreach($tradesCollection as $key => $value){
        
        $resSet = $value["resType"];
        $resGet = $value["changeRes"];
        
        $playerCourse = $value["changeAmount"] / $value["resCount"];
        
        if($resSet == "crystal" && $resGet == "deuterium"){
            $course["CD"] = ($playerCourse + $course["CD"]) / 2;
        }
        elseif($resSet == "crystal" && $resGet == "metal"){
            $course["CM"] = ($playerCourse + $course["CM"]) / 2;
        }
        elseif($resSet == "metal" && $resGet == "deuterium"){
            $course["MD"] = ($playerCourse + $course["MD"]) / 2;
        }
        elseif($resSet == "metal" && $resGet == "crystal"){
            $course["MC"] = ($playerCourse + $course["MC"]) / 2;
        }
        elseif($resSet == "deuterium" && $resGet == "crystal"){
            $course["DC"] = ($playerCourse + $course["DC"]) / 2;
        }
        elseif($resSet == "deuterium " && $resGet == "metal"){
            $course["DM"] = ($playerCourse + $course["DM"]) / 2;
        }
    }
    
    $c =  ["course" => $course, "tradesCollection" => $tradesCollection];
    
    $stmt = $dbh->prepare("INSERT INTO uni1_playertrader_course (setDate, CD, CM, MD, MC, DC, DM) VALUES (:zeit,:CD,:CM,:MD,:MC,:DC,:DM)");
    $stmt->execute(['zeit' => date("Y-m-d H:i:s"),
                    'CD' => round($c["course"]["CD"],3),
                    'CM' => $c["course"]["CM"],
                    'MD' => $c["course"]["MD"],
                    'MC' => $c["course"]["MC"],
                    'DC' => $c["course"]["DC"],
                    'DM' => $c["course"]["DM"]]);
    
    $dbh = null;


} catch(PDOException $e){
    print "Error!: ".$e->getMessage()."<br/>";
    mail("Silvio.Habel@gmail.com", "Cronjob-Error: setCourse", "Der Cronjob setCourse konnte nicht ausgeführt werden.\n<br />".$e->getMessage());
    die();
}