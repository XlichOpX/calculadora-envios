<?php
header("Access-Control-Allow-Origin: http://calc-envios.localhost");
header("Access-Control-Allow-Credentials: true");

// parsar la query string y almacenar sus elementos
// en $params
parse_str($_SERVER["QUERY_STRING"], $params);

if ($params["url"] === "usuarios") {
    require_once "./controlador/usuarios.php";
}

if ($params["url"] === "recuperacion") {
    require_once "./controlador/recuperacion.php";
}

if ($params["url"] === "estados") {
    require_once "./controlador/estados.php";
}
