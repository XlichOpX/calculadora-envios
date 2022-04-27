<?php
require "./modelo/Modelorecuperacion.php";
$modelo_recuperacion = new ModeloRecuperacion();

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $datos = json_decode(file_get_contents("php://input"), true);

    if (isset($datos["verificacion"])) {
        $resultado = $modelo_recuperacion->validarRespuestas($datos);
        echo json_encode($resultado);
        exit();
    }

    $resultado = $modelo_recuperacion->obtPreguntas($datos);
    echo json_encode($resultado);
}
