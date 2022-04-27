<?php

require "./modelo/Conexion.php";
require "./utilidades/codificaciones.php";

class ModeloAutenticacion extends Conexion
{
    private $clave_secreta = "ej6BMi3XpbY3bT85wOKjWq3Dzi9ewV6P";

    // valida el los datos de acceso dados y genera
    // un token de acceso si son validos
    // $datos es un array map con los datos de acceso del usuario
    function iniciarSesion($datos)
    {
        // verifica que los datos esten completos
        if (!isset($datos["usuario"]) || !isset($datos["clave"])) {
            $respuesta = new Respuesta();
            return $respuesta->status400("Datos incompletos");
        }

        // para legibilidad
        $usuario = &$datos["usuario"];
        $clave = &$datos["clave"];

        // obtener los datos del usuario dado
        $datosUsuario = $this->obtenerDatosUsuario($usuario);

        // si existe el usuario, devuelve sus datos, si no, devuelve error
        if ($datosUsuario && password_verify($clave, $datosUsuario["clave"])) {
            $jwt = $this->generarJWT(
                ["alg" => "HS256", "typ" => "JWT"],
                [
                    "sub" => $datosUsuario["id"],
                    "name" => $datosUsuario["nombre"],
                    "exp" => time() + 60 * 60 * 24,
                ],
            );
            return $jwt;
        }
        return false;
    }

    // obtiene los datos del usuario dado
    // campos: id, clave
    private function obtenerDatosUsuario($usuario)
    {
        $query = <<<SQL
        SELECT id, nombre, clave  FROM usuarios WHERE correo_electronico = :usuario
        SQL;
        $datos = $this->query($query, [
            [
                "nombre" => "usuario",
                "valor" => $usuario,
                "tipo" => PDO::PARAM_STR,
            ],
        ]);

        // si existe el usuario, devuelve sus datos, si no, devuelve false
        if (isset($datos[0]["id"])) {
            return $datos[0];
        }

        return false;
    }

    // genera un jwt en base a los datos dados y a la clave secreta
    private function generarJWT($cabecera, $data)
    {
        // codifica el contenido del token
        $cabecera_codificada = base64url_encode(json_encode($cabecera));
        $data_codificada = base64url_encode(json_encode($data));

        // genera la firma
        $firma = hash_hmac(
            "sha256",
            "$cabecera_codificada.$data_codificada",
            $this->clave_secreta,
            true,
        );
        $firma_codificada = base64url_encode($firma);

        $jwt = "$cabecera_codificada.$data_codificada.$firma_codificada";
        return $jwt;
    }

    // valida el jwt dado en base a la clave secreta
    function validarJWT($jwt)
    {
        // divide el contenido del token
        $partes_token = explode(".", $jwt);
        $cabecera = base64url_decode($partes_token[0]);
        $data = base64url_decode($partes_token[1]);
        $firma_provista = $partes_token[2];

        // revisa la fecha de vencimiento del token
        $vencimiento = json_decode($data)->exp;
        $token_vencido = $vencimiento - time() < 0;

        // generar firma en base a la cabecera y data del token con la clave secreta
        $cabecera_codificada = base64url_encode($cabecera);
        $data_codificada = base64url_encode($data);
        $firma = hash_hmac(
            "sha256",
            "$cabecera_codificada.$data_codificada",
            $this->clave_secreta,
            true,
        );
        $firma_codificada = base64url_encode($firma);

        // verificar que la firma generada y la firma provista en el token son iguales
        $firma_valida = $firma_codificada === $firma_provista;

        if ($token_vencido || !$firma_valida) {
            return false;
        } else {
            return true;
        }
    }
}
