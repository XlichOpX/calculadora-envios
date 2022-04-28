<?php

class Respuesta
{
    public $status;
    public $msg;
    public $error;

    public function __construct($status = 200, $msg = "OK", $error = null)
    {
        $this->status = $status;
        $this->msg = $msg;
        $this->error = $error;

        return [
            "status" => $this->status,
            "msg" => $this->msg,
            "error" => $this->error,
        ];
    }
}
