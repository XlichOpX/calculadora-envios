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

        // verifica que existan todos los datos requeridos
        foreach ($requeridos_usuario as $nombre => $tipo) {
            if (!isset($datos[$nombre])) {
                return "Error: datos incompletos"  . $nombre;
            }
        }

        // verifica que existan todos los datos requeridos
        foreach ($requeridos_direccion as $nombre => $tipo) {
            if (!isset($datos[$nombre])) {
                return "Error: datos incompletos: " . $nombre;
            }
        }

        // aplicar hash a la clave antes de llevarla a la db
        $datos["clave"] = password_hash($datos["clave"], PASSWORD_DEFAULT);

        // crear array de params para la query
        foreach ($requeridos_usuario as $nombre => $tipo) {
            $params[] = ["nombre" => $nombre, "valor" => $datos[$nombre], "tipo" => $tipo];
        }

        // query para insertar usuario
        $query = "INSERT INTO usuarios(correo_electronico, clave ,nombre, apellido, cedula, fecha_nacimiento, telefono) VALUES (:correo_electronico, :clave, :nombre, :apellido, :cedula, :fecha_nacimiento, :telefono)";

        // comenzar transaccion
        $this->conexion->beginTransaction();
        $id_usuario = $this->insert($query, $params);

        // vaciar params
        $params = [];
        // agg el usuario a los params
        $params[] = ["nombre" => "id_usuario", "valor" => $id_usuario, "tipo" => PDO::PARAM_INT];
        // crear array de params para el insert de direccion
        foreach ($requeridos_direccion as $nombre => $tipo) {
            $params[] = ["nombre" => $nombre, "valor" => $datos[$nombre], "tipo" => $tipo];
        }

        // query para insertar direccion
        $query = "INSERT INTO direcciones(id_usuario, id_pais , id_estado, id_municipio, id_parroquia, calle, referencia) VALUES (:id_usuario, :id_pais , :id_estado, :id_municipio, :id_parroquia, :calle, :referencia)";

        // insertar direccion
        $this->insert($query, $params);

        // finalizar transaccion y retornar resultado
        return $this->conexion->commit();
    }
}
