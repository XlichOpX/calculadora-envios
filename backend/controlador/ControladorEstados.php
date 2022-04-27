<?php

require "./modelo/ModeloEstados.php";

$modelo_estados = new ModeloEstados();

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    $resultado = $modelo_estados->obtEstados();

    if (count($resultado) > 0) {
        http_response_code(200);

        $json = json_encode($resultado);

        echo $json;
    } else {
        http_response_code(404);
        echo json_encode(["status" => 404]);
    }
}
