<?php

require_once "./utilidades/Codificaciones.php";

function generarJWT($cabecera, $data, $clave_secreta)
{
    // codifica el contenido del token
    $cabecera_codificada = base64url_encode(json_encode($cabecera));
    $data_codificada = base64url_encode(json_encode($data));

    // genera la firma
    $firma = hash_hmac(
        "sha256",
        "$cabecera_codificada.$data_codificada",
        $clave_secreta,
        true,
    );
    $firma_codificada = base64url_encode($firma);

    $jwt = "$cabecera_codificada.$data_codificada.$firma_codificada";
    return $jwt;
}

function validarJWT($jwt, $clave_secreta)
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
        $clave_secreta,
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

function obtDataJWT($jwt)
{
    $payload = explode(".", $jwt)[1];
    $data = base64_decode($payload);
    return json_decode($data, true);
}
