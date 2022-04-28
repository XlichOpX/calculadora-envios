<?php
header("Access-Control-Allow-Origin: http://calc-envios.localhost");
header("Access-Control-Allow-Credentials: true");

// parsar la query string y almacenar sus elementos
// en $params
parse_str($_SERVER["QUERY_STRING"], $params);

if ($params["url"] === "usuarios") {
    require_once "./controlador/ControladorUsuarios.php";
}

if ($params["url"] === "recuperacion") {
    require_once "./controlador/ControladorRecuperacion.php";
}

if ($params["url"] === "envios") {
    require_once "./controlador/ControladorEnvios.php";
}

if ($params["url"] === "transportes") {
    require_once "./controlador/ControladorTransportes.php";
}

if ($params["url"] === "ubicaciones") {
    require_once "./controlador/ControladorUbicaciones.php";
}
