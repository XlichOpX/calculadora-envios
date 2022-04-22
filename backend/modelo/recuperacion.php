<?php
require_once "./modelo/conexion.php";

class Recuperacion extends Conexion
{
    function obtPreguntas($datos)
    {
        if (!isset($datos["correo"]) && $datos["correo"] != "") {
            return json_encode(["error" => "Datos incompletos"]);
        }

        $correo = &$datos["correo"];

        $query =
            "SELECT id, pregunta FROM preguntas_seguridad WHERE id_usuario = (SELECT id FROM usuarios WHERE correo_electronico = :correo)";
        $resultado = $this->query($query, [
            [
                "nombre" => "correo",
                "valor" => $correo,
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        return json_encode($resultado);
    }

    function validarRespuestas($datos)
    {
        $requerido = [
            "correo",
            "respuesta1",
            "respuesta2",
            "respuesta3",
            "nueva-clave",
        ];

        foreach ($requerido as $campo) {
            if (!isset($datos[$campo]) || $datos[$campo] == "") {
                return json_encode(["error" => "Datos incompletos"]);
            }
        }

        $respuestasCorrectas = $this->obtRespuestas($datos["correo"]);

        for ($i = 1; $i <= 3; $i++) {
            if (
                !password_verify(
                    $datos["respuesta$i"],
                    $respuestasCorrectas[$i - 1]["respuesta"]
                )
            ) {
                return json_encode(["error" => "Respuestas incorrectas"]);
            }
        }

        $query =
            "UPDATE usuarios SET clave = :clave WHERE correo_electronico = :correo";

        $this->insert($query, [
            [
                "nombre" => "clave",
                "valor" => password_hash(
                    $datos["nueva-clave"],
                    PASSWORD_DEFAULT
                ),
                "tipo" => PDO::PARAM_STR,
            ],
            [
                "nombre" => "correo",
                "valor" => $datos["correo"],
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        return json_encode([true, $datos]);
    }

    function obtRespuestas($correo)
    {
        $query =
            "SELECT respuesta FROM preguntas_seguridad WHERE id_usuario = (SELECT id FROM usuarios WHERE correo_electronico = :correo)";
        $resultado = $this->query($query, [
            [
                "nombre" => "correo",
                "valor" => $correo,
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        return $resultado;
    }
}
