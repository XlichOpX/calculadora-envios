<?php

require "./modelo/conexion.php";

class Estados extends Conexion
{
    function obtEstados()
    {
        $query = <<<SQL
        SELECT id_estado, estado FROM estados;
        SQL;

        $resultado = $this->query($query);

        return $resultado;
    }
}
