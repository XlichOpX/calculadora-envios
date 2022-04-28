<?php

require "./modelo/Conexion.php";

class ModeloUbicaciones extends Conexion
{
    public function obtUbicaciones()
    {
        $query = <<<SQL
            SELECT id, nombre, x, y FROM ubicaciones;
        SQL;

        $resultado = $this->query($query);

        return $resultado;
    }
}
