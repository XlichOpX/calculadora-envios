<?php

class Conexion
{
    private $datos_conexion;
    private $conexion;

    function __construct()
    {
        // obtener datos de la conexion desde el archivo config
        $this->datos_conexion = file_get_contents("config");
        // transformarlos a un array map
        $this->datos_conexion = json_decode($this->datos_conexion, true)["conexion"];

        // string con la informacion requerida para conectar a la BD
        $dsn = "mysql:
            host={$this->datos_conexion['host']};
            port={$this->datos_conexion['port']};
            dbname={$this->datos_conexion['database']};
            charset=utf8";

        // intenta crear la conexion a la BD con los datos
        // o muestra el error si ocurre alguno
        try {
            $this->conexion = new PDO(
                $dsn,
                $this->datos_conexion['user'],
                $this->datos_conexion['password']
            );
        } catch (PDOException $err) {
            echo "Error: {$err->getMessage()}";
        }
    }

    // metodo base para obtener filas de la BD
    // recibe un array de parametros nombrados en la forma
    // ":nombre" => "valor"
    // donde ":nombre" debe ser un placeholder valido
    // en la queryString
    function query(string $query, $params = [])
    {
        $stmt = $this->conexion->prepare($query);

        // bindear los parametros dados a la query
        foreach ($params as $key => $value) {
            $stmt->bindParam($key, $value);
        }

        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // metodo base para realizar inserts
    function insert(string $query, $params = [])
    {
        $stmt = $this->conexion->prepare($query);

        // bindear los parametros dados a la query
        foreach ($params as $key => $value) {
            $stmt->bindParam($key, $value);
        }

        $stmt->execute();
        return $this->conexion->lastInsertId();
    }
}
