<?php

$servername = "localhost";
$username = "t4ct1c3r";
$password = "Hqv50c9_";

$x = $_GET["x"];
$y = $_GET["y"];
$div = "";

try{
    $dbh = new PDO('mysql:host='.$servername.';dbname=sp4cet', $username, $password);
    $div1 = "<div class='systemdata container'>";
    $div1 .= "<div class='row systemdata-headline'>";
    $div1 .= "<div class='col-lg-4'>Planet</div>";
    $div1 .= "<div class='col-lg-4'>Player</div>";
    $div1 .= "</div>";
    foreach($dbh->query('SELECT p.name planet,u.username `user` from uni1_planets p, uni1_users u WHERE p.galaxy = '.$x.' AND p.system = '.$y.' AND  p.id_owner = u.id') as $row){

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


} catch(PDOException $e){
    print "Error!: ".$e->getMessage()."<br/>";
    die();
}