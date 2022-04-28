<?php

require "./modelo/Conexion.php";

class ModeloTransportes extends Conexion
{
    public function obtTransportes()
    {
        $query = <<<SQL
            SELECT id, nombre, tarifa, velocidad_promedio FROM transportes;
        SQL;

        $resultado = $this->query($query);

        return $resultado;
    }
}
