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
            "estatus" => PDO::PARAM_INT,
            "transporte" => PDO::PARAM_INT,
            "destino" => PDO::PARAM_INT,
            "origen" => PDO::PARAM_INT,
            "peso" => PDO::PARAM_STR,
            "ancho" => PDO::PARAM_STR,
            "alto" => PDO::PARAM_STR,
            "largo" => PDO::PARAM_STR,
            "nota_adicional" => PDO::PARAM_STR,
        ];

        // verificar que todos los datos esten presentes
        foreach ($requeridos as $campo => $tipo) {
            if (!isset($datos[$campo])) {
                http_response_code(400);
                return ["status" => 400, "error" => "Datos incompletos"];
            }
        }

        // agg el precio
        $requeridos["precio"] = PDO::PARAM_STR;

        // obt el punto de origen
        $origen = $this->query("SELECT x, y FROM ubicaciones WHERE id = :id", [
            [
                "nombre" => "id",
                "valor" => $datos["origen"],
                "tipo" => PDO::PARAM_INT,
            ],
        ])[0];

        // obt el punto de destino
        $destino = $this->query("SELECT x, y FROM ubicaciones WHERE id = :id", [
            [
                "nombre" => "id",
                "valor" => $datos["destino"],
                "tipo" => PDO::PARAM_INT,
            ],
        ])[0];

        // obt el transporte
        $transporte = $this->query(
            "SELECT tarifa FROM transportes WHERE id = :id",
            [
                [
                    "nombre" => "id",
                    "valor" => $datos["transporte"],
                    "tipo" => PDO::PARAM_INT,
                ],
            ],
        )[0];

        // calcular la distancia entre ambos puntos
        $distancia = sqrt(
            ($destino["x"] - $origen["x"]) ** 2 +
                ($destino["y"] - $origen["y"]) ** 2,
        );

        // precio base de 0.01$ por km
        $precio_base = $distancia * 0.01;
        // agg la tarifa del transporte
        $precio = $precio_base + $precio_base * $transporte["tarifa"];
        // agg una parte del peso al precio
        $precio += $datos["peso"] * 0.000015;
        // agg una parte del volumen al precio
        $precio +=
            $datos["alto"] * $datos["ancho"] * $datos["largo"] * 0.000015;

        // agg el precio calculado a los datos
        $datos["precio"] = $precio;

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
                id_estatus,
                id_transporte,
                id_origen,
                id_destino,
                peso,
                ancho,
                alto,
                largo,
                precio,
                nota_adicional
            )

            VALUES (
                :usuario,
                :estatus,
                :transporte,
                :origen,
                :destino,
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
