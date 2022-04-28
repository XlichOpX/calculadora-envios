<?php

require_once "./modelo/Conexion.php";

class ModeloUsuarios extends Conexion
{
    function obtenerUsuario($id)
    {
        $query = "SELECT * FROM usuarios WHERE id = :id";
        return $this->query($query, [
            ["nombre" => "id", "valor" => $id, "tipo" => PDO::PARAM_INT],
        ]);
    }

    function obtenerUsuarios()
    {
        $query = "SELECT * FROM usuarios";
        return $this->query($query);
    }

    function crearUsuario($datos)
    {
        // datos requeridos del usuario
        $requeridos_usuario = [
            "correo_electronico" => PDO::PARAM_STR,
            "clave" => PDO::PARAM_STR,
            "nombre" => PDO::PARAM_STR,
            "apellido" => PDO::PARAM_STR,
            "cedula" => PDO::PARAM_STR,
            "fecha_nacimiento" => PDO::PARAM_STR,
            "telefono" => PDO::PARAM_STR,
        ];

        // datos requeridos para la direccion
        $requeridos_direccion = [
            "id_pais" => PDO::PARAM_INT,
            "id_estado" => PDO::PARAM_INT,
            "id_municipio" => PDO::PARAM_INT,
            "id_parroquia" => PDO::PARAM_INT,
            "calle" => PDO::PARAM_STR,
            "referencia" => PDO::PARAM_STR,
        ];

        // preguntas de seguridad requeridas
        $requeridos_preguntas = [
            "pregunta1" => PDO::PARAM_STR,
            "pregunta2" => PDO::PARAM_STR,
            "pregunta3" => PDO::PARAM_STR,
            "respuesta1" => PDO::PARAM_STR,
            "respuesta2" => PDO::PARAM_STR,
            "respuesta3" => PDO::PARAM_STR,
        ];

        // verifica que existan los datos requeridos del usuario
        foreach ($requeridos_usuario as $nombre => $tipo) {
            if (!isset($datos[$nombre])) {
                http_response_code(400);
                return ["error" => "Datos incompletos"];
            }
        }

        // verifica que existan los datos requeridos de direccion
        foreach ($requeridos_direccion as $nombre => $tipo) {
            if (!isset($datos[$nombre])) {
                http_response_code(400);
                return ["error" => "Datos incompletos"];
            }
        }

        // verifica que existan las preguntas requeridas
        foreach ($requeridos_preguntas as $nombre => $tipo) {
            if (!isset($datos[$nombre])) {
                http_response_code(400);
                return ["error" => "Datos incompletos"];
            }
        }

        // verifica que el email no exista ya en la db
        if (
            $this->query(
                "SELECT id FROM usuarios WHERE correo_electronico = :correo",
                [
                    [
                        "nombre" => "correo",
                        "valor" => $datos["correo_electronico"],
                        "tipo" => PDO::PARAM_STR,
                    ],
                ],
            )
        ) {
            http_response_code(400);
            return ["error" => "El correo indicado ya está registrado"];
        }

        // aplicar hash a la clave antes de llevarla a la db
        $datos["clave"] = password_hash($datos["clave"], PASSWORD_DEFAULT);

        // crear array de params para la query
        foreach ($requeridos_usuario as $nombre => $tipo) {
            $params[] = [
                "nombre" => $nombre,
                "valor" => $datos[$nombre],
                "tipo" => $tipo,
            ];
        }

        // query para insertar usuario
        $query = <<<SQL
        INSERT INTO usuarios(correo_electronico, clave ,nombre, apellido, cedula, fecha_nacimiento, telefono)
        VALUES (:correo_electronico, :clave, :nombre, :apellido, :cedula, :fecha_nacimiento, :telefono)
        SQL;

        // comenzar transaccion
        $this->conexion->beginTransaction();
        $id_usuario = $this->insert($query, $params);

        // vaciar params
        $params = [];
        // agg el usuario a los params
        $params[] = [
            "nombre" => "id_usuario",
            "valor" => $id_usuario,
            "tipo" => PDO::PARAM_INT,
        ];
        // crear array de params para el insert de direccion
        foreach ($requeridos_direccion as $nombre => $tipo) {
            $params[] = [
                "nombre" => $nombre,
                "valor" => $datos[$nombre],
                "tipo" => $tipo,
            ];
        }

        // query para insertar direccion
        $query = <<<SQL
        INSERT INTO direcciones(id_usuario, id_pais , id_estado, id_municipio, id_parroquia, calle, referencia)
        VALUES (:id_usuario, :id_pais , :id_estado, :id_municipio, :id_parroquia, :calle, :referencia)
        SQL;

        // insertar direccion
        $this->insert($query, $params);

        // query para insertar preguntas
        $query = <<<SQL
        INSERT INTO preguntas_seguridad(id_usuario, pregunta, respuesta)
        VALUES (:id_usuario, :pregunta, :respuesta)
        SQL;

        // insertar las preguntas
        for ($i = 1; $i <= 3; $i++) {
            // vaciar params
            $params = [];
            $params[] = [
                "nombre" => "id_usuario",
                "valor" => $id_usuario,
                "tipo" => PDO::PARAM_INT,
            ];
            $params[] = [
                "nombre" => "pregunta",
                "valor" => $datos["pregunta" . $i],
                "tipo" => PDO::PARAM_STR,
            ];
            $params[] = [
                "nombre" => "respuesta",
                "valor" => password_hash(
                    $datos["respuesta" . $i],
                    PASSWORD_DEFAULT,
                ),
                "tipo" => PDO::PARAM_STR,
            ];
            // insertar pregunta
            $this->insert($query, $params);
        }

        // finalizar transaccion y retornar resultado
        $resultado = $this->conexion->commit();
        if ($resultado) {
            http_response_code(201);
            return ["status" => 201];
        }

        http_response_code(500);
        return ["error" => "Ocurrió un error inesperado al crear el usuario"];
    }
}
