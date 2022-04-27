<?php

require "./modelo/ModeloEnvios.php";

$modelo_envios = new ModeloEnvios();

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $datos = file_get_contents("php://input");
    $resultado = $modelo_envios->crearEnvio($datos);
    echo json_encode($resultado);
}
