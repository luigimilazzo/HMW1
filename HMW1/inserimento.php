<?php
require_once 'autenticazione.php';

    // Se la sessione è scaduta, esco
    if (!checkAuth()) exit;
    
    // Imposto l'header della risposta
    header('Content-Type: application/json');
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $query= "SELECT ID_penitenziario,Nome_penitenziario FROM carcere";
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    while($row=mysqli_fetch_assoc($result)){
        $array[]=$row;    
    }
    echo json_encode($array);
    mysqli_close($connessione);

?>