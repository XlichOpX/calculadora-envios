<?php

require_once "./modelo/ModeloTransportes.php";

$modelo_transportes = new ModeloTransportes();

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    $respuesta = $modelo_transportes->obtTransportes();

    echo json_encode($respuesta);
}
