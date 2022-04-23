<?php
function base64url_encode($string)
{
    return rtrim(strtr(base64_encode($string), "+/", "-_"), "=");
}

function base64url_decode($string)
{
    return base64_decode(
        str_pad(
            strtr($string, "-_", "+/"),
            strlen($string) % 4,
            "=",
            STR_PAD_RIGHT,
        ),
    );
}
