<?php
    /*******************************************************
        Controlla che i l'email sia unica
    ********************************************************/
    require_once 'configurazionedb.php';
    
    // Controllo che l'accesso sia legittimo
    if (!isset($_GET["q"])) {
        echo "Non dovresti essere qui";
        exit;
    }

    // Imposto l'header della risposta
    header('Content-Type: application/json');
    
    // Connessione al DB
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);

    // Leggo la stringa dell'email
    $email = mysqli_real_escape_string($connessione, $_GET["q"]);

    // Costruisco la query
    $query = "SELECT email FROM impiegato WHERE email = '$email'";

    // Eseguo la query
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));

    // Torna un JSON con chiave exists e valore boolean
    echo json_encode(array('exists' => mysqli_num_rows($result) > 0 ? true : false));

    // Chiudo la connessione
    mysqli_close($connessione);
?>