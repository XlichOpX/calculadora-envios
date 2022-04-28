<?php
require_once "./modelo/Conexion.php";

class ModeloRecuperacion extends Conexion
{
    // devuelve las preguntas de un usuario
    function obtPreguntas($datos)
    {
        // si no se especifica el correo, devuelve un error
        if (!isset($datos["correo"]) && $datos["correo"] != "") {
            http_response_code(404);
            return ["error" => "Datos incompletos."];
        }

        // para legibilidad
        $correo = &$datos["correo"];

        // query que obtiene las preguntas
        $query = <<<SQL
        SELECT id, pregunta FROM preguntas_seguridad
        WHERE id_usuario = (SELECT id FROM usuarios WHERE correo_electronico = :correo)
        SQL;

        // realizar la query y almacenar el resultado
        $resultado = $this->query($query, [
            [
                "nombre" => "correo",
                "valor" => $correo,
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        // si se obtienen preguntas las envia
        if (count($resultado) > 0) {
            http_response_code(200);
            return $resultado;
        }

        // si no se encuentra envia error
        http_response_code(404);
        return ["error" => "Correo no encontrado"];
    }

    function validarRespuestas($datos)
    {
        // datos requeridos para proceder con la validacion
        $requerido = [
            "correo",
            "respuesta1",
            "respuesta2",
            "respuesta3",
            "nueva-clave",
        ];

        // validar que existan los datos
        foreach ($requerido as $campo) {
            if (!isset($datos[$campo]) || $datos[$campo] == "") {
                // si algun dato no llega, devolver error 400
                http_response_code(400);
                return ["error" => "Datos incompletos"];
            }
        }

        // obtener las respuestas
        $respuestasCorrectas = $this->obtRespuestas($datos["correo"]);

        // ir verificando cada respuesta dada por el usuario
        // contra los hashes almacenados en la db
        for ($i = 1; $i <= 3; $i++) {
            if (
                !password_verify(
                    $datos["respuesta$i"],
                    $respuestasCorrectas[$i - 1]["respuesta"],
                )
            ) {
                // si alguna respuesta es incorrecta, devuelve el error
                http_response_code(400);
                return ["error" => "Respuestas incorrectas"];
            }
        }

        // query para cambiar la contraseña
        $query = <<<SQL
        UPDATE usuarios SET clave = :clave
        WHERE correo_electronico = :correo
        SQL;

        // ejecutar el cambio de clave
        $this->insert($query, [
            [
                "nombre" => "clave",
                "valor" => password_hash(
                    $datos["nueva-clave"],
                    PASSWORD_DEFAULT,
                ),
                "tipo" => PDO::PARAM_STR,
            ],
            [
                "nombre" => "correo",
                "valor" => $datos["correo"],
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        // si todo va bien, envia un estatus OK
        http_response_code(200);
        return ["status" => 200];
    }

    // obtener las respuestas hasheadas de la db para
    // confirmar las respuestas dadas por el usuario
    function obtRespuestas($correo)
    {
        // query para obtener las respuestas
        $query = <<<'SQL'
        SELECT respuesta FROM preguntas_seguridad
        WHERE id_usuario = (SELECT id FROM usuarios WHERE correo_electronico = :correo)
        SQL;

        // ejecutar la query
        $resultado = $this->query($query, [
            [
                "nombre" => "correo",
                "valor" => $correo,
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        // devuelve el array de respuestas
        return $resultado;
    }
}
