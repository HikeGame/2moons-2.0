<?php

echo $_SERVER["HTTP_HOST"];

$servername = "localhost";
$username = "t4ct1c3r";
$password = "Hqv50c9_";
$database = "sp4cet";
$dsn = "mysql:host=localhost;dbname=".$database.";charset=UTF8";

$x = $_GET["x"];
$y = $_GET["y"];
$z = $_GET["z"];
$div = "";


    #$dbh = new PDO('mysql:host='.$servername.';dbname='.$database, $username, $password);
    try {
        $pdo = new PDO($dsn, $username, $password);
    } catch (PDOException $e) {
        @mail('Silvio.Habel@gmail.com',"Database error", "Cant connect to database in". __FILE__."\n".$e->getMessage()) ;
    }
    
    
    $div1 = "<div class='systemdata container'>";
    $div1 .= "<div class='row systemdata-headline'>";
    $div1 .= "<div class='col-lg-4'>Planet [".$x.":".$y."]</div>";
    $div1 .= "<div class='col-lg-4'>Player</div>";
    $div1 .= "</div>";
    
    foreach($pdo->query('SELECT p.name planet,u.username `user` from uni'.$z.'_planets p, uni'.$z.'_users u WHERE p.galaxy = '.$x.' AND p.system = '.$y.' AND  p.id_owner = u.id') as $row){

        
        
        
        if(!empty($row)){
            $div .= "<div class='row'>";
            $div .= "<div class='col-lg-4'>".$row["planet"]."</div>";
            $div .= "<div class='col-lg-4'>".$row["user"]."</div>";
            $div .= "</div>";
        }else{
            $div = "";
        }

    }
    $dbh = null;


    echo ($div == "") ? "" : $div1.$div."</div>";