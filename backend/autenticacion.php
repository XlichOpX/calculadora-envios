<?php

require_once "./modelo/autenticacion.php";
$autenticacion = new Autenticacion;

// si la request es post, se procesa
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // obtener el body de la request y pasarlo a un array map
    $body = json_decode(file_get_contents("php://input"), true);
    // verificar los datos del body
    $respuesta = $autenticacion->iniciarSesion($body);
    echo json_encode($respuesta);
    exit;
}

echo "metodo no permitido";
