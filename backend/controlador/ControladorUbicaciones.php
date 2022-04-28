<?php

require "./modelo/ModeloUbicaciones.php";

$modelo_ubicaciones = new ModeloUbicaciones();

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    $respuesta = $modelo_ubicaciones->obtUbicaciones();

    echo json_encode($respuesta);
}
