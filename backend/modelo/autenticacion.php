<?php

require_once "./modelo/conexion.php";
require_once "./utilidades/respuesta.php";

class Autenticacion extends Conexion
{
    // valida el los datos de acceso dados y genera
    // un token de acceso si son validos
    // $datos es un array map con los datos de acceso del usuario
    function iniciarSesion($datos)
    {
        // verifica que los datos esten completos
        if (!isset($datos["usuario"]) || !isset($datos["clave"])) {
            $respuesta = new Respuesta;
            return $respuesta->status400("Datos incompletos");;
        }

        // para legibilidad
        $usuario = &$datos["usuario"];
        $clave = &$datos["clave"];

        // obtener los datos del usuario dado
        $datosUsuario = $this->obtenerDatosUsuario($usuario);

        // si existe el usuario, devuelve sus datos, si no, devuelve error
        if ($datosUsuario && password_verify($clave, $datosUsuario["clave"])) {
            return $datosUsuario;
        }

        return "Los datos de acceso no son correctos";
    }

    // obtiene los datos del usuario dado
    // campos: id, clave
    private function obtenerDatosUsuario($usuario)
    {
        $query = "SELECT id, clave  FROM usuarios WHERE correo_electronico = :usuario";
        $datos = $this->query($query, [["nombre" => "usuario", "valor" => $usuario, "tipo" => PDO::PARAM_STR]]);

        // si existe el usuario, devuelve sus datos, si no, devuelve false
        if (isset($datos[0]["id"])) {
            return $datos[0];
        }

        return false;
    }
}
