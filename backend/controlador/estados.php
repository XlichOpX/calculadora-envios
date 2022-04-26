<?php

require "./modelo/estados.php";

$estados = new Estados();

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    $resultado = $estados->obtEstados();

    if (count($resultado) > 0) {
        http_response_code(200);

        $json = json_encode($resultado);

        echo $json;
    } else {
        http_response_code(404);
        echo json_encode(["status" => 404]);
    }
}
