<?php

require_once "./modelo/ModeloEnvios.php";
require_once "./utilidades/Secret.php";
require_once "./utilidades/JWTUtils.php";

$modelo_envios = new ModeloEnvios();

if (
    $_SERVER["REQUEST_METHOD"] === "POST" &&
    validarJWT($_COOKIE["jwt_token"], $clave_secreta)
) {
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
} else {
    http_response_code(403);
    echo json_encode([
        "status" => 403,
        "error" => "Forbbiden",
    ]);
}
