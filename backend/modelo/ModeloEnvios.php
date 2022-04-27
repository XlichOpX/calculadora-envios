<?php

require "./modelo/conexion.php";

class ModeloEnvios extends Conexion
{
    // funcion para crear envios
    public function crearEnvio($datos)
    {
        // convertir los datos a array map
        $datos = json_decode($datos, true);

        // campos requeridos para crear un envio
        $requeridos = [
            "usuario" => PDO::PARAM_INT,
            "direccion" => PDO::PARAM_INT,
            "estatus" => PDO::PARAM_INT,
            "transporte" => PDO::PARAM_INT,
            "peso" => PDO::PARAM_STR,
            "ancho" => PDO::PARAM_STR,
            "alto" => PDO::PARAM_STR,
            "largo" => PDO::PARAM_STR,
            "precio" => PDO::PARAM_STR,
            "nota_adicional" => PDO::PARAM_STR,
        ];

        // verificar que todos los datos esten presentes
        foreach ($requeridos as $campo => $tipo) {
            if (!isset($datos[$campo])) {
                http_response_code(400);
                return ["status" => 400, "error" => "Datos incompletos"];
            }
        }

        // crear array de params
        foreach ($datos as $campo => $valor) {
            $params[] = [
                "nombre" => $campo,
                "valor" => $valor,
                "tipo" => $requeridos[$campo],
            ];
        }

        // query para crear envio
        $query = <<<SQL
        INSERT INTO envios (
                id_usuario,
                id_direccion,
                id_estatus,
                id_transporte,
                peso,
                ancho,
                alto,
                largo,
                precio,
                nota_adicional
            )

            VALUES (
                :usuario,
                :direccion,
                :estatus,
                :transporte,
                :peso,
                :ancho,
                :alto,
                :largo,
                :precio,
                :nota_adicional
            )
        SQL;

        // ejecutar query con los params
        $resultado = $this->insert($query, $params);

        // retornar el resultado
        return $resultado;
    }
}
