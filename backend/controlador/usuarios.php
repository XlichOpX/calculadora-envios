<?php
include "modelo/usuarios.php";
$usuarios = new Usuarios();

// si se ha indicado un id
if ($_SERVER["REQUEST_METHOD"] === "GET" && isset($params['id'])) {
    // si al hacer casting el id es distinto de 0, es valido
    if ((int) $params['id'] !== 0) {
        $datos = $usuarios->obtenerUsuario($params['id']);
        // verifica que no sea un array vacio
        if (count($datos) > 0) {
            echo json_encode($datos);
            exit;
        }
    }
    echo "id invalido";
    exit;
}

// por defecto devuelve los usuarios
if ($_SERVER["REQUEST_METHOD"] === "GET") {
    echo json_encode($usuarios->obtenerUsuarios());
}
