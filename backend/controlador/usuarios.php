<?php
require_once "./modelo/usuarios.php";
$usuarios = new Usuarios();

if ($_SERVER["REQUEST_METHOD"] === "GET") {

    // si se ha indicado un id y es un int valido
    if (isset($params['id']) && (int) $params['id'] !== 0) {

        $datos = $usuarios->obtenerUsuario($params['id']);

        // verifica que no sea un array vacio
        if (count($datos) > 0) {
            echo json_encode($datos);
            exit;
        }

        echo "id invalido";
        exit;
    }

    // si no se especifica un id, devuelve los usuarios
    echo json_encode($usuarios->obtenerUsuarios());
    exit;
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // obtener el body de la request y transformarlo a un array map
    $body = json_decode(file_get_contents("php://input"), true);

    echo $usuarios->crearUsuario($body);
}
