<?php
require "./modelo/ModeloUsuarios.php";
$modelo_usuarios = new ModeloUsuarios();

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    // si se ha indicado un id y es un int valido
    if (isset($params["id"]) && (int) $params["id"] !== 0) {
        $datos = $modelo_usuarios->obtenerUsuario($params["id"]);

        // verifica que no sea un array vacio
        if (count($datos) > 0) {
            echo json_encode($datos);
            exit();
        }

        http_response_code(404);
        echo json_encode(["error" => "El usuario solicitado no existe."]);
        exit();
    }

    // si no se especifica un id, devuelve los usuarios
    http_response_code(200);
    echo json_encode($modelo_usuarios->obtenerUsuarios());
    exit();
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // obtener el body de la request y transformarlo a un array map
    $body = json_decode(file_get_contents("php://input"), true);

    echo json_encode($modelo_usuarios->crearUsuario($body));
}
