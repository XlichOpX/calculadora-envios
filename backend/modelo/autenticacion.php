<?php

require_once "./modelo/conexion.php";
require_once "./utilidades/respuesta.php";

class Autenticacion extends Conexion
{
    // valida el los datos de acceso dados y genera
    // un token de acceso si son validos
    function iniciarSesion($datos)
    {
        // convertir el body a un array map de php
        $datos = json_decode($datos, true);

        $usuario = &$datos["usuario"];
        $clave = &$datos["clave"];

        // verifica que los datos esten completos
        if (!isset($usuario) || !isset($clave)) {
            $respuesta = new Respuesta;
            $respuesta->status400("Datos incompletos");
            return $respuesta;
        }

        // obtener los datos del usuario dado
        $datosUsuario = $this->obtenerDatosUsuario($usuario);

        // si existe el usuario, devuelve sus datos, si no, devuelve error
        if ($datosUsuario) {
            return $datosUsuario;
        } else {
            return "Error: no existe el usuario";
        }
    }

    // obtiene los datos del usuario dado
    // campos: id, clave
    private function obtenerDatosUsuario($usuario)
    {
        $query = "SELECT id, clave  FROM usuarios WHERE apodo = :usuario";
        $datos = $this->query($query, [":usuario" => $usuario]);

        // si existe el usuario, devuelve sus datos, si no, devuelve false
        if (isset($datos[0]["id"])) {
            return $datos;
        } else {
            return false;
        }
    }
}
