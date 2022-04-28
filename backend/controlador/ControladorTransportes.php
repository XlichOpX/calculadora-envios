<?php

require_once "./modelo/ModeloTransportes.php";

$modelo_transportes = new ModeloTransportes();

// si la request es get
if ($_SERVER["REQUEST_METHOD"] === "GET") {
    // obtener los transportes
    $respuesta = $modelo_transportes->obtTransportes();

    // enviar los transportes
    echo json_encode($respuesta);
}
