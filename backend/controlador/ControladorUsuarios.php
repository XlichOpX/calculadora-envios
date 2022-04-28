<?php
require_once "./modelo/ModeloUsuarios.php";
$modelo_usuarios = new ModeloUsuarios();

// si la peticion es post
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // obtener el body de la request y transformarlo a un array map
    $body = json_decode(file_get_contents("php://input"), true);

    // intenta crear el usuario y guarda el resultado de la operacion
    $resultado = $modelo_usuarios->crearUsuario($body);

    // envia el resultado
    echo json_encode($resultado);
}
