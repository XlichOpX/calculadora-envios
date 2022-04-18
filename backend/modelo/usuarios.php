<?php

require "./modelo/conexion.php";

class Usuarios extends Conexion
{
    function obtenerUsuario($id)
    {
        $query = "SELECT * FROM usuarios WHERE id = :id";
        return $this->query($query, [["nombre" => "id", "valor" => $id, "tipo" => PDO::PARAM_INT]]);
    }

    function obtenerUsuarios()
    {
        $query = "SELECT * FROM usuarios";
        return $this->query($query);
    }

    function crearUsuario($datos)
    {
        // datos requeridos
        $requeridos = [
            "correo_electronico" => PDO::PARAM_STR,
            "clave" => PDO::PARAM_STR,
            "nombre" => PDO::PARAM_STR,
            "apellido" => PDO::PARAM_STR,
            "cedula" => PDO::PARAM_STR,
            "fecha_nacimiento" => PDO::PARAM_STR
        ];

        // verifica que existan todos los datos requeridos
        foreach ($requeridos as $nombre => $tipo) {
            if (!isset($datos[$nombre])) {
                return "Error: datos incompletos";
            }
        }

        // aplicar hash a la clave antes de llevarla a la db
        $datos["clave"] = password_hash($datos["clave"], PASSWORD_DEFAULT);

        // crear array de params para la query
        foreach ($requeridos as $nombre => $tipo) {
            $params[] = ["nombre" => $nombre, "valor" => $datos[$nombre], "tipo" => $tipo];
        }

        $query = "INSERT INTO usuarios(correo_electronico, clave ,nombre, apellido, cedula, fecha_nacimiento) VALUES (:correo_electronico, :clave, :nombre, :apellido, :cedula, :fecha_nacimiento)";

        return $this->insert($query, $params);
    }
}
