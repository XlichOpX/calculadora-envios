<?php

class Respuesta
{
    private $respuesta = [
        "status" => "",
        "resultado" => []
    ];

    function status200()
    {
        $this->respuesta["status"] = "200 OK";
        $this->respuesta["resultado"] = [
            "codigo" => "200",
            "msj" => "OK"
        ];
        return $this->respuesta;
    }

    function status201()
    {
        $this->respuesta["status"] = "201 Created";
        $this->respuesta["resultado"] = [
            "codigo" => "201",
            "msj" => "Created"
        ];
        return $this->respuesta;
    }

    function status400($msj = "Bad Request")
    {
        $this->respuesta["status"] = "400 Bad Request";
        $this->respuesta["resultado"] = [
            "codigo" => "400",
            "msj" => $msj
        ];
        return $this->respuesta;
    }

    function status401()
    {
        $this->respuesta["status"] = "401 Unauthorized";
        $this->respuesta["resultado"] = [
            "codigo" => "401",
            "msj" => "Unauthorized"
        ];
        return $this->respuesta;
    }

    function status403()
    {
        $this->respuesta["status"] = "403 Forbbiden";
        $this->respuesta["resultado"] = [
            "codigo" => "403",
            "msj" => "Forbbiden"
        ];
        return $this->respuesta;
    }

    function status404()
    {
        $this->respuesta["status"] = "404 Not Found";
        $this->respuesta["resultado"] = [
            "codigo" => "404",
            "msj" => "Not Found"
        ];
        return $this->respuesta;
    }
}
