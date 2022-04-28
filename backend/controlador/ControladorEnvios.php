<?php

require "./modelo/ModeloEnvios.php";

$modelo_envios = new ModeloEnvios();

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $datos = file_get_contents("php://input");

    $resultado = $modelo_envios->crearEnvio($datos);

    if ($resultado) {
        echo json_encode($resultado);
        exit();
    }

    http_response_code(400);
    echo json_encode([
        "status" => 400,
        "error" => "Bad request",
    ]);
    exit();
}
