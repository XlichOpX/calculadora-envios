<?php

require_once "./modelo/ModeloEnvios.php";
require_once "./utilidades/Secret.php";
require_once "./utilidades/JWTUtils.php";

$modelo_envios = new ModeloEnvios();

// verifica que la request sea POST, tenga el jwt y que este sea valido
// para poder crear el envio
if (
    $_SERVER["REQUEST_METHOD"] === "POST" &&
    isset($_COOKIE["jwt_token"]) &&
    validarJWT($_COOKIE["jwt_token"], $clave_secreta)
) {
    // obtener el body de la request y pasarlo a array map
    $datos = json_decode(file_get_contents("php://input"), true);

    // pasar los datos al modelo para que intente crear el envio
    $resultado = $modelo_envios->crearEnvio($datos);

    // si hubo exito, envia el resultado (ultimo id insertado)
    if ($resultado) {
        http_response_code(200);
        echo json_encode($resultado);
        exit();
    }

    // si no hubo exito, envia un error 400
    http_response_code(400);
    echo json_encode([
        "status" => 400,
        "error" => "Bad request",
    ]);
    exit();
} else {
    // si no, envia un status 403
    http_response_code(403);
    echo json_encode([
        "status" => 403,
        "error" => "Forbbiden",
    ]);
}
