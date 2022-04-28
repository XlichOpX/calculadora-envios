<?php

require_once "./modelo/ModeloUbicaciones.php";

$modelo_ubicaciones = new ModeloUbicaciones();

// si la request es get
if ($_SERVER["REQUEST_METHOD"] === "GET") {
    // obtener las ubicaciones
    $respuesta = $modelo_ubicaciones->obtUbicaciones();

    // enviar las ubicaciones
    echo json_encode($respuesta);
}
