<?php

require_once "./modelo/Conexion.php";

class ModeloEnvios extends Conexion
{
    // funcion para crear envios
    public function crearEnvio($datos)
    {
        // campos requeridos para crear un envio
        $requeridos = [
            "usuario" => PDO::PARAM_INT,
            "transporte" => PDO::PARAM_INT,
            "destino" => PDO::PARAM_INT,
            "origen" => PDO::PARAM_INT,
            "peso" => PDO::PARAM_STR,
            "ancho" => PDO::PARAM_STR,
            "alto" => PDO::PARAM_STR,
            "largo" => PDO::PARAM_STR,
            "nota_adicional" => PDO::PARAM_STR,
            "fecha_recepcion" => PDO::PARAM_STR,
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
                id_transporte,
                id_origen,
                id_destino,
                peso,
                ancho,
                alto,
                largo,
                precio,
                fecha_recepcion,
                nota_adicional
            )

            VALUES (
                :usuario,
                :transporte,
                :origen,
                :destino,
                :peso,
                :ancho,
                :alto,
                :largo,
                :precio,
                :fecha_recepcion,
                :nota_adicional
            )
        SQL;

        // comenzar una transaccion
        $this->conexion->beginTransaction();

        // ejecutar query con los params
        $id_envio = $this->insert($query, $params);

        // query para insertar el primer seguimiento del envio
        $query = <<<SQL
            INSERT INTO seguimientos (id_envio, id_estatus)
            VALUES (:id_envio, 1)
        SQL;

        // params para la query del seguimiento
        $params = [
            [
                "nombre" => "id_envio",
                "valor" => $id_envio,
                "tipo" => PDO::PARAM_INT,
            ],
        ];

        // insertar seguimiento
        $id_seguimiento = $this->insert($query, $params);

        // confirmar la transaccion
        $resultado = $this->conexion->commit();

        // si fue exitosa, devuelve el num de tracking
        if ($resultado) {
            return ["num_tracking" => $id_seguimiento];
        }

        // si no, devuelve false
        return false;
    }

    public function obtEnvios($usuario)
    {
        $query = <<<SQL
            select
                envios.id as num_tracking,
                estatus.estatus,
                ubi1.nombre as origen,
                ubi2.nombre as destino
            from
                envios,
                estatus,
                ubicaciones as ubi1,
                ubicaciones as ubi2
            where
                envios.id_origen = ubi1.id
                && envios.id_destino = ubi2.id
                && estatus.id = envios.id_estatus
                && envios.id_usuario = :usuario
            order by
                envios.fecha_creacion desc
        SQL;
        $resultado = $this->query($query, [
            [
                "nombre" => "usuario",
                "valor" => $usuario,
                "tipo" => PDO::PARAM_INT,
            ],
        ]);
        return $resultado;
    }
}
