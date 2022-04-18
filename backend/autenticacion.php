<?php

require_once "./modelo/autenticacion.php";
$autenticacion = new Autenticacion;

// si la request es post, se procesa
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // obtener el body de la request
    $body = file_get_contents("php://input");
    // verificar los datos del body
    $respuesta = $autenticacion->iniciarSesion($body);
    echo json_encode($respuesta);
} else {
    echo "metodo no permitido";
}
