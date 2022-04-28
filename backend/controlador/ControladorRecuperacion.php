<?php
require_once "./modelo/Modelorecuperacion.php";
$modelo_recuperacion = new ModeloRecuperacion();

// si la request es POST
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // obtener el body de la request y pasarlo a array map
    $datos = json_decode(file_get_contents("php://input"), true);

    // si en los datos esta definida la llave verificacion
    if (isset($datos["verificacion"])) {
        // valida las respuestas
        $resultado = $modelo_recuperacion->validarRespuestas($datos);
        echo json_encode($resultado);
        exit();
    }

    // si no, devuelve las preguntas de seguridad del usuario
    $resultado = $modelo_recuperacion->obtPreguntas($datos);
    echo json_encode($resultado);
}
