<?php

header("Access-Control-Allow-Origin: http://calc-envios.localhost");
header("Access-Control-Allow-Credentials: true");

require_once "./modelo/autenticacion.php";
$autenticacion = new Autenticacion();

// si la request es post, se procesa
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // si existe una cookie con el token
    if (isset($_COOKIE["jwt_token"])) {
        // verificar la validez del mismo
        $respuesta = $autenticacion->validarJWT($_COOKIE["jwt_token"]);

        // si es valido, devuelve true
        if ($respuesta) {
            echo json_encode(true);
            exit();
        }

        // si es falso, borra la cookie y devuelve false
        setcookie("jwt_token", "", 1, "/", ".calc-envios.localhost");
        echo json_encode(false);
        exit();
    }

    // obtener el body de la request y pasarlo a un array map
    $body = json_decode(file_get_contents("php://input"), true);

    // valida los datos y genera un token
    $respuestaJwt = $autenticacion->iniciarSesion($body);

    if ($respuestaJwt) {
        setcookie(
            "jwt_token",
            $respuestaJwt,
            time() + 60 * 60 * 24,
            "/",
            ".calc-envios.localhost",
        );
        echo json_encode(true);
        exit();
    }

    echo json_encode(false);
    exit();
}

echo "metodo no permitido";
