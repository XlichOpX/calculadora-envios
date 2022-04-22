<?php
require_once "./modelo/recuperacion.php";
$recuperacion = new Recuperacion();

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $datos = json_decode(file_get_contents("php://input"), true);

  if (isset($datos["verificacion"])) {
    $resultado = $recuperacion->validarRespuestas($datos);
    echo json_encode($resultado);
    exit();
  }

  $resultado = $recuperacion->obtPreguntas($datos);
  echo json_encode($resultado);
}
