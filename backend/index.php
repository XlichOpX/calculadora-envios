<?php
header("Access-Control-Allow-Origin: http://calc-envios.localhost");
header("Access-Control-Allow-Credentials: true");

// parsar la query string y almacenar sus elementos
// en $params
parse_str($_SERVER["QUERY_STRING"], $params);

if ($params["url"] === "usuarios") {
    require "./controlador/ControladorUsuarios.php";
}

if ($params["url"] === "recuperacion") {
    require "./controlador/ControladorRecuperacion.php";
}

if ($params["url"] === "envios") {
    require "./controlador/ControladorEnvios.php";
}

if ($params["url"] === "transportes") {
    require "./controlador/ControladorTransportes.php";
}
