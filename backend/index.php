<?php

// parsar la query string y almacenar sus elementos
// en $params
parse_str($_SERVER["QUERY_STRING"], $params);

if ($params['url'] === 'usuarios') {
    require_once "./controlador/usuarios.php";
}
