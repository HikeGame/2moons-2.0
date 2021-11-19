<?php

require('includes/classes/PlayerUtil.class.php');

#$player = new PlayerUtil();

$callback_url = urlencode(base64_encode('https://Space-Tactics.com/voteST.php?user=ShaoKhan&uid=1'));

#echo 'https://www.arena-top100.com/index.php?a=in&u=ShaoKhan&callback='.$callback_url.'<br />';
echo "<a href='https://www.arena-top100.com/index.php?a=in&u=ShaoKhan&callback=".$callback_url."'>".$callback_url."</a>";

#$player->UserVoting();