<?php
require_once 'autenticazione.php';

    // Se la sessione è scaduta, esco
    if (!checkAuth()) exit;
    
    // Imposto l'header della risposta
    header('Content-Type: application/json');
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $idP=$_GET['IDp'];
    $testo=mysqli_real_escape_string($connessione,$_GET['q']);
    $username=mysqli_real_escape_string($connessione,$_GET['us']);
    $query= "INSERT into commenti(testo,username,carcere) values('$testo','$username',$idP)";
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    echo $result;
    mysqli_close($connessione);
?>