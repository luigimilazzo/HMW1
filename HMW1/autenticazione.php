<?php
/********************************************************
       Controlla che l'utente sia già autenticato, per non 
       dover chiedere il login ad ogni volta               
    *********************************************************/
    require_once 'configurazionedb.php';
    session_start();

    function checkAuth() {
        // Se esiste già una sessione, la ritorno, altrimenti ritorno 0
        if(isset($_SESSION['prigioniUserId'])) {
            return $_SESSION['prigioniUserId'];
        } else 
            return 0;
    }
?>