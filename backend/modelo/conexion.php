<?php

class Conexion
{
    private $datos_conexion;
    protected $conexion;

    function __construct()
    {
        // obtener datos de la conexion desde el archivo config
        $this->datos_conexion = file_get_contents("config");
        // transformarlos a un array map
        $this->datos_conexion = json_decode($this->datos_conexion, true)[
            "conexion"
        ];

        // string con la informacion requerida para conectar a la BD
        $dsn = "mysql:
            host={$this->datos_conexion["host"]};
            port={$this->datos_conexion["port"]};
            dbname={$this->datos_conexion["database"]};
            charset=utf8";

        // intenta crear la conexion a la BD con los datos
        // o muestra el error si ocurre alguno
        try {
            $this->conexion = new PDO($dsn, $this->datos_conexion["user"]);
        } catch (PDOException $err) {
            echo "Error: {$err->getMessage()}";
        }
    }

    // metodo base para obtener filas de la BD
    // recibe un array de arrays donde cada uno es un
    // array map de la forma
    // ["nombre" => "nombre", "valor" => "valor", "tipo" => "tipo"]
    // donde nombre es el placeholder en la query y tipo es una de las constantes
    // PDO::PARAM_*
    function query(string $query, $params = [])
    {
        $stmt = $this->conexion->prepare($query);

        // bindear los parametros dados a la query
        foreach ($params as $param) {
            $stmt->bindParam($param["nombre"], $param["valor"], $param["tipo"]);
        }

        if ($stmt->execute()) {
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (count($result) > 0) {
                return $result;
            }
            return false;
        }

        return false;
    }

    // metodo base para realizar inserts
    function insert(string $query, $params = [])
    {
        $stmt = $this->conexion->prepare($query);

        // bindear los parametros dados a la query
        foreach ($params as $param) {
            $stmt->bindParam($param["nombre"], $param["valor"], $param["tipo"]);
        }

        if ($stmt->execute()) {
            return $this->conexion->lastInsertId();
        }

        return false;
    }
}
