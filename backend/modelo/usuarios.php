<?php

require "./modelo/conexion.php";

class Usuarios extends Conexion
{
    function obtenerUsuario($id)
    {
        $query = "SELECT * FROM usuarios WHERE id = :id";
        return $this->query($query, [":id" => $id]);
    }

    function obtenerUsuarios()
    {
        $query = "SELECT * FROM usuarios";
        return $this->query($query);
    }

    function crearUsuario($datos)
    {
        $query = "
            INSERT INTO usuarios(
                apodo,
                correo_electronico,
                clave,
                prefijo_clave,
                nombre,
                apellido,
                cedula,
                fecha_nacimiento
            )
            VALUES(
                :apodo,
                :correo_electronico,
                :clave,
                :prefijo_clave,
                :nombre,
                :apellido,
                :cedula,
                :fecha_nacimiento,
                :activo,
            )";

        return $this->insert($query, $datos);
    }
}
