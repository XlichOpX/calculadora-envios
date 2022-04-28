<?php
// obtiene la clave secreta del archivo config
$clave_secreta = json_decode(file_get_contents("config"), true)["secret"];
