<?php

require_once "./modelo/Conexion.php";
require_once "./utilidades/JWTUtils.php";

class ModeloAutenticacion extends Conexion
{
    // valida el los datos de acceso dados y genera
    // un token de acceso si son validos
    // $datos es un array map con los datos de acceso del usuario
    function iniciarSesion($datos, $clave_secreta)
    {
        // verifica que los datos esten completos
        if (!isset($datos["usuario"]) || !isset($datos["clave"])) {
            return ["status" => 400, "error" => "Datos incompletos"];
        }

        // para legibilidad
        $usuario = &$datos["usuario"];
        $clave = &$datos["clave"];

        // obtener los datos del usuario dado
        $datosUsuario = $this->obtenerDatosUsuario($usuario);

        // si existe el usuario, devuelve sus datos, si no, devuelve error
        if ($datosUsuario && password_verify($clave, $datosUsuario["clave"])) {
            $jwt = generarJWT(
                ["alg" => "HS256", "typ" => "JWT"],
                [
                    "sub" => $datosUsuario["id"],
                    "name" => $datosUsuario["nombre"],
                    "exp" => time() + 60 * 60 * 24,
                ],
                $clave_secreta,
            );
            return $jwt;
        }
        return ["status" => 400, "error" => "Datos incorrectos"];
    }

    // obtiene los datos del usuario dado
    // campos: id, clave
    private function obtenerDatosUsuario($usuario)
    {
        $query = <<<SQL
        SELECT id, nombre, clave  FROM usuarios WHERE correo_electronico = :usuario
        SQL;
        $datos = $this->query($query, [
            [
                "nombre" => "usuario",
                "valor" => $usuario,
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        // si existe el usuario, devuelve sus datos, si no, devuelve false
        if (isset($datos[0]["id"])) {
            return $datos[0];
        }

        return false;
    }
}
